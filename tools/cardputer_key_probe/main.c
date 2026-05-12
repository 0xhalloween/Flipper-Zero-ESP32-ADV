/**
 * cardputer_key_probe.c — TCA8418 key-ID diagnostic tool
 *
 * Flash this standalone ESP-IDF app to your Cardputer-ADV to discover
 * the raw TCA8418 key_id for every physical key.  Press each key and
 * read the serial output; record the key_id values in board.h.
 *
 * Build:  Copy this file into a minimal ESP-IDF project's main/ directory.
 * Flash:  idf.py build flash monitor
 * Output: Each key press prints "PRESS key_id=0xNN" on the serial console.
 */

#include <stdio.h>
#include <driver/gpio.h>
#include <driver/i2c_master.h>
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <esp_log.h>

static const char *TAG = "key_probe";

/* --- Pin config --- same as board.h --- */
#define I2C_HOST    I2C_NUM_0
#define PIN_SDA     8
#define PIN_SCL     9
#define PIN_INT     11
#define TCA_ADDR    0x34

/* TCA8418 registers */
#define REG_CFG         0x01
#define REG_INT_STAT    0x02
#define REG_KEY_LCK_EC  0x03
#define REG_KEY_EVENT   0x04
#define REG_KP_GPIO1    0x1D
#define REG_KP_GPIO2    0x1E
#define REG_KP_GPIO3    0x1F
#define REG_DEBOUNCE1   0x29
#define REG_DEBOUNCE2   0x2A
#define REG_DEBOUNCE3   0x2B

static i2c_master_bus_handle_t bus;
static i2c_master_dev_handle_t dev;

static esp_err_t w(uint8_t reg, uint8_t val) {
    uint8_t b[2] = {reg, val};
    return i2c_master_transmit(dev, b, 2, pdMS_TO_TICKS(100));
}

static esp_err_t r(uint8_t reg, uint8_t *out) {
    i2c_master_transmit(dev, &reg, 1, pdMS_TO_TICKS(100));
    return i2c_master_receive(dev, out, 1, pdMS_TO_TICKS(100));
}

static TaskHandle_t probe_task_handle;

static void IRAM_ATTR int_isr(void *arg) {
    BaseType_t w = pdFALSE;
    vTaskNotifyGiveFromISR(probe_task_handle, &w);
    portYIELD_FROM_ISR(w);
}

static void probe_task(void *arg) {
    probe_task_handle = xTaskGetCurrentTaskHandle();

    /* Init I2C */
    i2c_master_bus_config_t bc = {
        .clk_source = I2C_CLK_SRC_DEFAULT,
        .i2c_port = I2C_HOST,
        .sda_io_num = PIN_SDA,
        .scl_io_num = PIN_SCL,
        .glitch_ignore_cnt = 7,
        .flags.enable_internal_pullup = true,
        .trans_queue_depth = 0,  /* sync mode */
    };
    ESP_ERROR_CHECK(i2c_new_master_bus(&bc, &bus));

    i2c_device_config_t dc = {
        .dev_addr_length = I2C_ADDR_BIT_LEN_7,
        .device_address = TCA_ADDR,
        .scl_speed_hz = 400000,
    };
    ESP_ERROR_CHECK(i2c_master_bus_add_device(bus, &dc, &dev));

    /* Init TCA8418: 7 rows × 8 cols, all as keypad matrix */
    w(REG_KP_GPIO1, 0xFF);   /* COL0-7 */
    w(REG_KP_GPIO2, 0x7F);   /* ROW0-6 */
    w(REG_KP_GPIO3, 0x00);
    w(REG_DEBOUNCE1, 0xFF);
    w(REG_DEBOUNCE2, 0xFF);
    w(REG_DEBOUNCE3, 0x00);
    w(REG_CFG, 0x03);        /* KE_IEN + INT_CFG */
    w(REG_INT_STAT, 0x01);   /* clear */

    /* INT pin */
    gpio_config_t gc = {
        .pin_bit_mask = 1ULL << PIN_INT,
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .intr_type = GPIO_INTR_NEGEDGE,
    };
    gpio_config(&gc);
    gpio_install_isr_service(0);
    gpio_isr_handler_add(PIN_INT, int_isr, NULL);

    ESP_LOGI(TAG, "TCA8418 ready — press keys to see their IDs");
    ESP_LOGI(TAG, "key_id formula: (row * 10) + col + 1  [TCA8418 1-based]");

    while (1) {
        ulTaskNotifyTake(pdTRUE, pdMS_TO_TICKS(2000));

        uint8_t cnt = 0;
        r(REG_KEY_LCK_EC, &cnt);
        cnt &= 0x0F;

        for (uint8_t i = 0; i < cnt; i++) {
            uint8_t ev = 0;
            r(REG_KEY_EVENT, &ev);
            if (ev == 0) break;

            bool pressed = (ev & 0x80) != 0;
            uint8_t key_id = ev & 0x7F;

            /* Decode row and col from key_id */
            /* TCA8418: key_id = (row * 10) + col + 1  for matrix keys */
            int row = (key_id - 1) / 10;
            int col = (key_id - 1) % 10;

            printf("[%s] key_id=0x%02X (%d)  →  row=%d col=%d\n",
                   pressed ? "PRESS  " : "RELEASE",
                   key_id, key_id, row, col);
        }

        w(REG_INT_STAT, 0x01);
    }
}

void app_main(void) {
    xTaskCreate(probe_task, "probe", 4096, NULL, 5, NULL);
}
