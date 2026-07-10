#define __SFR_OFFSET 0
#include <avr/io.h>

.global main

main:
    sbi DDRD, 3
    cbi DDRD, 2
    sbi DDRB, 4

loop:
    sbi PORTD, 3
    ldi r16, 53
delay_10us:
    dec r16
    brne delay_10us
    cbi PORTD, 3

    clr r24
    clr r25
wait_for_high:
    adiw r24, 1
    breq end_of_loop
    sbis PIND, 2
    rjmp wait_for_high

    clr r24
    clr r25
measure_high:
    adiw r24, 1
    sbic PIND, 2
    rjmp measure_high

    cpi r25, 5
    brlo trigger_alarm

all_clear:
    cbi PORTB, 4
    rjmp end_of_loop

trigger_alarm:
    sbi PORTB, 4

end_of_loop:
    ldi r17, 200
outer_delay:
    ldi r18, 255
inner_delay:
    dec r18
    brne inner_delay
    dec r17
    brne outer_delay

    rjmp loop
