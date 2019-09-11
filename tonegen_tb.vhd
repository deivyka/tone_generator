library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tonegen_tb is
end tonegen_tb;

architecture Behavioral of tonegen_tb is
    constant clk_period : time := 10ns;

component tone_gen
      Port (clk : in std_logic;
            Do, Re, Mi, Fa, Sol, La, Ti : in std_logic;  
            audio_out : out std_logic);
end component;

signal clk, Do, Re, Mi, Fa, Sol, La, Ti : std_logic;  
signal audio_out : std_logic;
begin
uut: tone_gen port map
        (
            clk => clk, Do => Do, Re => Re,
            Mi => Mi, Fa => Fa, Sol => Sol, 
            La => La, Ti => Ti, audio_out => audio_out
        );

clk_process: process
begin 
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim: process
begin
        wait for clk_period*1000*10000; -- 100 ms
        Mi <= '1';
        wait for clk_period*1000*10000;
        Fa <= '1';
        wait for clk_period*1000*10000;
        Sol <= '1';
        wait for clk_period*1000*10000;
        La <= '1';
        wait for clk_period*1000*10000;
        Ti <= '1';
        wait for clk_period*1000*10000;
end process;
end;
