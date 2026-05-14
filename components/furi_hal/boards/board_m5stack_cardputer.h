/**
 * @file board_m5stack_cardputer.h
 * Board definition: M5Stack Cardputer (standard GPIO-matrix keyboard)
 *
 * MCU:      ESP32-S3FN8 (dual-core Xtensa LX7, 8 MB Flash, NO PSRAM)
 * Display:  ST7789V2 240×135 RGB565 via SPI2
 * Input:    7×7 GPIO matrix keyboard (49 physical keys)
 * SD Card:  SPI3 (separate bus from LCD — MOSI/MISO/SCLK differ from LCD)
 * IR:       TX (GPIO44), no RX
 * Speaker:  GPIO2 (buzzer/DAC, no I2S amp on standard Cardputer)
 * Mic:      PDM SPM1423 — DATA=GPIO43, CLK=GPIO46 (via internal PDM)
 * Grove:    SDA=GPIO2, SCL=GPIO1  (also Grove UART)
 * USB:      CDC on GPIO19/GPIO20 (native USB-OTG)
 *
 * NOTE — No PSRAM:
 *   The standard Cardputer has NO PSRAM. SubGHz/NFC/NRF24 and wolf3d/doom
 *   are excluded via fam_config.py.  BOARD_HAS_SUBGHZ / BOARD_HAS_NFC = 0.
 *
 * NOTE — SD / keyboard GPIO overlap:
 *   KB cols GPIO39 and GPIO40 are physically shared with SD MOSI/MISO.
 *   The input driver tri-states these GPIOs during SD operations by releasing
 *   them (INPUT_ONLY, no pull) before SD init and reconfiguring after.
 *   For a simple port this is handled transparently: SD is initialised once
 *   at boot before the input driver starts.
 *
 * NOTE — Display scaling:
 *   The Flipper 128×64 canvas is aspect-fit scaled to 240×120 and centred
 *   vertically on the 240×135 display (7 px margin top/bottom).
 *   This is handled automatically by furi_hal_display.c — no code change
 *   needed here.
 *
 * Navigation key mapping (6 Flipper keys out of 49 physical keys):
 *   Key positions given as (row_index, col_index).  Row 0 = GPIO8 driven
 *   low; Col 0 = GPIO5 read. See target_input.c for the full matrix.
 *   VERIFY ON HARDWARE — adjust NAV_KEY_* defines in target_input.c if
 *   your unit's layout differs from the default M5Cardputer Keyboard.cpp.
 */

#pragma once

/* Keyboard uses GPIO matrix scan — no I2C keyboard controller */
/* KB_I2C_PIN_SDA intentionally not defined */
#define BOARD_KB_TYPE_GPIO_MATRIX

/* ---- Board metadata ---- */
#define BOARD_NAME        "M5Stack Cardputer"
#define BOARD_TARGET      "esp32s3"

/* ---- LCD (ST7789V2) via SPI2 ---- */
#define BOARD_PIN_LCD_MOSI      35
#define BOARD_PIN_LCD_SCLK      36
#define BOARD_PIN_LCD_CS        37
#define BOARD_PIN_LCD_DC        34
#define BOARD_PIN_LCD_RST       33
#define BOARD_PIN_LCD_BL        38

/* The LCD SPI bus is TX-only; MISO is not needed on SPI2.
 * Define it as -1 so furi_hal_display.c passes -1 to spi_bus_initialize. */
#define BOARD_PIN_LCD_SPI_MISO  (-1)

/* ---- LCD Display Configuration ---- */
#define BOARD_LCD_H_RES         240
#define BOARD_LCD_V_RES         135
#define BOARD_LCD_SPI_HOST      SPI2_HOST
#define BOARD_LCD_SPI_FREQ_HZ   (40 * 1000 * 1000)
#define BOARD_LCD_CMD_BITS      8
#define BOARD_LCD_PARAM_BITS    8
#define BOARD_LCD_SWAP_XY       true    /* Panel is landscape */
#define BOARD_LCD_MIRROR_X      true
#define BOARD_LCD_MIRROR_Y      false
#define BOARD_LCD_INVERT_COLOR  true    /* ST7789V2 uses inversion ON */
#define BOARD_LCD_GAP_X         40
#define BOARD_LCD_GAP_Y         53
#define BOARD_LCD_BL_ACTIVE_LOW false   /* Backlight active-high */
#define BOARD_LCD_COLOR_ORDER_BGR false

/* Flipper framebuffer color mapping (RGB565, ESP32-S3 SPI byte order) */
#define BOARD_LCD_FG_COLOR      0xA0FD  /* Flipper Orange 0xFDA0 byte-swapped */
#define BOARD_LCD_BG_COLOR      0x0000  /* Black */

/* ---- SD Card via SPI3 (separate from LCD SPI2) ---- */
#define BOARD_HAS_SD            1
#define BOARD_PIN_SD_CS         12
#define BOARD_PIN_SD_MOSI       14      
#define BOARD_PIN_SD_MISO       39      /* NOTE: also KB col GPIO39 — see file header */
#define BOARD_PIN_SD_SCLK       40      /* NOTE: also KB col GPIO40 */

/* Tell furi_hal_sd.c to use SPI3 instead of SPI2.
 * The SD driver will initialise its own bus on these pins. */
#define BOARD_SD_SPI_HOST       SPI3_HOST

/* ---- 74HC138 Keyboard Decoder (Original/v1.1) ---- */
#define BOARD_KB_TYPE_74HC138

/* Decoder Address Pins (outputs) */
#define BOARD_KB_PIN_A0         8
#define BOARD_KB_PIN_A1         9
#define BOARD_KB_PIN_A2         11

/* Column Input Pins (internal pullup) */
#define BOARD_KB_COL_COUNT      7
#define BOARD_KB_PIN_COL0       13
#define BOARD_KB_PIN_COL1       15
#define BOARD_KB_PIN_COL2       3
#define BOARD_KB_PIN_COL3       4
#define BOARD_KB_PIN_COL4       5
#define BOARD_KB_PIN_COL5       6
#define BOARD_KB_PIN_COL6       7

/* Legacy compatibility macros (will be replaced in target_input.c) */
#define BOARD_KB_ROW_COUNT      8

/* ---- Encoder / Rotary input — NOT PRESENT ---- */
#define BOARD_PIN_ENCODER_A     UINT16_MAX
#define BOARD_PIN_ENCODER_B     UINT16_MAX
#define BOARD_PIN_ENCODER_BTN   UINT16_MAX
#define BOARD_PIN_BUTTON_KEY    UINT16_MAX
#define BOARD_PIN_BUTTON_BOOT   0   /* BOOT/IO0 button (flash mode) */
#define BOARD_PIN_BATTERY_ADC   10  /* Battery voltage divider */

/* ---- Touch Controller — NOT PRESENT ---- */
#define BOARD_PIN_TOUCH_SCL     UINT16_MAX
#define BOARD_PIN_TOUCH_SDA     UINT16_MAX
#define BOARD_PIN_TOUCH_RST     UINT16_MAX
#define BOARD_PIN_TOUCH_INT     UINT16_MAX
#define BOARD_TOUCH_I2C_ADDR    0x00
#define BOARD_TOUCH_I2C_PORT    I2C_NUM_0
#define BOARD_TOUCH_I2C_FREQ_HZ 0
#define BOARD_TOUCH_I2C_TIMEOUT 0

/* ---- SubGHz / CC1101 — NOT PRESENT ---- */
#define BOARD_PIN_CC1101_SCK    UINT16_MAX
#define BOARD_PIN_CC1101_CSN    UINT16_MAX
#define BOARD_PIN_CC1101_MISO   UINT16_MAX
#define BOARD_PIN_CC1101_MOSI   UINT16_MAX
#define BOARD_PIN_CC1101_GDO0   UINT16_MAX
#define BOARD_PIN_CC1101_GDO2   UINT16_MAX
#define BOARD_PIN_CC1101_SW1    UINT16_MAX
#define BOARD_PIN_CC1101_SW0    UINT16_MAX
#define BOARD_CC1101_SPI_SHARED 0

/* ---- NRF24L01 — NOT PRESENT ---- */
#define BOARD_PIN_NRF24_SCK     UINT16_MAX
#define BOARD_PIN_NRF24_MISO    UINT16_MAX
#define BOARD_PIN_NRF24_MOSI    UINT16_MAX
#define BOARD_PIN_NRF24_CSN     UINT16_MAX
#define BOARD_PIN_NRF24_CE      UINT16_MAX
#define BOARD_HAS_NRF24         0

/* ---- Power Enable — NOT PRESENT ---- */
#define BOARD_PIN_PWR_EN        UINT16_MAX

/* ---- IR (TX only — no RX on Cardputer) ---- */
#define BOARD_PIN_IR_TX         44
#define BOARD_PIN_IR_RX         UINT16_MAX

/* ---- NFC / PN532 — NOT PRESENT ---- */
#define BOARD_PIN_NFC_SCL       UINT16_MAX
#define BOARD_PIN_NFC_SDA       UINT16_MAX
#define BOARD_PIN_NFC_IRQ       UINT16_MAX
#define BOARD_PIN_NFC_RST       UINT16_MAX
#define BOARD_NFC_I2C_PORT      I2C_NUM_0

/* ---- Speaker (buzzer via GPIO2) ---- */
#define BOARD_PIN_SPEAKER_BCLK  UINT16_MAX
#define BOARD_PIN_SPEAKER_WCLK  UINT16_MAX
#define BOARD_PIN_SPEAKER_DOUT  2   /* Buzzer is on GPIO2 */
#define FURI_HAL_SPEAKER_GPIO   BOARD_PIN_SPEAKER_WCLK

/* ---- Microphone (PDM) ---- */
#define BOARD_PIN_MIC_DATA      43
#define BOARD_PIN_MIC_CLK       46

/* ---- WS2812 RGB LED — NOT PRESENT ---- */
#define BOARD_PIN_WS2812_DATA   UINT16_MAX
#define BOARD_WS2812_LED_COUNT  0

/* ---- RFID / RDM6300 — NOT PRESENT ---- */
#define BOARD_PIN_RFID_RX       UINT16_MAX
#define BOARD_PIN_RFID_TX       UINT16_MAX
#define BOARD_RFID_UART_NUM     1

/* ---- Grove / Qwiic I2C ---- */
#define BOARD_PIN_QWIIC_SDA     UINT16_MAX /* Moved to Speaker (GPIO2) */
#define BOARD_PIN_QWIIC_SCL     1
#define I2C_SDA_GPIO            BOARD_PIN_QWIIC_SDA
#define I2C_SCL_GPIO            BOARD_PIN_QWIIC_SCL

/* ---- Feature flags ---- */
#define BOARD_HAS_TOUCH         0
#define BOARD_HAS_ENCODER       0
#define BOARD_HAS_SD_CARD       1
#define BOARD_HAS_BLE           1
#define BOARD_HAS_RGB_LED       0
#define BOARD_HAS_VIBRO         0
#define BOARD_HAS_SPEAKER       1   /* Buzzer enabled */
#define BOARD_HAS_IR            1
#define BOARD_HAS_IBUTTON       0
#define BOARD_HAS_RFID          0
#define BOARD_HAS_NFC           0
#define BOARD_HAS_SUBGHZ        0
#define BOARD_HAS_MIC           1

/* ---- Battery (no fuel gauge on standard Cardputer) ---- */
#define BQ27220_ADDR            0x00
#define BQ_I2C_PORT             I2C_NUM_0
#define BQ_I2C_SDA              UINT16_MAX
#define BQ_I2C_SCL              UINT16_MAX
#define HIGH_DRAIN_CURRENT_THRESHOLD (-200)
#define FURI_HAL_POWER_VIRTUAL_CAPACITY_MAH     (1520U)  /* 120 mAh internal + 1400 mAh base */
#define BQ25896_CHARGE_LIMIT    1280
