library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tone_gen is
    Port (  clk: in std_logic;
            val_in : in std_logic_vector(17 downto 0);
            play_notes : in std_logic_vector(2 downto 0);
            clearing : out std_logic;
            audio_out : out std_logic);
end tone_gen;

architecture Behavioral of tone_gen is
    signal cnt : std_logic_vector(17 downto 0) := (others => '0');
    signal buzz : std_logic;
    signal note : std_logic_vector(2 downto 0);
    signal choose_note : std_logic_vector (17 downto 0);
    
    constant n_Do  : std_logic_vector := "101110101010001001";  -- 191 113
    constant n_Re  : std_logic_vector := "101001100100010110";  -- 170 262
    constant n_Mi  : std_logic_vector := "100101000010000110";  -- 151 686
    constant n_Fa  : std_logic_vector := "100010111101000101";  -- 143 173
    constant n_Sol : std_logic_vector := "011111001001000001";   -- 127 553
    constant n_La  : std_logic_vector := "011011101111100100";   -- 113 636
    constant n_Ti  : std_logic_vector := "011000101101110111";   -- 101 239
begin

with play_notes select choose_note <=
    n_Do    when "001",
    n_Re    when "010",
    n_Mi    when "011",
    n_Fa    when "100",
    n_Sol   when "101",
    n_La    when "110",
    n_Ti    when "111",
    (others =>'0') when "000";      
process(buzz, val_in, choose_note)
    begin
        if(val_in >= choose_note) then
            clearing <= '1';
            buzz <= not buzz;
        else 
            clearing <= '0';
        end if;
end process;
audio_out <= buzz;
end Behavioral;
