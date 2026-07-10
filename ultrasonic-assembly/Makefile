# Microcontroller and Clock Speed
MCU = atmega328p
F_CPU = 16000000UL

# Port (On Fedora, Unos usually mount as ttyACM0. If it fails, try ttyUSB0)
PORT = /dev/ttyACM0

# Toolchain commands
CC = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude

# Compiler Flags
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os

# Targets
all: main.hex

main.elf: main.S
	$(CC) $(CFLAGS) -o main.elf main.S

main.hex: main.elf
	$(OBJCOPY) -O ihex -R .eeprom main.elf main.hex

flash: main.hex
	$(AVRDUDE) -v -c arduino -p $(MCU) -P $(PORT) -b 115200 -U flash:w:main.hex:i

clean:
	rm -f *.elf *.hex
