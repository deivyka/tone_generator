# Tone Generator for octave 4

Canvas: (http://bit.ly/30YTM7I). 


![alt text](https://github.com/vjhansen/tone_generator/blob/master/W04D1ToneGenerator.png?raw=true)

This circuit is a modulus counter plus toggle flip-flop. Connect speaker (piezo buzzer) to Pin K2 of Pmod Header JA and GND on the Basys 3.


The “Do” musical note *f<sub>Do</sub>* has a frequency of 261.626 Hz, and the period (or cycle) *T<sub>Do</sub> = 1/f<sub>Do</sub>* = (1/261.626) = 3822 µs. 

To generate a square wave for *f<sub>Do</sub>* we need a counter that toggles a flip-flop every 3822/2 = 1911 µs, this is because a square wave has equal high (1) and low (0) periods (i.e. high for 50% of the period, and low for the remaining period)

The Basys-3 board runs at 100 MHz, giving it a clock cycle (period) of 10 ns (= 10<sup>-8</sup> s).
We can find the required clock cycles needed to toggle the pulse if we convert 1911 µs into nanoseconds: (1911(10<sup>-6</sup>)·10^8) = 191 100 ns, there will be 191 100 clock cycles during the 1911 µs.


The exact clock cycle for "Do" is: (100·10^6 Hz)/(2·261.626 Hz) = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0.


![alt text](https://github.com/vjhansen/tone_generator/blob/master/scale.png?raw=true)


---
<img src="https://github.com/vjhansen/tone_generator/blob/master/form.PNG" alt="drawing" width="450"/>


Using the formula to calculate values for the other notes:

*f<sub>Re</sub>* = 293.665 Hz → Count to 170 262.

*f<sub>Mi</sub>* = 329.628 Hz → Count to 151 686.

*f<sub>Fa</sub>* = 349.228 Hz → Count to 143 173.

*f<sub>Sol</sub>* = 391.995 Hz → Count to 127 553.

*f<sub>La</sub>* = 440.000 Hz → Count to 113 636.

*f<sub>Ti</sub>* = 493.883 Hz → Count to 101 239.

We increment a counter until it reaches one of these threshold values, and then toggle the buzzer each time the counter hits the desired value.

---
We need a counter with 18 bits since 191 113 = 10 1110 1010 1000 1001.
When the counter reaches the 18-bit value defined by the switches (e.g. Re), the output will toggle the flip-flop and generate a square wave that plays a note. The counter will then be cleared, and we can resume the counting. 
