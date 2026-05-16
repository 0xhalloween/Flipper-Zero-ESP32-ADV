#include "furi_hal_memory.h"
#include <furi.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <esp_heap_caps.h>
#include <esp_system.h>

#define TAG "FuriHalMemory"

void furi_hal_memory_init(void) {
    FURI_LOG_I(TAG, "Memory HAL initialized");
    FURI_LOG_I(TAG, "Free heap: %" PRIu32 " bytes", esp_get_free_internal_heap_size());
    FURI_LOG_I(TAG, "Free PSRAM: %" PRIu32 " bytes", (uint32_t)heap_caps_get_free_size(MALLOC_CAP_SPIRAM));
}

void* furi_hal_memory_alloc(size_t size) {
    // Try PSRAM first for large allocations (> 4KB)
    if(size > 4096) {
        void* ptr = heap_caps_malloc(size, MALLOC_CAP_SPIRAM | MALLOC_CAP_8BIT);
        if(ptr) {
            memset(ptr, 0, size);  // Zero-initialize like STM32
            return ptr;
        }
    }
    
    // Fallback to internal RAM with zero-initialization
    void* ptr = calloc(1, size);
    if(!ptr) {
        FURI_LOG_E(TAG, "Failed to allocate %zu bytes", size);
    }
    return ptr;
}

size_t furi_hal_memory_get_free(void) {
    // Return combined free memory (internal + PSRAM)
    return esp_get_free_internal_heap_size() + heap_caps_get_free_size(MALLOC_CAP_SPIRAM);
}

size_t furi_hal_memory_max_pool_block(void) {
    // Return largest allocatable block from PSRAM
    return heap_caps_get_largest_free_block(MALLOC_CAP_SPIRAM);
}
