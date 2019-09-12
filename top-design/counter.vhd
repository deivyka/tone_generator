library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity UniBitCnt is
  Port (clk, reset: in std_logic;
        clear_sig : in std_logic;
        c_out : out std_logic_vector(17 downto 0));
end UniBitCnt;

architecture Behavioral of UniBitCnt is
    signal ffin, ffout : unsigned(17 downto 0);
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
ffin <= (others => '0') when (clear_sig = '1') else -- clear c_out
        ffout+1;      -- count up
-- output logic (combinational)
c_out <= std_logic_vector(ffout);
end Behavioral;
