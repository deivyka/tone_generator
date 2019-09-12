library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tone_gen is
    Port (  clk, reset: in std_logic;
            note_sw : in std_logic_vector(2 downto 0);
            audio_out : out std_logic);
end tone_gen;

architecture Behavioral of tone_gen is
    signal Q : std_logic_vector(17 downto 0) := (others => '0');
    signal buzz: std_logic := '0'; 
    signal clear : std_logic;
    signal note : std_logic_vector (17 downto 0);
    signal ffin, ffout : unsigned(17 downto 0);
    
    constant n_Do  : std_logic_vector := "101110101010001001";  -- 191 113
    constant n_Re  : std_logic_vector := "101001100100010110";  -- 170 262
    constant n_Mi  : std_logic_vector := "100101000010000110";  -- 151 686
    constant n_Fa  : std_logic_vector := "100010111101000101";  -- 143 173
    constant n_Sol : std_logic_vector := "011111001001000001";   -- 127 553
    constant n_La  : std_logic_vector := "011011101111100100";   -- 113 636
    constant n_Ti  : std_logic_vector := "011000101101110111";   -- 101 239
begin

-- state register section
process (clk, reset)
begin
    if (reset='1') then
        ffout <= (others => '0');
    elsif rising_edge(clk) then
        ffout <= ffin;
    end if;
end process;
-- Next-state logic (combinational)
ffin <= (others => '0') when (clear = '1') 
            else ffout+1;
-- output logic (combinational)
Q <= std_logic_vector(ffout);
process(Q, note)
    begin
        if(Q >= note) then
            clear <= '1';
            buzz <= not buzz;
        else 
            buzz <= '0';
            clear <= '0';
        end if;
audio_out <= buzz;
end process;
with note_sw select note <=
    n_Do when "001",
    n_Re when "010",
    n_Mi when "011",
    n_Fa when "100",
    n_Sol when "101",
    n_La when "110",
    n_Ti when "111",
    (others =>'0') when others;
end Behavioral;
