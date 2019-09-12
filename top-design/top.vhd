library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port (clk, reset: in std_logic;
        play_notes : in std_logic_vector(2 downto 0);  
        audio_out : out std_logic);
end top;

architecture Behavioral of top is
signal val : std_logic_vector(17 downto 0);
signal clearing : std_logic;
begin
  u1 : entity work.UniBitCnt port map
          (
              clk => clk, reset => reset, clear_sig => clearing, c_out => val         
          );

  ut : entity work.tone_gen port map
        (
          clk=>clk, val_in=>val, play_notes=>play_notes,
          clearing=>clearing, audio_out=>audio_out       
        );
end Behavioral;
