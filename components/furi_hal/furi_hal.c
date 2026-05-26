#include "furi_hal.h"
#include "boards/board.h"
#include <furi_hal_gpio.h>
#include <driver/gpio.h>
#include <esp_log.h>
#include <nvs_flash.h>

#include "furi_hal_i2c_bus.h"

static const char* TAG = "FuriHal";

void furi_hal_init_early(void) {
    furi_hal_cortex_init_early();

    /* Ensure I2C bus is available for early board components */
    furi_hal_i2c_get_bus_node();

    /* Force backlight ON as early as possible */
    gpio_config_t bl_cfg = {
        .mode = GPIO_MODE_OUTPUT,
        .pin_bit_mask = 1ULL << BOARD_PIN_LCD_BL,
    };
    gpio_config(&bl_cfg);
#if defined(BOARD_LCD_BL_ACTIVE_LOW) && BOARD_LCD_BL_ACTIVE_LOW
    gpio_set_level(BOARD_PIN_LCD_BL, 0);
#else
    gpio_set_level(BOARD_PIN_LCD_BL, 1);
#endif

#ifdef BOARD_PIN_PWR_EN
    /* Power-enable must be set early — powers CC1101, BQ27220 fuel gauge, WS2812 */
    static const GpioPin pwr_en = {.port = NULL, .pin = BOARD_PIN_PWR_EN};
    furi_hal_gpio_init_simple(&pwr_en, GpioModeOutputPushPull);
    furi_hal_gpio_write(&pwr_en, true);
    ESP_LOGI(TAG, "PWR_EN GPIO%d set HIGH", BOARD_PIN_PWR_EN);
#endif

#ifdef BOARD_PIN_CC1101_CSN
    /* Deselect CC1101 before SPI bus init to prevent it from corrupting the bus */
    if (BOARD_PIN_CC1101_CSN != UINT16_MAX) {
        static const GpioPin cc1101_csn = {.port = NULL, .pin = BOARD_PIN_CC1101_CSN};
        furi_hal_gpio_init_simple(&cc1101_csn, GpioModeOutputPushPull);
        furi_hal_gpio_write(&cc1101_csn, true);
        ESP_LOGI(TAG, "CC1101_CSN GPIO%d set HIGH (deselect)", BOARD_PIN_CC1101_CSN);
    }
#endif

#ifdef BOARD_PIN_NRF24_CSN
    /* T-Embed Plus shares SPI2 between CC1101 and NRF24. Drive NRF24 CSN HIGH
     * (deselected) and CE LOW (standby) at boot, before any CC1101 SPI traffic.
     * Without this, NRF24 sees CC1101 traffic and corrupts the bus, manifesting
     * as a stuck ~312 MHz reading in the Frequency Analyzer and total RX failure. */
    if (BOARD_PIN_NRF24_CSN != UINT16_MAX) {
        static const GpioPin nrf24_csn = {.port = NULL, .pin = BOARD_PIN_NRF24_CSN};
        furi_hal_gpio_init_simple(&nrf24_csn, GpioModeOutputPushPull);
        furi_hal_gpio_write(&nrf24_csn, true);
        ESP_LOGI(TAG, "NRF24_CSN GPIO%d set HIGH (deselect)", BOARD_PIN_NRF24_CSN);
    }
#endif

#ifdef BOARD_PIN_NRF24_CE
    if (BOARD_PIN_NRF24_CE != UINT16_MAX) {
        static const GpioPin nrf24_ce = {.port = NULL, .pin = BOARD_PIN_NRF24_CE};
        furi_hal_gpio_init_simple(&nrf24_ce, GpioModeOutputPushPull);
        furi_hal_gpio_write(&nrf24_ce, false);
        ESP_LOGI(TAG, "NRF24_CE GPIO%d set LOW (standby)", BOARD_PIN_NRF24_CE);
    }
#endif

    ESP_LOGI(TAG, "Early init complete");
}

void furi_hal_deinit_early(void) {
}

void furi_hal_init(void) {
    /* NVS is required by WiFi and BLE — init once at boot */
    esp_err_t nvs_err = nvs_flash_init();
    if(nvs_err == ESP_ERR_NVS_NO_FREE_PAGES || nvs_err == ESP_ERR_NVS_NEW_VERSION_FOUND) {
        nvs_flash_erase();
        nvs_flash_init();
    }

    furi_hal_rtc_init();
    furi_hal_version_init();
    furi_hal_power_init();
    furi_hal_crypto_init();
    furi_hal_subghz_init();
    furi_hal_usb_init();
    furi_hal_light_init();
    furi_hal_display_init();
    furi_hal_speaker_init();
    furi_hal_nfc_init();
    ESP_LOGI(TAG, "Init complete");
}
