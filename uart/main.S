#define __SFR_OFFSET 0
#include <avr/io.h>

.global main
.global PCINT2_vect ; --- Port D pins interrupt vector
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


    ; --- HC-SR04 Ultrasonic distance sensor
    sbi DDRD, 5 ; Port D bit 5 -> digital pin 5 (trig pin)
    cbi DDRD, 4 ; Port D bit 4 -> digital pin 4 (echo pin)

    ; --- Pin change interrupt for HC-SR04
    ldi r16, 0b00000100
    sts PCICR, r16

    ldi r16, 0b00010000
    sts PCMSK2, r16

    ldi r16, 0b00000010
    sts TCCR1B, r16

    sei

loop:
    sbi PORTD, 5

    ; --- 10 us wait
    ldi r17, 53
wait_10_us:
    dec r17
    brne wait_10_us

    cbi PORTD, 5


    rjmp loop


PCINT2_vect:
    push r16
    in r16, SREG
    push r16

    sbis PIND, 4
    rjmp echo_low


echo_high:
    ldi r16, 0
    sts TCNT1H, r16
    sts TCNT1L, r16

    rjmp exit_pcint_interrupt


echo_low:
    lds r24, TCNT1L
    lds r25, TCNT1H

    ldi r18, 0

devide:
    subi r24, 116
    sbci r25, 0

    brcs done

    inc r18
    rjmp devide

done:
    ldi r19, 1


exit_pcint_interrupt:
    pop r16
    out SREG, r16
    pop r16

    reti


; --- use push to save to the stack, pop gets it back from it, LIFO (last in, first out)
USART_UDRE_vect:
    push r16
    in r16, SREG ; --- SREG is the status register
    push r16



    pop r16
    out SREG, r16
    pop r16

    reti
