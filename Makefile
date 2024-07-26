# Compiler settings
CC = aarch64-none-elf-gcc
LD = aarch64-none-elf-ld
OBJCOPY = aarch64-none-elf-objcopy
CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles
CFLAGS += -Iinclude -Iinclude/drivers
LDFLAGS = -nostdlib -T src/arch/aarch64/link.ld

# Directories
SRC_DIR = src
BUILD_DIR = build
ARCH_DIR = $(SRC_DIR)/arch/aarch64
DRIVERS_DIR = $(SRC_DIR)/drivers
KERNEL_DIR = $(SRC_DIR)/kernel

# Find source files
C_SOURCES = $(shell find $(SRC_DIR) -type f -name '*.c')
S_SOURCES = $(shell find $(SRC_DIR) -type f -name '*.S')
OBJECTS = $(C_SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o) $(S_SOURCES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%.o)

# Targets
.PHONY: all clean directories

all: directories $(BUILD_DIR)/kernel8.img

directories:
	@mkdir -p $(BUILD_DIR)/arch/aarch64
	@mkdir -p $(BUILD_DIR)/drivers
	@mkdir -p $(BUILD_DIR)/kernel

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/kernel8.elf: $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

$(BUILD_DIR)/kernel8.img: $(BUILD_DIR)/kernel8.elf
	$(OBJCOPY) -O binary $< $@

clean:
	/bin/rm -rf $(BUILD_DIR)
