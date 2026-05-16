#include "furi_hal_i2c_bus.h"
#include <boards/board.h>
#include <esp_log.h>
#include <driver/i2c.h>

static const char* TAG = "FuriHalI2cBus";
static bool i2c_installed = false;

i2c_master_bus_handle_t furi_hal_i2c_get_bus_node(void) {
    /* We return NULL but initialize the legacy driver for internal components.
     * The target_input.c and speaker.c will use the legacy driver too. */
    if (!i2c_installed) {
        i2c_config_t conf = {
            .mode = I2C_MODE_MASTER,
            .sda_io_num = KB_I2C_PIN_SDA,
            .scl_io_num = KB_I2C_PIN_SCL,
            .sda_pullup_en = GPIO_PULLUP_ENABLE,
            .scl_pullup_en = GPIO_PULLUP_ENABLE,
            .master.clk_speed = KB_I2C_FREQ_HZ,
        };
        esp_err_t err = i2c_param_config(I2C_NUM_0, &conf);
        if (err != ESP_OK) {
            ESP_LOGE(TAG, "i2c_param_config failed: %s", esp_err_to_name(err));
            return NULL;
        }
        err = i2c_driver_install(I2C_NUM_0, conf.mode, 0, 0, 0);
        if (err != ESP_OK && err != ESP_ERR_INVALID_STATE && err != ESP_FAIL) {
            ESP_LOGE(TAG, "i2c_driver_install failed: %s", esp_err_to_name(err));
            return NULL;
        }
        i2c_installed = true;
        ESP_LOGI(TAG, "Shared I2C bus (LEGACY) created on GPIO%d/GPIO%d", KB_I2C_PIN_SDA, KB_I2C_PIN_SCL);
    }
    return NULL; // Legacy driver doesn't use bus handles
}
