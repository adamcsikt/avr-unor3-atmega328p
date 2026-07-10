#define __SFR_OFFSET 0
#include <avr/io.h>

.global main
.global USART_UDRE_vect ; --- address 0x0026

.section .data

distance_buffer:
    .space 8


; --- SETUP ---
main:
    ldi r16, 0
    sts UBRR0H, r16

    ldi r16, 103
    sts UBRR0L, r16

    ldi r16, 0b00100110
    sts UCSR0C, r16

    ldi r16, 0b00001000
    sts UCSR0B, r16

    sei

    ldi r16, 0b00101000
    sts UCSR0B, r16

loop:


    rjmp loop

; --- use push to save to the stack, pop gets it back from it, LIFO (last in, first out)
USART_UDRE_vect:
    push r16
    in r16, SREG ; --- SREG is the status register
    push r16



    pop r16
    out SREG, r16
    pop r16

    reti
