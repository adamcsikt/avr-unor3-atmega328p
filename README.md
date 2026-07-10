# AVR ATmega328p Assembly Projects

## EN
This repo contains my early learning projects focused on low-level microcontroller programming. Everything here is written purely in **AVR Assembly** (`.S` files) for the **ATmega328p** (Arduino Uno R3). My main goal with these was to get a better understanding of how the hardware works under the hood, dealing with registers and memory directly instead of relying on high-level C/C++ abstractions.

### What's inside?
*   **`motor-control`**: Basic motor control. Playing around with GPIO pins and hardware timers for PWM.
*   **`uart`**: Serial communication setup. Setting up the baud rate and sending/receiving data directly via the USART registers.
*   **`ultrasonic-assembly`**: Reading data from an ultrasonic distance sensor (like HC-SR04). Good practice for precise timing, hardware counters, and handling external interrupts in Assembly.

### How to run
Each folder has its own `Makefile`. To build and flash a project to the board, just navigate to the folder and run:

    cd motor-control
    make
    make flash
