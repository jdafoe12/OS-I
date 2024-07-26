#ifndef MMIO_H
#define MMIO_H

#include <stdint.h>

// Base address for all peripheral registers
#define PERIPHERAL_BASE 0xFE000000

void mmio_write(long reg, unsigned int val);
unsigned int mmio_read(long reg);

#endif
