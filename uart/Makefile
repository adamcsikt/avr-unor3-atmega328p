# --- Hardware Settings ---
MCU = atmega328p
F_CPU = 16000000UL
PROGRAMMER = arduino
BAUD = 115200

# --- Serial Port (CHANGE THIS MATCH YOUR OS) ---
# Windows: COM3, COM4, etc.
# macOS: /dev/cu.usbmodem14101 (check using 'ls /dev/cu.usb*')
# Linux: /dev/ttyACM0 or /dev/ttyUSB0 (check using 'ls /dev/tty*')
PORT = /dev/ttyACM0

# --- File Names ---
TARGET = main
SRC = main.S

# --- Toolchain Paths ---
CC = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude

# --- Compiler Flags ---
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Wall -Os

# --- Build Rules ---
all: $(TARGET).hex

$(TARGET).elf: $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET).elf $(SRC)

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $(TARGET).elf $(TARGET).hex

# --- Upload Rule ---
flash: $(TARGET).hex
	$(AVRDUDE) -F -V -c $(PROGRAMMER) -p $(MCU) -P $(PORT) -b $(BAUD) -U flash:w:$(TARGET).hex:i

# --- Clean Rule ---
clean:
	rm -f *.elf *.hex
