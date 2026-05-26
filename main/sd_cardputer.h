#pragma once

#include <furi_hal_sd.h>
#include <esp_log.h>
#include <sys/stat.h>
#include <errno.h>

#define SD_MOUNT_POINT    "/sd"
#define SD_CONTENT_ROOT   "/sd/sdcard"
#define SD_DB_PATH        "/sd/sdcard/databases"

/**
 * Validates that the SD card is mounted and the required folder structure exists.
 * Creates the /sdcard and /sdcard/databases folders if they are missing.
 */
static inline void sd_check_content_root(void) {
    if(!furi_hal_sd_is_mounted()) {
        ESP_LOGE("SD", "SD card not mounted");
        return;
    }
    
    struct stat st;
    if(stat(SD_CONTENT_ROOT, &st) != 0) {
        ESP_LOGW("SD", "Content root %s not found. Creating...", SD_CONTENT_ROOT);
        if(mkdir(SD_CONTENT_ROOT, 0755) != 0 && errno != EEXIST) {
            ESP_LOGE("SD", "Failed to create %s: %d", SD_CONTENT_ROOT, errno);
        }
    }
    
    if(stat(SD_DB_PATH, &st) != 0) {
        ESP_LOGW("SD", "Database path %s not found. Creating...", SD_DB_PATH);
        if(mkdir(SD_DB_PATH, 0755) != 0 && errno != EEXIST) {
            ESP_LOGE("SD", "Failed to create %s: %d", SD_DB_PATH, errno);
        }
    }
}
