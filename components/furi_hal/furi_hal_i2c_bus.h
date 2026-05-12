#pragma once
#include <driver/i2c_master.h>

/**
 * Returns the shared I2C master bus handle.
 * Initialises it on the first call using pins defined in board.h.
 */
i2c_master_bus_handle_t furi_hal_i2c_get_bus_node(void);
