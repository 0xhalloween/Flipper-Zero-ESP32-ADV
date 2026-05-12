/**
 * @file target_input.c
 * Input driver for M5Stack Cardputer — 7×7 GPIO matrix keyboard.
 *
 * The Cardputer has 49 physical keys arranged in a 7-row × 7-column matrix:
 *
 *   Row output pins (driven LOW one at a time):
 *     ROW0=GPIO8, ROW1=GPIO9, ROW2=GPIO11, ROW3=GPIO13,
 *     ROW4=GPIO15, ROW5=GPIO3, ROW6=GPIO4
 *
 *   Column input pins (pull-up enabled; read 0 = key pressed):
 *     COL0=GPIO5, COL1=GPIO6, COL2=GPIO7, COL3=GPIO42,
 *     COL4=GPIO41, COL5=GPIO40, COL6=GPIO39
 *
 * Six keys are mapped to the six Flipper navigation inputs:
 *
 *   Flipper key   Physical key   Row   Col   GPIO row / GPIO col
 *   -----------   ------------   ---   ---   -------------------
 *   InputKeyOk    Enter          4     6     GPIO15 / GPIO39
 *   InputKeyBack  Escape         0     0     GPIO8  / GPIO5
 *   InputKeyUp    ↑ arrow        6     4     GPIO4  / GPIO41
 *   InputKeyDown  ↓ arrow        6     3     GPIO4  / GPIO42
 *   InputKeyLeft  ← arrow        6     5     GPIO4  / GPIO40
 *   InputKeyRight → arrow        6     6     GPIO4  / GPIO39
 *
 * ⚠  VERIFY ON HARDWARE: exact key positions vary by unit revision.
 *    Adjust NAV_KEY_*_ROW / NAV_KEY_*_COL below if your layout differs.
 *    The tool tools/cardputer_key_probe/ can help you identify positions.
 *
 * SD card / keyboard GPIO conflict:
 *   COL5=GPIO40 and COL6=GPIO39 are also used for SD MOSI/MISO on SPI3.
 *   furi_hal_sd.c initialises the SD bus once at boot before the input
 *   driver starts.  When SD is active the SPI3 peripheral owns those pins
 *   and the column reads will float (pullup keeps them high = no phantom
 *   keypress).  This is safe because the input poll task yields to FreeRTOS
 *   between scans and the SPI transfer is atomic from the SD driver's lock.
 */

#include "target_input.h"

#include <boards/board.h>
#include <driver/gpio.h>
#include <esp_err.h>
#include <esp_log.h>
#include <furi.h>

#define TAG "InputCardputer"

/* ---- Timing ---- */
#define INPUT_DEBOUNCE_POLLS    3U
#define INPUT_LONG_PRESS_MS     500U
#define INPUT_REPEAT_MS         200U
/* Column settle delay after driving a row LOW (µs) */
#define ROW_SETTLE_US           10U

/* ---- Navigation key matrix positions ---- */
/* Adjust these (row_index, col_index) values if needed.               */
/* Row index 0–6 maps to BOARD_KB_ROW0–ROW6.                          */
/* Col index 0–6 maps to BOARD_KB_COL0–COL6.                          */
#define NAV_KEY_OK_ROW      4   /* Enter  — ROW4=GPIO15 */
#define NAV_KEY_OK_COL      6   /* Enter  — COL6=GPIO39 */

#define NAV_KEY_BACK_ROW    0   /* Escape — ROW0=GPIO8  */
#define NAV_KEY_BACK_COL    0   /* Escape — COL0=GPIO5  */

#define NAV_KEY_UP_ROW      6   /* ↑ arrow — ROW6=GPIO4  */
#define NAV_KEY_UP_COL      4   /* ↑ arrow — COL4=GPIO41 */

#define NAV_KEY_DOWN_ROW    6   /* ↓ arrow — ROW6=GPIO4  */
#define NAV_KEY_DOWN_COL    3   /* ↓ arrow — COL3=GPIO42 */

#define NAV_KEY_LEFT_ROW    6   /* ← arrow — ROW6=GPIO4  */
#define NAV_KEY_LEFT_COL    5   /* ← arrow — COL5=GPIO40 */

#define NAV_KEY_RIGHT_ROW   6   /* → arrow — ROW6=GPIO4  */
#define NAV_KEY_RIGHT_COL   6   /* → arrow — COL6=GPIO39 */

/* ---- Hardware pin arrays ---- */
static const gpio_num_t kb_row_pins[BOARD_KB_ROW_COUNT] = {
    BOARD_KB_ROW0, BOARD_KB_ROW1, BOARD_KB_ROW2, BOARD_KB_ROW3,
    BOARD_KB_ROW4, BOARD_KB_ROW5, BOARD_KB_ROW6,
};

static const gpio_num_t kb_col_pins[BOARD_KB_COL_COUNT] = {
    BOARD_KB_COL0, BOARD_KB_COL1, BOARD_KB_COL2, BOARD_KB_COL3,
    BOARD_KB_COL4, BOARD_KB_COL5, BOARD_KB_COL6,
};

/* ---- Nav key descriptor (compile-time table) ---- */
typedef struct {
    uint8_t   row;
    uint8_t   col;
    InputKey  flipper_key;
} NavKey;

static const NavKey nav_keys[] = {
    { NAV_KEY_OK_ROW,    NAV_KEY_OK_COL,    InputKeyOk    },
    { NAV_KEY_BACK_ROW,  NAV_KEY_BACK_COL,  InputKeyBack  },
    { NAV_KEY_UP_ROW,    NAV_KEY_UP_COL,    InputKeyUp    },
    { NAV_KEY_DOWN_ROW,  NAV_KEY_DOWN_COL,  InputKeyDown  },
    { NAV_KEY_LEFT_ROW,  NAV_KEY_LEFT_COL,  InputKeyLeft  },
    { NAV_KEY_RIGHT_ROW, NAV_KEY_RIGHT_COL, InputKeyRight },
};
#define NAV_KEY_COUNT (sizeof(nav_keys) / sizeof(nav_keys[0]))

/* ---- Per-key debounce & timing state ---- */
typedef struct {
    bool     raw_pressed;
    bool     debounced_pressed;
    uint8_t  debounce_polls;
    uint32_t press_started_at;
    bool     long_press_sent;
    uint32_t last_repeat_at;
} KeyState;

static KeyState key_states[NAV_KEY_COUNT];

/* ---- Internal helpers ---- */

static void input_publish(
    FuriPubSub* pubsub,
    InputKey    key,
    InputType   type,
    uint32_t    sequence)
{
    InputEvent event = {
        .sequence_source  = INPUT_SEQUENCE_SOURCE_HARDWARE,
        .sequence_counter = sequence,
        .key              = key,
        .type             = type,
    };
    furi_pubsub_publish(pubsub, &event);
}

static void input_emit_short(FuriPubSub* pubsub, InputKey key, uint32_t sequence) {
    input_publish(pubsub, key, InputTypePress,   sequence);
    input_publish(pubsub, key, InputTypeShort,   sequence);
    input_publish(pubsub, key, InputTypeRelease, sequence);
}

/**
 * Scan one row and return a bitmask of pressed columns (bit N = col N pressed).
 */
static uint8_t scan_row(uint8_t row_idx) {
    /* Drive the selected row LOW; all others remain HIGH (INPUT_ONLY / floating) */
    gpio_set_direction(kb_row_pins[row_idx], GPIO_MODE_OUTPUT);
    gpio_set_level(kb_row_pins[row_idx], 0);

    /* Give columns time to settle */
    esp_rom_delay_us(ROW_SETTLE_US);

    uint8_t mask = 0;
    for(uint8_t c = 0; c < BOARD_KB_COL_COUNT; c++) {
        if(gpio_get_level(kb_col_pins[c]) == 0) {
            mask |= (1u << c);
        }
    }

    /* Release the row (high-impedance) */
    gpio_set_direction(kb_row_pins[row_idx], GPIO_MODE_INPUT);

    return mask;
}

/* ---- Public interface ---- */

void target_input_init(void) {
    /* Configure all row pins as inputs initially (we'll drive them low one
     * at a time during scanning) */
    for(uint8_t r = 0; r < BOARD_KB_ROW_COUNT; r++) {
        gpio_config_t cfg = {
            .pin_bit_mask = (1ULL << kb_row_pins[r]),
            .mode         = GPIO_MODE_INPUT,
            .pull_up_en   = GPIO_PULLUP_DISABLE,
            .pull_down_en = GPIO_PULLDOWN_DISABLE,
            .intr_type    = GPIO_INTR_DISABLE,
        };
        ESP_ERROR_CHECK(gpio_config(&cfg));
    }

    /* Configure all column pins as inputs with pull-ups */
    for(uint8_t c = 0; c < BOARD_KB_COL_COUNT; c++) {
        gpio_config_t cfg = {
            .pin_bit_mask = (1ULL << kb_col_pins[c]),
            .mode         = GPIO_MODE_INPUT,
            .pull_up_en   = GPIO_PULLUP_ENABLE,
            .pull_down_en = GPIO_PULLDOWN_DISABLE,
            .intr_type    = GPIO_INTR_DISABLE,
        };
        ESP_ERROR_CHECK(gpio_config(&cfg));
    }

    /* Initialise key state */
    for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
        key_states[k] = (KeyState){
            .debounce_polls = INPUT_DEBOUNCE_POLLS,
        };
    }

    FURI_LOG_I(TAG, "Cardputer 7x7 keyboard matrix initialised");
}

void target_input_poll(FuriPubSub* pubsub, uint32_t* sequence_counter) {
    uint32_t now              = furi_get_tick();
    uint32_t long_press_ticks = furi_ms_to_ticks(INPUT_LONG_PRESS_MS);
    uint32_t repeat_ticks     = furi_ms_to_ticks(INPUT_REPEAT_MS);

    /* We want to scan only the rows that contain at least one nav key to
     * minimise scan time.  Build a row → column-mask table for the 6 nav
     * keys. */
    static bool rows_needed[BOARD_KB_ROW_COUNT];
    static bool row_table_built = false;
    if(!row_table_built) {
        for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
            rows_needed[nav_keys[k].row] = true;
        }
        row_table_built = true;
    }

    /* Scan the needed rows */
    uint8_t row_scans[BOARD_KB_ROW_COUNT] = {0};
    for(uint8_t r = 0; r < BOARD_KB_ROW_COUNT; r++) {
        if(rows_needed[r]) {
            row_scans[r] = scan_row(r);
        }
    }

    /* Process each nav key */
    for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
        const NavKey* nk  = &nav_keys[k];
        KeyState*     ks  = &key_states[k];
        InputKey      key = nk->flipper_key;

        bool raw = (row_scans[nk->row] >> nk->col) & 1u;

        /* Debounce */
        if(raw == ks->raw_pressed) {
            if(ks->debounce_polls < INPUT_DEBOUNCE_POLLS) {
                ks->debounce_polls++;
            }
        } else {
            ks->raw_pressed   = raw;
            ks->debounce_polls = 1;
        }

        if(ks->debounce_polls < INPUT_DEBOUNCE_POLLS) continue;
        if(ks->debounced_pressed == ks->raw_pressed) {
            /* Held down: long-press + repeat */
            if(ks->debounced_pressed) {
                uint32_t held = now - ks->press_started_at;
                if(!ks->long_press_sent && held >= long_press_ticks) {
                    ks->long_press_sent  = true;
                    ks->last_repeat_at   = now;
                    input_publish(pubsub, key, InputTypePress, ++(*sequence_counter));
                    input_publish(pubsub, key, InputTypeLong,  *sequence_counter);
                } else if(ks->long_press_sent &&
                          (now - ks->last_repeat_at) >= repeat_ticks) {
                    ks->last_repeat_at = now;
                    input_publish(pubsub, key, InputTypeRepeat, *sequence_counter);
                }
            }
            continue;
        }

        /* State transition */
        ks->debounced_pressed = ks->raw_pressed;

        if(ks->debounced_pressed) {
            /* Key pressed */
            ks->press_started_at = now;
            ks->long_press_sent  = false;
        } else {
            /* Key released */
            if(!ks->long_press_sent) {
                input_emit_short(pubsub, key, ++(*sequence_counter));
            } else {
                input_publish(pubsub, key, InputTypeRelease, *sequence_counter);
            }
        }
    }
}
