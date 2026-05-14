/**
 * @file target_input.c
 * Input driver for M5Stack Cardputer — 74HC138-based 8×7 matrix keyboard.
 *
 * Hardware:
 *   - 74HC138 decoder selects 1-of-8 rows (outputs Y0–Y7).
 *   - 3 address lines: A0=G8, A1=G9, A2=G11.
 *   - 7 column lines: G13, G15, G3, G4, G5, G6, G7 (pulled-up inputs).
 *
 * Flipper Navigation Mapping (8x7 Matrix):
 *   InputKeyOk    → Enter     → Row 4, Col 0 (G13)
 *   InputKeyBack  → Escape    → Row 0, Col 0 (G13)
 *   InputKeyUp    → ↑ arrow   → Row 6, Col 4 (G5)
 *   InputKeyDown  → ↓ arrow   → Row 6, Col 3 (G4)
 *   InputKeyLeft  → ← arrow   → Row 6, Col 5 (G6)
 *   InputKeyRight → → arrow   → Row 6, Col 6 (G7)
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
#define ROW_SETTLE_US           15U

/* ---- Navigation key matrix positions (Authoritative for 74HC138) ---- */
#define NAV_KEY_OK_ROW      4
#define NAV_KEY_OK_COL      0

#define NAV_KEY_BACK_ROW    0
#define NAV_KEY_BACK_COL    0

#define NAV_KEY_UP_ROW      6
#define NAV_KEY_UP_COL      4

#define NAV_KEY_DOWN_ROW    6
#define NAV_KEY_DOWN_COL    3

#define NAV_KEY_LEFT_ROW    6
#define NAV_KEY_LEFT_COL    5

#define NAV_KEY_RIGHT_ROW   6
#define NAV_KEY_RIGHT_COL   6

/* ---- Hardware pins ---- */
static const gpio_num_t kb_col_pins[BOARD_KB_COL_COUNT] = {
    BOARD_KB_PIN_COL0, BOARD_KB_PIN_COL1, BOARD_KB_PIN_COL2, BOARD_KB_PIN_COL3,
    BOARD_KB_PIN_COL4, BOARD_KB_PIN_COL5, BOARD_KB_PIN_COL6,
};

/* ---- Nav key descriptor ---- */
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

/* ---- Per-key state ---- */
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

static void input_publish(FuriPubSub* pubsub, InputKey key, InputType type, uint32_t sequence) {
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
 * Scan one row via 74HC138 decoder and return column mask.
 */
static uint8_t scan_row(uint8_t row_idx) {
    /* Set decoder address (3 bits) */
    gpio_set_level(BOARD_KB_PIN_A0, row_idx & 0x01);
    gpio_set_level(BOARD_KB_PIN_A1, (row_idx >> 1) & 0x01);
    gpio_set_level(BOARD_KB_PIN_A2, (row_idx >> 2) & 0x01);

    esp_rom_delay_us(ROW_SETTLE_US);

    uint8_t mask = 0;
    for(uint8_t c = 0; c < BOARD_KB_COL_COUNT; c++) {
        if(gpio_get_level(kb_col_pins[c]) == 0) {
            mask |= (1u << c);
        }
    }

    return mask;
}

/* ---- Public interface ---- */

void target_input_init(void) {
    /* Decoder address pins as outputs */
    gpio_config_t out_cfg = {
        .pin_bit_mask = (1ULL << BOARD_KB_PIN_A0) | 
                        (1ULL << BOARD_KB_PIN_A1) | 
                        (1ULL << BOARD_KB_PIN_A2),
        .mode         = GPIO_MODE_OUTPUT,
        .pull_up_en   = GPIO_PULLUP_DISABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type    = GPIO_INTR_DISABLE,
    };
    ESP_ERROR_CHECK(gpio_config(&out_cfg));

    /* Column pins as inputs with pullups */
    uint64_t col_mask = 0;
    for(uint8_t c = 0; c < BOARD_KB_COL_COUNT; c++) {
        col_mask |= (1ULL << kb_col_pins[c]);
    }
    gpio_config_t in_cfg = {
        .pin_bit_mask = col_mask,
        .mode         = GPIO_MODE_INPUT,
        .pull_up_en   = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type    = GPIO_INTR_DISABLE,
    };
    ESP_ERROR_CHECK(gpio_config(&in_cfg));

    for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
        key_states[k] = (KeyState){ .debounce_polls = INPUT_DEBOUNCE_POLLS };
    }

    FURI_LOG_I(TAG, "Cardputer 74HC138 keyboard initialized");
}

void target_input_poll(FuriPubSub* pubsub, uint32_t* sequence_counter) {
    uint32_t now              = furi_get_tick();
    uint32_t long_press_ticks = furi_ms_to_ticks(INPUT_LONG_PRESS_MS);
    uint32_t repeat_ticks     = furi_ms_to_ticks(INPUT_REPEAT_MS);

    /* Build row-scan table on first run */
    static bool rows_needed[BOARD_KB_ROW_COUNT] = {false};
    static bool row_table_built = false;
    if(!row_table_built) {
        for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
            rows_needed[nav_keys[k].row] = true;
        }
        row_table_built = true;
    }

    /* Scan needed rows */
    uint8_t row_scans[BOARD_KB_ROW_COUNT] = {0};
    for(uint8_t r = 0; r < BOARD_KB_ROW_COUNT; r++) {
        if(rows_needed[r]) {
            row_scans[r] = scan_row(r);
        }
    }

    /* Process nav keys */
    for(uint8_t k = 0; k < NAV_KEY_COUNT; k++) {
        const NavKey* nk  = &nav_keys[k];
        KeyState*     ks  = &key_states[k];
        InputKey      key = nk->flipper_key;

        bool raw = (row_scans[nk->row] >> nk->col) & 1u;

        if(raw == ks->raw_pressed) {
            if(ks->debounce_polls < INPUT_DEBOUNCE_POLLS) ks->debounce_polls++;
        } else {
            ks->raw_pressed = raw;
            ks->debounce_polls = 1;
        }

        if(ks->debounce_polls < INPUT_DEBOUNCE_POLLS) continue;
        if(ks->debounced_pressed == ks->raw_pressed) {
            if(ks->debounced_pressed) {
                uint32_t held = now - ks->press_started_at;
                if(!ks->long_press_sent && held >= long_press_ticks) {
                    ks->long_press_sent = true;
                    ks->last_repeat_at  = now;
                    input_publish(pubsub, key, InputTypePress, ++(*sequence_counter));
                    input_publish(pubsub, key, InputTypeLong,  *sequence_counter);
                } else if(ks->long_press_sent && (now - ks->last_repeat_at) >= repeat_ticks) {
                    ks->last_repeat_at = now;
                    input_publish(pubsub, key, InputTypeRepeat, *sequence_counter);
                }
            }
            continue;
        }

        ks->debounced_pressed = ks->raw_pressed;
        if(ks->debounced_pressed) {
            ks->press_started_at = now;
            ks->long_press_sent  = false;
        } else {
            if(!ks->long_press_sent) {
                input_emit_short(pubsub, key, ++(*sequence_counter));
            } else {
                input_publish(pubsub, key, InputTypeRelease, *sequence_counter);
            }
        }
    }
}
