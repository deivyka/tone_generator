# Tone Generator for octave 4 :notes:

Canvas: (http://bit.ly/30YTM7I). 


![alt text](https://github.com/vjhansen/tone_generator/blob/master/W04D1ToneGenerator.png?raw=true)

This circuit is a modulus counter plus toggle flip-flop.

f<sub>Do</sub> = 261.626 Hz -> T<sub>Do</sub> = 1/f<sub>Do</sub> = 3822 µs 

*Since the period T<sub>Do</sub> = 3822 µs the counter should issue a pulse to toggle the flip-flop every 3822/2 = 1911 µs* 
*The Basys-3 clock frequency is 100 MHz (10 ns period), there will be 191 100 clock cycles during the 1911 µs (= 191 100 ns) – actually the exact value is ((1/261.626)*(10^9)/2)/10 = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0*

Formula: ((1/261.626)*(10^9)/2)/10 = 191 113

f<sub>Re</sub> = 293.665 Hz -> T<sub>Re</sub> = 1/f<sub>Re</sub> = 3405 µs -> Count to 170 262.

f<sub>Mi</sub> = 329.628 Hz -> T<sub>Mi</sub> = 1/f<sub>Mi</sub> = 3034 µs -> Count to 151 686.

f<sub>Fa</sub> = 349.228 Hz -> T<sub>Fa</sub> = 1/f<sub>Fa</sub> = 2863 µs -> Count to 143 173.

f<sub>Sol</sub> = 391.995 Hz -> T<sub>Sol</sub> = 1/f<sub>Sol</sub> = 2551 µs -> Count to 127 553.

f<sub>La</sub> = 440.000 Hz -> T<sub>La</sub> = 1/f<sub>La</sub> = 2273 µs -> Count to 113 636.

f<sub>Ti</sub> = 493.883 Hz -> T<sub>Ti</sub> = 1/f<sub>Ti</sub> = 2025 µs -> Count to 101 239.


170 262 = 10 1001 1001 0001 0110, in other words, we need a counter with 18 bits.


* intro digital design digilent vhdl online 50/119
* free range vhdl 147/169
* https://vlsicoding.blogspot.com/2016/01/vhdl-code-for-generation-of-1-khz-and-1-hz-frequency.html
* https://gist.github.com/RickKimball/45d0753a900f92d5fdd836746062588c
* https://www.digikey.com/eewiki/pages/viewpage.action?pageId=20939345
* https://www.bioee.ee.columbia.edu/courses/ee3082/piano/lesson_backup.html
* https://www.instructables.com/id/FPGA-Composer/
* https://stackoverflow.com/questions/27317546/pulse-generator-in-vhdl-with-any-frequency
* https://stackoverflow.com/questions/22767256/vhdl-code-for-single-octave-digital-piano



-- clk = 100 MHz (basys-3)

Connecting speaker to Pin J1 of Pmod Header JA and GND.

All the other notes have higher frequency, so the counter will restart at lower values.

This means that we need an 18-bit counter with a synchronous clear input, and a small combinational circuit that will set “clear" to ‘1’ when the counter reaches the value corresponding to the external switch pattern that defines the note. The same ticking pulse driving the counter “clear" input will toggle the flip-flop, so I think that it’s just these three blocks: counter + combinational circuit + toggle flip-flop.


We increment counter until it reaches a threshold value and then toggle temp each time it hits this value. This will give us a lower slower frequency that represents a note’s frequency. For example, the note A is 440Hz. We can get this frequency from the clock by dividing 50MHz by 440Hz. We then take this value and when the counter reaches this value, we toggle temp, else we simply increment the counter.

