# Tone Generator for octave 4 :notes:

Canvas: (http://bit.ly/30YTM7I). 
-- clk = 100 MHz (basys-3)

Connecting speaker (piezo buzzer) to Pin K2 of Pmod Header JA and GND.

![alt text](https://github.com/vjhansen/tone_generator/blob/master/W04D1ToneGenerator.png?raw=true)

This circuit is a modulus counter plus toggle flip-flop.

f<sub>Do</sub> = 261.626 Hz -> T<sub>Do</sub> = 1/f<sub>Do</sub> = 3822 µs 


Consider the first note “Do" at 261.626 Hz (just a little more than 261 Hz):
This frequency corresponds to a period of 3822 microseconds, meaning that the counter should issue a pulse to toggle the flip-flop every 3822 / 2 = 1911 µs
Since the Basys-3 clock frequency is 100 MHz (10 ns period), there will be 191 100 clock cycles during the 1911 µs – actually the exact value is ((1/261.626)*1000000000/2)/10 = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0 (in other words, we need a counter with 18 bits)
All the other notes have higher frequency, so the counter will restart at lower values (for example, the “Re" frequency at 293.665 Hz requires the counter to go up to ((1/293.665)*1000000000/2)/10 = 170 262 before restarting)


*Since the period T<sub>Do</sub> = 3822 µs the counter should issue a pulse to toggle the flip-flop every 3822/2 = 1911 µs* 
*The Basys-3 clock frequency is 100 MHz (10 ns period), there will be 191 100 clock cycles during the 1911 µs (= 191 100 ns) – actually the exact value is ((1/261.626)*(10^9)/2)/10 = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0*

Formula: ((1/261.626)*(10^9)/2)/10 = 191 113

f<sub>Re</sub> = 293.665 Hz -> T<sub>Re</sub> = 1/f<sub>Re</sub> = 3405 µs -> Count to 170 262.

f<sub>Mi</sub> = 329.628 Hz -> T<sub>Mi</sub> = 1/f<sub>Mi</sub> = 3034 µs -> Count to 151 686.

f<sub>Fa</sub> = 349.228 Hz -> T<sub>Fa</sub> = 1/f<sub>Fa</sub> = 2863 µs -> Count to 143 173.

f<sub>Sol</sub> = 391.995 Hz -> T<sub>Sol</sub> = 1/f<sub>Sol</sub> = 2551 µs -> Count to 127 553.

f<sub>La</sub> = 440.000 Hz -> T<sub>La</sub> = 1/f<sub>La</sub> = 2273 µs -> Count to 113 636.

f<sub>Ti</sub> = 493.883 Hz -> T<sub>Ti</sub> = 1/f<sub>Ti</sub> = 2025 µs -> Count to 101 239.

We increment the counter until it reaches one of these threshold values, and then toggle ```temp``` each time it hits this value.

170 262 = 10 1001 1001 0001 0110, in other words, we need a counter with 18 bits.




All the other notes have higher frequency, so the counter will restart at lower values.

This means that we need an 18-bit counter with a synchronous clear input, and a small combinational circuit that will set “clear" to ‘1’ when the counter reaches the value corresponding to the external switch pattern that defines the note. The same ticking pulse driving the counter “clear" input will toggle the flip-flop, so I think that it’s just these three blocks: counter + combinational circuit + toggle flip-flop.







---


Explanation of the formula:
The “Do” musical note has a frequency of 261.626 Hz (it’s not 261 KHz, the dot separates the entire part from the fractional part), so it’s period is (1/261.626) in seconds
Assuming a square wave, this means that half of this time will be ‘0’ and the other half ‘1’: ((1/261.626) / 2) for each half period
If we convert this to nano-seconds we get ((1/261.626) / 2 ) x 10^9 (that’s why we have nine zeros)
Since the Basys-3 board runs at 100 MHz, the board clock period is 10 ns (and the counter will increment once per clock period)
So in total it will take (((1/261.626) / 2 ) x 10^9) / 10 clock periods to generate half period of the square wave driving the buzzer 

This means that we need an 18-bit counter with a synchronous clear input, and a small combinational circuit that will set “clear" to ‘1’ when the counter reaches the value corresponding to the external switch pattern that defines the note. The same ticking pulse driving the counter “clear" input will toggle the flip-flop, so I think that it’s just these three blocks: counter + combinational circuit + toggle flip-flop.

Explanation of the formula:
The “Do” musical note has a frequency of 261.626 Hz (it’s not 261 KHz, the dot separates the entire part from the fractional part), so it’s period is (1/261.626) in seconds
Assuming a square wave, this means that half of this time will be ‘0’ and the other half ‘1’: ((1/261.626) / 2) for each half period
If we convert this to nano-seconds we get ((1/261.626) / 2 ) x 10^9 (that’s why we have nine zeros)
Since the Basys-3 board runs at 100 MHz, the board clock period is 10 ns (and the counter will increment once per clock period)
So in total it will take (((1/261.626) / 2 ) x 10^9) / 10 clock periods to generate half period of the square wave driving the buzzer 

The audible frequencies are very low, so we should simulate for at least 100 ms, and in that case we’ll would get 26 square wave periods for the lowest frequency “Do” note (approx 261 Hz). 
The alternative is to compare with lower values – for example 19 111 instead of 191 113 (if we divide the comparison values by 10 the simulation will be 10 times faster). But I would prefer to let it simulate for 100 ms and use the real values…

It is better to create the various modules in different files, and then to create a top level description instantiating all the modules. The counter file is just a simplified version of the universal counter discussed in class (without the direction and the enable inputs). Its clear input will be driven by the output of the 18-bit comparator – when the counter reaches the 18-bit value defined by the switches, the output of the comparator will go high for one clock cycle, so the counter will clear its outputs at the next rising edge of the clock and restarting counting. The output of the comparator will also be used to toggle the flip-flop driving the buzzer, so it will generate the necessary square wave to play the note. 
