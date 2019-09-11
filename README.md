# Tone Generator for octave 4

Canvas: (http://bit.ly/30YTM7I). 


Connect speaker (piezo buzzer) to Pin K2 of Pmod Header JA and GND on the Basys 3.

![alt text](https://github.com/vjhansen/tone_generator/blob/master/W04D1ToneGenerator.png?raw=true)

This circuit is a modulus counter plus toggle flip-flop.


The “Do” musical note *f<sub>Do</sub>* has a frequency of 261.626 Hz, the period *T<sub>Do</sub> = 1/f<sub>Do</sub>* = (1/261.626) = 3822 µs. The counter should therefore issue a pulse to toggle the flip-flop every 3822/2 = 1911 µs.
Assuming a square wave, this means that half of this time will be ‘0’ and the other half ‘1’: ((1/261.626) / 2) for each half period


The Basys-3 board runs at 100 MHz, the period is 10 ns (= 10<sup>-8</sup> s).
We can find the required clock cycles needed to toggle the pulse if we convert 1911 µs into nanoseconds: ((1911 µs) x 10^9 s)/10 = 191 100 ns, there will be 191 100 clock cycles during the 1911 µs.


<img src="https://github.com/vjhansen/tone_generator/blob/master/form.png" alt="drawing" width="350"/>


The exact clock cycle for "Do" is: (100 * 10^6 Hz)/(2 * 261.626 Hz) = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0.


![alt text](https://github.com/vjhansen/tone_generator/blob/master/scale.png?raw=true)



---
Using the formula to calculate values for the other notes:

f<sub>Re</sub> = 293.665 Hz -> Count to 170 262.

f<sub>Mi</sub> = 329.628 Hz -> Count to 151 686.

f<sub>Fa</sub> = 349.228 Hz -> Count to 143 173.

f<sub>Sol</sub> = 391.995 Hz -> Count to 127 553.

f<sub>La</sub> = 440.000 Hz -> Count to 113 636.

f<sub>Ti</sub> = 493.883 Hz -> Count to 101 239.

We increment a counter until it reaches one of these threshold values, and then toggle the ```buzzer``` each time the counter hits the desired value.

---
We need a counter with 18 bits since 191 113 = 10 1110 1010 1000 1001.
When the counter reaches the 18-bit value defined by the switches (e.g. Re), the output of the comparator will go high for one clock cycle, so the counter will clear its outputs at the next rising edge of the clock and restarting counting. The output of the comparator will also be used to toggle the flip-flop driving the buzzer, so it will generate the necessary square wave to play the note. 
