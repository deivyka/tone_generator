# Tone Generator for octave 4.

(http://bit.ly/30YTM7I). 

This circuit is actually little more than a modulus counter plus toggle flip-flop – to give you an example, we may consider the first note “Do" at 261.626 Hz (just a little more than 261 Hz):
This frequency corresponds to a period of 3822 microseconds, meaning that the counter should issue a pulse to toggle the flip-flop every 3822 / 2 = 1911 µs.

Since the Basys-3 clock frequency is 100 MHz (10 ns period), there will be 191 100 clock cycles during the 1911 µs – actually the exact value is ((1/261.626)*1000000000/2)/10 = 191 113. This means that the counter must count from 0 to 191 113, then generate a ticking pulse to toggle the flip-flop, and restart counting from 0 (in other words, we need a counter with 18 bits)
All the other notes have higher frequency, so the counter will restart at lower values (for example, the “Re" frequency at 293.665 Hz requires the counter to go up to ((1/293.665)*1000000000/2)/10 = 170 262 before restarting)

This means that we need an 18-bit counter with a synchronous clear input, and a small combinational circuit that will set “clear" to ‘1’ when the counter reaches the value corresponding to the external switch pattern that defines the note. The same ticking pulse driving the counter “clear" input will toggle the flip-flop, so I think that it’s just these three blocks: counter + combinational circuit + toggle flip-flop.

