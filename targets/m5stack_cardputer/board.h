#pragma once

/* =========================================================================
 * board.h — M5Stack Cardputer (Stamp-S3 / ESP32-S3FN8)
 *
 * Hardware:
 *   MCU   : ESP32-S3FN8 (Xtensa LX7 dual-core, 240 MHz)
 *   Flash : 8 MB (no PSRAM on base Cardputer)
 *   Display: ST7789V2  240×135  (landscape)
 *   Input : 7-col × 3-row GPIO keyboard matrix (≈21 physical keys)
 *   SD    : SPI (separate bus from LCD)
 *   IR TX : GPIO44
 *
 * Porting notes:
 *   - No PSRAM → wolf3d / doom FAPs are excluded (memory-intensive).
 *   - No CC1101 → SubGHz excluded.
 *   - NFC needs PN532 module — excluded by default; add one to the Grove
 *     port and re-enable via fam_config.py if desired.
 *   - Display is 240×135; the 128×64 Flipper canvas is rendered at 240×120
 *     (scale ≈1.875 via nearest-neighbour in the display HAL) centred
 *     vertically with a 7/8-pixel blank strip top and bottom.
 *     If the HAL only supports integer scale, select scale=1 (128×64) and
 *     set BOARD_CANVAS_OFFSET_X=56 / BOARD_CANVAS_OFFSET_Y=35 instead.
 * ========================================================================= */

/* ---- Display (SPI2 / FSPI) -------------------------------------------- */
#define BOARD_LCD_HOST          SPI2_HOST
#define BOARD_LCD_CLK_HZ        (40 * 1000 * 1000)

#define BOARD_LCD_PIN_MOSI      35
#define BOARD_LCD_PIN_SCLK      36
#define BOARD_LCD_PIN_CS        37
#define BOARD_LCD_PIN_DC        34
#define BOARD_LCD_PIN_RST       33
#define BOARD_LCD_PIN_BL        38
#define BOARD_LCD_PIN_MISO      (-1)   /* write-only panel */

/* Physical panel size in landscape orientation */
#define BOARD_LCD_H_RES         240
#define BOARD_LCD_V_RES         135

/* ST7789V2 internal frame-buffer offset for this panel size (landscape) */
#define BOARD_LCD_OFFSET_X      40
#define BOARD_LCD_OFFSET_Y      52

/* Backlight: active HIGH PWM, 100% default */
#define BOARD_LCD_BL_ACTIVE_HIGH 1
#define BOARD_LCD_BL_DEFAULT_PCT 100

/* Flipper canvas dimensions painted onto the LCD.
 * 128×64 scaled to 240×120 (scale ≈1.875, nearest-neighbour).
 * Centred vertically: top offset = (135-120)/2 = 7 pixels. */
#define BOARD_CANVAS_W          240
#define BOARD_CANVAS_H          120
#define BOARD_CANVAS_OFFSET_X   0
#define BOARD_CANVAS_OFFSET_Y   7

/* ---- SD Card (SPI3 / VSPI) -------------------------------------------- */
#define BOARD_SD_HOST           SPI3_HOST
#define BOARD_SD_CLK_HZ         (20 * 1000 * 1000)

#define BOARD_SD_PIN_MOSI       14
#define BOARD_SD_PIN_MISO       39
#define BOARD_SD_PIN_CLK        40
#define BOARD_SD_PIN_CS         12

/* ---- Infrared ------------------------------------------------------------ */
#define BOARD_IR_TX_PIN         44
#define BOARD_IR_RX_PIN         (-1)   /* no IR RX on Cardputer */

/* ---- Keyboard matrix ----------------------------------------------------- *
 *
 * Physical layout (7 columns × 3 rows = 21 key positions):
 *
 *   Cols (driven LOW one at a time — outputs):
 *     COL0=GPIO13  COL1=GPIO15  COL2=GPIO3  COL3=GPIO4
 *     COL4=GPIO5   COL5=GPIO6   COL6=GPIO7
 *
 *   Rows (pulled-up inputs — read while one col is driven LOW):
 *     ROW0=GPIO8   ROW1=GPIO9   ROW2=GPIO11
 *
 * Key-code matrix [row][col] — values match ASCII where possible.
 * 0x00 = unused/no-key.
 *
 * Navigation mapping to Flipper InputKey:
 *   Enter       → InputKeyOk
 *   Backspace   → InputKeyBack
 *   `;`         → InputKeyUp
 *   `.`         → InputKeyDown
 *   `,`         → InputKeyLeft
 *   `/`         → InputKeyRight
 *
 * (These mirror the bottom-right cluster of keys, which sits like a D-pad.)
 * -------------------------------------------------------------------------  */
#define KB_COL_COUNT    7
#define KB_ROW_COUNT    3

#define KB_COL_PINS     { 13, 15, 3, 4, 5, 6, 7 }
#define KB_ROW_PINS     { 8, 9, 11 }

/* Scan period (ms) — 10 ms gives responsive 100 Hz polling */
#define KB_SCAN_PERIOD_MS   10

/* Navigation key ASCII codes used in input.c */
#define KB_NAV_UP       ';'
#define KB_NAV_DOWN     '.'
#define KB_NAV_LEFT     ','
#define KB_NAV_RIGHT    '/'
#define KB_NAV_OK       '\r'    /* Enter */
#define KB_NAV_BACK     '\b'    /* Backspace / del */

/* ---- Capability flags ---------------------------------------------------- */
#define BOARD_HAS_KEYBOARD      1
#define BOARD_HAS_SD            1
#define BOARD_HAS_IR_TX         1
#define BOARD_HAS_IR_RX         0
#define BOARD_HAS_BT            1
#define BOARD_HAS_WIFI          1
#define BOARD_HAS_SUBGHZ        0   /* no CC1101 */
#define BOARD_HAS_NFC           0   /* no PN532 by default */
#define BOARD_HAS_RFID          0
#define BOARD_HAS_PSRAM         0
#define BOARD_HAS_ROTARY_ENCODER 0

/* ---- Miscellaneous ------------------------------------------------------- */
#define BOARD_POWER_HOLD_PIN    (-1)   /* no external power latch needed */
#define BOARD_LED_PIN           (-1)   /* no dedicated status LED */
