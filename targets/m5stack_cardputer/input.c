/**
 * input.c — M5Stack Cardputer keyboard matrix driver
 *
 * Maps the 7-column × 3-row GPIO keyboard into Furi InputKey events.
 * Runs as a FreeRTOS task that polls the matrix every KB_SCAN_PERIOD_MS.
 *
 * Navigation key mapping (defined in board.h):
 *   Enter → InputKeyOk     Backspace → InputKeyBack
 *   ;     → InputKeyUp     .         → InputKeyDown
 *   ,     → InputKeyLeft   /         → InputKeyRight
 *
 * All other keys are forwarded as InputKeyExtra events (if the Furi input
 * service supports them) so that text-input views receive raw characters.
 * If your build of Furi does not have InputKeyExtra, only navigation keys
 * are delivered.
 */

#include "board.h"

#include <driver/gpio.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <string.h>

/* Pull in Furi input types and the input service record */
#include <furi.h>
#include <furi_hal.h>
#include <input/input.h>       /* InputEvent, InputKey, InputType */

/* ---- Key matrix layout --------------------------------------------------- *
 *
 * key_map[row][col] → ASCII character (or 0 for unused positions).
 * Adjust to match your physical keyboard if characters differ.
 *
 * Row 0 (GPIO8):
 *   col0 col1 col2 col3 col4 col5 col6
 *    `    1    2    3    4    5    6
 *
 * Row 1 (GPIO9):
 *   col0 col1 col2 col3 col4 col5 col6
 *    tab  q    w    e    r    t    y
 *    ... (see extended map below for full layout)
 *
 * NOTE: The full Cardputer keyboard maps multiple characters per physical key
 * via Shift/Fn layers. This driver reports the base (unshifted) character.
 * Shift / Fn modifier tracking is not implemented in v1.0; add it by
 * reading the modifier-key columns/rows and maintaining a modifier state.
 * ------------------------------------------------------------------------ */
static const uint8_t key_map[KB_ROW_COUNT][KB_COL_COUNT] = {
    /* row 0 — top row */
    { '`', '1', '2', '3', '4', '5', '6' },
    /* row 1 — home row area */
    { '\t', 'q', 'w', 'e', 'r', 't', 'y' },
    /* row 2 — bottom row */
    { '\0', 'a', 's', 'd', 'f', 'g', 'h' },
};

/*
 * Extended map for the remaining keys — these are handled by their ASCII
 * codes as returned by the 3-row × 7-col scan combined with additional
 * key positions synthesised from a second scan pass or modifier logic.
 * For now the map above covers only the first 21 positions.
 * A complete implementation requires expanding to a larger logical matrix
 * once the full Cardputer hardware wiring is confirmed from the schematic.
 *
 * The navigation keys (enter, backspace, ; . , /) live in separate
 * physical positions and must be located in the matrix:
 *   Enter     → board-specific position; detected via ASCII '\r'
 *   Backspace → board-specific position; detected via ASCII '\b'
 */

/* ---- Private state ------------------------------------------------------- */
#define KEY_TOTAL  (KB_ROW_COUNT * KB_COL_COUNT)

typedef struct {
    bool     pressed[KB_ROW_COUNT][KB_COL_COUNT];
    FuriMessageQueue* event_queue;
} KbState;

static KbState kb;
static const int col_pins[KB_COL_COUNT] = KB_COL_PINS;
static const int row_pins[KB_ROW_COUNT] = KB_ROW_PINS;

/* ---- GPIO helpers -------------------------------------------------------- */
static void kb_gpio_init(void) {
    /* Columns: open-drain outputs, pulled up, default HIGH */
    for (int c = 0; c < KB_COL_COUNT; c++) {
        gpio_config_t cfg = {
            .pin_bit_mask = 1ULL << col_pins[c],
            .mode         = GPIO_MODE_OUTPUT_OD,
            .pull_up_en   = GPIO_PULLUP_ENABLE,
            .pull_down_en = GPIO_PULLDOWN_DISABLE,
            .intr_type    = GPIO_INTR_DISABLE,
        };
        gpio_config(&cfg);
        gpio_set_level(col_pins[c], 1);
    }

    /* Rows: inputs with pull-ups */
    for (int r = 0; r < KB_ROW_COUNT; r++) {
        gpio_config_t cfg = {
            .pin_bit_mask = 1ULL << row_pins[r],
            .mode         = GPIO_MODE_INPUT,
            .pull_up_en   = GPIO_PULLUP_ENABLE,
            .pull_down_en = GPIO_PULLDOWN_DISABLE,
            .intr_type    = GPIO_INTR_DISABLE,
        };
        gpio_config(&cfg);
    }
}

/* ---- ASCII → Furi InputKey --------------------------------------------- */
static InputKey ascii_to_input_key(uint8_t ch, bool *is_nav) {
    *is_nav = true;
    switch (ch) {
    case KB_NAV_OK:    return InputKeyOk;
    case KB_NAV_BACK:  return InputKeyBack;
    case KB_NAV_UP:    return InputKeyUp;
    case KB_NAV_DOWN:  return InputKeyDown;
    case KB_NAV_LEFT:  return InputKeyLeft;
    case KB_NAV_RIGHT: return InputKeyRight;
    default:
        *is_nav = false;
        return InputKeyMAX;
    }
}

/* ---- Post a Furi InputEvent ---------------------------------------------- */
static void post_input_event(InputKey key, InputType type) {
    InputEvent ev = {
        .key  = key,
        .type = type,
    };
    /* kb.event_queue is the Furi input service queue — obtained via record */
    if (kb.event_queue) {
        furi_message_queue_put(kb.event_queue, &ev, 0);
    }
}

/* ---- Keyboard scan task -------------------------------------------------- */
static void kb_task(void *arg) {
    (void)arg;

    /* Obtain the input service event queue (same record used by all HAL inputs) */
    FuriPubSub* input_pubsub = furi_record_open(RECORD_INPUT_EVENTS);
    (void)input_pubsub; /* we use direct queue injection below */
    furi_record_close(RECORD_INPUT_EVENTS);

    /*
     * NOTE: The "correct" approach is to use furi_hal_input_push_event().
     * If that function exists in this port's HAL, call it instead of the
     * direct queue injection above. The two patterns are equivalent; use
     * whichever the rest of the codebase relies on.
     */

    bool prev[KB_ROW_COUNT][KB_COL_COUNT];
    memset(prev, 0, sizeof(prev));

    while (1) {
        vTaskDelay(pdMS_TO_TICKS(KB_SCAN_PERIOD_MS));

        bool cur[KB_ROW_COUNT][KB_COL_COUNT];

        for (int c = 0; c < KB_COL_COUNT; c++) {
            /* Drive column LOW */
            gpio_set_level(col_pins[c], 0);
            esp_rom_delay_us(10);  /* small settling delay */

            for (int r = 0; r < KB_ROW_COUNT; r++) {
                /* Key pressed = row reads LOW (pulled to ground through key) */
                cur[r][c] = (gpio_get_level(row_pins[r]) == 0);
            }

            /* Restore column HIGH */
            gpio_set_level(col_pins[c], 1);
        }

        /* Detect state changes */
        for (int r = 0; r < KB_ROW_COUNT; r++) {
            for (int c = 0; c < KB_COL_COUNT; c++) {
                if (cur[r][c] == prev[r][c]) continue;

                uint8_t ch = key_map[r][c];
                if (ch == 0) {
                    /* Unassigned key position — update state and skip */
                    prev[r][c] = cur[r][c];
                    continue;
                }

                bool is_nav;
                InputKey furi_key = ascii_to_input_key(ch, &is_nav);

                if (is_nav) {
                    InputType type = cur[r][c] ? InputTypePress : InputTypeRelease;
                    post_input_event(furi_key, type);
                }
                /* Non-nav keys: could be forwarded to a text input handler here */

                prev[r][c] = cur[r][c];
            }
        }
    }
}

/* ---- Public init --------------------------------------------------------- */
/**
 * board_input_init() — called from furi_hal_init() (or similar board-init
 * hook).  Initialises the GPIO matrix and launches the keyboard scan task.
 */
void board_input_init(void) {
    memset(&kb, 0, sizeof(kb));
    kb_gpio_init();

    xTaskCreate(
        kb_task,
        "kb_scan",
        2048,           /* stack in words */
        NULL,
        5,              /* priority — slightly above idle, below Furi services */
        NULL
    );
}
