#define __SFR_OFFSET 0
#include <avr/io.h>

.global main
.global PCINT2_vect

main:
    ldi r16, 0b01100000
    sts ADMUX, r16

    ldi r16, 0b10000111
    sts ADCSRA, r16

    ldi r16, 0b00100011
    sts TCCR2A, r16

    ldi r16, 0b00000100
    sts TCCR2B, r16

    ldi r16, 0
    sts OCR2B, r16

    ; --- motor setup ---
    sbi DDRB, 4
    sbi DDRB, 1
    sbi DDRD, 3

    ; --- hc-sr04 setup ---
    sbi DDRD, 4 ; trig
    cbi DDRD, 5 ; echo

    ; --- pin change interrupt for uno r3 pin 5 ---
    ldi r16, 0b00000100
    sts PCICR, r16

    ldi r16, 0b00100000
    sts PCMSK2, r16

    sei

loop:
    sbi PORTD, 4

    ldi r16, 53

delay:
    dec r16
    brne delay
    cbi PORTD, 4

    ldi r17, 200

outer_delay:

    ldi r18, 255

inner_delay:
    dec r18
    brne inner_delay
    dec r17
    brne outer_delay

    rjmp loop

echo_high:
    ldi r16, 0
    sts TCNT1H, r16
    sts TCNT1L, r16

    ldi r16, 0b00000010
    sts TCCR1B, r16

    reti

echo_low:
    ldi r16, 0
    sts TCCR1B, r16

    lds r24, TCNT1L
    lds r25, TCNT1H

    cpi r25, 4

    brsh clear
    rjmp trigger

    reti

clear:
    ldi r16, 0
    sts OCR2B, r16

    sbi PORTB, 1

    reti

trigger:
    cbi PORTB, 1
    sbi PORTB, 4

;    ldi r16, 128          ; Hardcode 50% speed
;    sts OCR2B, r16

    ldi r16, 0b11000111
    sts ADCSRA, r16

adc_wait:
    lds r16, ADCSRA
    sbrc r16, 6
    rjmp adc_wait

    lds r16, ADCH
    ;lsr r16

    sts OCR2B, r16

    reti

PCINT2_vect:
    sbic PIND, 5
    rjmp echo_high
    rjmp echo_low
    reti
