#pragma once

#include <stdint.h>
#include <furi.h>

/* Cardputer Keyboard Scan Codes (Matrix return values / HID codes) */
#define CARDPUTER_KEY_UP    0xB5
#define CARDPUTER_KEY_DOWN  0xB6
#define CARDPUTER_KEY_LEFT  0xB4
#define CARDPUTER_KEY_RIGHT 0xB7
#define CARDPUTER_KEY_BACK  0x08
#define CARDPUTER_KEY_ENTER 0x0D

typedef enum {
    CARDPUTER_ACTION_NONE,
    CARDPUTER_ACTION_UP,
    CARDPUTER_ACTION_DOWN,
    CARDPUTER_ACTION_LEFT,
    CARDPUTER_ACTION_RIGHT,
    CARDPUTER_ACTION_OK,
    CARDPUTER_ACTION_BACK,
} CardputerAction_t;

typedef struct {
    uint8_t key_code;
    CardputerAction_t action;
} CardputerKey_t;

/**
 * Translates matrix scan codes to Flipper-compatible actions.
 * Handles both standard arrow keys and Fn+I/K/J/L schemes.
 */
static inline CardputerKey_t cardputer_get_input(uint8_t scan_code) {
    CardputerKey_t result = {scan_code, CARDPUTER_ACTION_NONE};

    switch(scan_code) {
    case CARDPUTER_KEY_UP:
    case 'i': // Fn + i
    case 'I':
        result.action = CARDPUTER_ACTION_UP;
        break;
    case CARDPUTER_KEY_DOWN:
    case 'k': // Fn + k
    case 'K':
        result.action = CARDPUTER_ACTION_DOWN;
        break;
    case CARDPUTER_KEY_LEFT:
    case 'j': // Fn + j
    case 'J':
        result.action = CARDPUTER_ACTION_LEFT;
        break;
    case CARDPUTER_KEY_RIGHT:
    case 'l': // Fn + l
    case 'L':
        result.action = CARDPUTER_ACTION_RIGHT;
        break;
    case CARDPUTER_KEY_ENTER:
        result.action = CARDPUTER_ACTION_OK;
        break;
    case CARDPUTER_KEY_BACK:
        result.action = CARDPUTER_ACTION_BACK;
        break;
    default:
        break;
    }

    return result;
}
