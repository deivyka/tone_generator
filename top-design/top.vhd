
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port (clk: in std_logic;
        Do_btn, Re_btn, Mi_btn, Fa_btn, Sol_btn, La_btn, Ti_btn : in std_logic;  
        audio_out : out std_logic);
end top;

architecture Behavioral of top is
begin

ut : entity work.tone_gen port map(
        clk => clk,
        Do => Do_btn,
        Re => Re_btn,
        Mi => Mi_btn,
        Fa => Fa_btn,
        Sol => Sol_btn,
        La => La_btn,
        Ti => Ti_btn,
        audio_out => audio_out       
);

end Behavioral;