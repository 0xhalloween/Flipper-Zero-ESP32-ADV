#pragma once

/* =========================================================================
 * board.h — M5Stack Cardputer-ADV (Stamp-S3A / ESP32-S3FN8)
 *
 * Hardware differences vs standard Cardputer:
 *   Keyboard : TCA8418 I²C keypad controller  (SDA=GPIO8, SCL=GPIO9, INT=GPIO11)
 *              replaces the GPIO matrix.
 *   Audio    : ES8311 codec  (I²S + I²C; same bus as keyboard)
 *   Motion   : BMI270 6-axis IMU  (I²C; same bus)
 *   Battery  : 1750 mAh  (vs 120+1400 mAh modular on original)
 *   Module   : Stamp-S3A  (vs Stamp-S3)
 *
 * Display, SD card, and IR pins are IDENTICAL to the standard Cardputer.
 *
 * Porting notes:
 *   - TCA8418 I²C bus MUST be initialised in synchronous mode
 *     (trans_queue_depth = 0).  Using async mode causes "ops list full"
 *     errors during the TCA8418 init burst (15+ register writes).
 *   - The TCA8418 FIFO holds up to 10 key events.  Call the I²C drain
 *     handler promptly after each INT falling edge to avoid overflow.
 *   - INT pin is active-LOW, falling-edge triggered.
 *
 * Navigation mapping to Flipper InputKey (same as standard Cardputer):
 *   Enter → InputKeyOk     Backspace → InputKeyBack
 *   ;     → InputKeyUp     .         → InputKeyDown
 *   ,     → InputKeyLeft   /         → InputKeyRight
 * ========================================================================= */

/* ---- Display (SPI2 / FSPI) — identical to standard Cardputer ------------ */
#define BOARD_LCD_HOST          SPI2_HOST
#define BOARD_LCD_CLK_HZ        (40 * 1000 * 1000)

#define BOARD_LCD_PIN_MOSI      35
#define BOARD_LCD_PIN_SCLK      36
#define BOARD_LCD_PIN_CS        37
#define BOARD_LCD_PIN_DC        34
#define BOARD_LCD_PIN_RST       33
#define BOARD_LCD_PIN_BL        38
#define BOARD_LCD_PIN_MISO      (-1)

#define BOARD_LCD_H_RES         240
#define BOARD_LCD_V_RES         135
#define BOARD_LCD_OFFSET_X      40
#define BOARD_LCD_OFFSET_Y      52
#define BOARD_LCD_BL_ACTIVE_HIGH 1
#define BOARD_LCD_BL_DEFAULT_PCT 100

/* Canvas: 128×64 scaled to 240×120, centred vertically.
 * With GAP_Y=52 the panel hardware correctly aligns row 0, so the
 * 7-pixel vertical margin is split automatically by the display driver. */
#define BOARD_CANVAS_W          240
#define BOARD_CANVAS_H          120
#define BOARD_CANVAS_OFFSET_X   0
#define BOARD_CANVAS_OFFSET_Y   ((135 - 120) / 2)  /* = 7, centred */

/* ---- SD Card (SPI3 / VSPI) — identical to standard Cardputer ------------ */
#define BOARD_SD_HOST           SPI3_HOST
#define BOARD_SD_CLK_HZ         (20 * 1000 * 1000)
#define BOARD_SD_PIN_MOSI       14
#define BOARD_SD_PIN_MISO       39
#define BOARD_SD_PIN_CLK        40
#define BOARD_SD_PIN_CS         12

/* ---- Infrared ------------------------------------------------------------ */
#define BOARD_IR_TX_PIN         44
#define BOARD_IR_RX_PIN         (-1)

/* ---- TCA8418 I²C keyboard controller ------------------------------------- */
#define KB_I2C_HOST             I2C_NUM_0
#define KB_I2C_FREQ_HZ          400000   /* 400 kHz Fast-mode */
#define KB_I2C_PIN_SDA          8
#define KB_I2C_PIN_SCL          9
#define KB_I2C_PIN_INT          11       /* active-LOW interrupt */
#define KB_I2C_ADDR             0x34     /* TCA8418 default 7-bit address */

/* TCA8418 register map (relevant subset) */
#define TCA8418_REG_CFG         0x01
#define TCA8418_REG_INT_STAT    0x02
#define TCA8418_REG_KEY_LCK_EC  0x03
#define TCA8418_REG_KEY_EVENT_A 0x04
#define TCA8418_REG_DEBOUNCE1   0x29
#define TCA8418_REG_DEBOUNCE2   0x2A
#define TCA8418_REG_DEBOUNCE3   0x2B
#define TCA8418_REG_KP_GPIO1    0x1D
#define TCA8418_REG_KP_GPIO2    0x1E
#define TCA8418_REG_KP_GPIO3    0x1F

/* CFG register bits */
#define TCA8418_CFG_AI          (1 << 7)  /* auto-increment for multi-read */
#define TCA8418_CFG_GPI_IEN     (1 << 6)  /* GPI interrupt enable */
#define TCA8418_CFG_OVR_FLOW_IEN (1 << 5) /* overflow interrupt enable */
#define TCA8418_CFG_K_LCK_IEN  (1 << 4)  /* key-lock interrupt enable */
#define TCA8418_CFG_GPI_EM      (1 << 3)  /* GPI event mode */
#define TCA8418_CFG_OVR_FLOW_M  (1 << 2)  /* overflow mode (KE FIFO) */
#define TCA8418_CFG_INT_CFG     (1 << 1)  /* INT pin: 0=level, 1=pulse */
#define TCA8418_CFG_KE_IEN      (1 << 0)  /* key-event interrupt enable */

/* TCA8418 key-event encoding:
 *   bit 7 : 1 = key pressed,  0 = key released
 *   bits 6-0 : key_id (1-88 for matrix, 89-97 for GPIO)
 *   key_id = row * 10 + col + 1   (TCA8418 uses 1-based row/col, 10 cols max)
 *
 * Matrix rows  : ROW0–ROW6 (7 rows)
 * Matrix cols  : COL0–COL7 (8 columns)
 * → 56 key positions covering all 56 keyboard switches.
 */
#define TCA8418_KEY_PRESS_MASK  0x80
#define TCA8418_KEY_ID_MASK     0x7F
#define TCA8418_FIFO_EMPTY      0x00

/* Navigation key IDs — map TCA8418 key_id values to Flipper InputKey.
 * These values assume a 7-row × 8-col matrix layout matching the
 * Cardputer-ADV physical keyboard. Adjust if the wiring differs.
 *
 * The navigation cluster mirrors the standard Cardputer mapping:
 *   Enter (key_id  TBD) → InputKeyOk
 *   Bksp  (key_id  TBD) → InputKeyBack
 *   ;     (key_id  TBD) → InputKeyUp
 *   .     (key_id  TBD) → InputKeyDown
 *   ,     (key_id  TBD) → InputKeyLeft
 *   /     (key_id  TBD) → InputKeyRight
 *
 * Fill in exact key_id values after probing the hardware with the
 * diagnostic sketch in tools/cardputer_key_probe/ (see README-cardputer.md).
 */
#define KB_ADV_KEY_OK           0x2F   /* row 4, col 6 -> (4*10)+6+1 = 47 */
#define KB_ADV_KEY_BACK         0x01   /* row 0, col 0 -> (0*10)+0+1 = 1  */
#define KB_ADV_KEY_UP           0x41   /* row 6, col 4 -> (6*10)+4+1 = 65 */
#define KB_ADV_KEY_DOWN         0x40   /* row 6, col 3 -> (6*10)+3+1 = 64 */
#define KB_ADV_KEY_LEFT         0x42   /* row 6, col 5 -> (6*10)+5+1 = 66 */
#define KB_ADV_KEY_RIGHT        0x43   /* row 6, col 6 -> (6*10)+6+1 = 67 */

/* ---- Capability flags ---------------------------------------------------- */
#define BOARD_HAS_KEYBOARD      1
#define BOARD_HAS_SD            1
#define BOARD_HAS_IR_TX         1
#define BOARD_HAS_IR_RX         0
#define BOARD_HAS_BT            1
#define BOARD_HAS_WIFI          1
#define BOARD_HAS_SUBGHZ        0
#define BOARD_HAS_NFC           0
#define BOARD_HAS_RFID          0
#define BOARD_HAS_PSRAM         0
#define BOARD_HAS_ROTARY_ENCODER 0
#define BOARD_HAS_TCA8418       1
#define BOARD_HAS_ES8311        1   /* audio codec present */
#define BOARD_HAS_BMI270        1   /* IMU present */

/* ---- Miscellaneous ------------------------------------------------------- */
#define BOARD_POWER_HOLD_PIN    (-1)
#define BOARD_LED_PIN           (-1)
