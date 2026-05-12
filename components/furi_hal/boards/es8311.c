#include "board.h"
#include <driver/i2c.h>
#include <esp_log.h>

#define TAG "ES8311"

/* ES8311 Registers */
#define ES8311_REG_RESET        0x00
#define ES8311_REG_CLK_MANAGER  0x01
#define ES8311_REG_SDP_CONFIG   0x03
#define ES8311_REG_SYSTEM_CONFIG 0x05
#define ES8311_REG_DAC_CONFIG   0x31
#define ES8311_REG_DAC_VOLUME   0x32

static esp_err_t es8311_write_reg(uint8_t reg, uint8_t val) {
    i2c_cmd_handle_t cmd = i2c_cmd_link_create();
    i2c_master_start(cmd);
    i2c_master_write_byte(cmd, (0x18 << 1) | I2C_MASTER_WRITE, true);
    i2c_master_write_byte(cmd, reg, true);
    i2c_master_write_byte(cmd, val, true);
    i2c_master_stop(cmd);
    esp_err_t ret = i2c_master_cmd_begin(I2C_NUM_0, cmd, pdMS_TO_TICKS(100));
    i2c_cmd_link_delete(cmd);
    return ret;
}

esp_err_t board_es8311_init(void) {
    esp_err_t ret = ESP_OK;

    /* Reset */
    ret |= es8311_write_reg(ES8311_REG_RESET, 0x1F);
    ret |= es8311_write_reg(ES8311_REG_RESET, 0x00);

    /* System power up */
    ret |= es8311_write_reg(ES8311_REG_SYSTEM_CONFIG, 0x01);

    /* Clock manager */
    ret |= es8311_write_reg(ES8311_REG_CLK_MANAGER, 0x00);

    /* Serial Data Port (I2S, 16-bit, Philips mode) */
    ret |= es8311_write_reg(ES8311_REG_SDP_CONFIG, 0x0C);

    /* DAC config */
    ret |= es8311_write_reg(ES8311_REG_DAC_CONFIG, 0x00);

    /* Volume (0-255) */
    ret |= es8311_write_reg(ES8311_REG_DAC_VOLUME, 0xBF);

    if (ret == ESP_OK) {
        ESP_LOGI(TAG, "ES8311 initialized");
    } else {
        ESP_LOGE(TAG, "ES8311 initialization failed");
    }

    return ret;
}
