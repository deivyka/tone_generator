library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity tone_gen is
    Port (clk: in std_logic;
          Do, Re, Mi, Fa, Sol, La, Ti : in std_logic; 
          audio_out : out std_logic);
end tone_gen;

architecture Behavioral of tone_gen is
    signal cnt : std_logic_vector(17 downto 0) := (others => '0');
    signal buzz : std_logic := '0';
    signal note : std_logic_vector(2 downto 0);
    signal clear : std_logic := '0';
 
    constant n_Do  : std_logic_vector := "101110101010001001";  -- 191 113
    constant n_Re  : std_logic_vector := "101001100100010110";  -- 170 262
    constant n_Mi  : std_logic_vector := "100101000010000110";  -- 151 686
    constant n_Fa  : std_logic_vector := "100010111101000101";  -- 143 173
    constant n_Sol : std_logic_vector := "11111001001000001";   -- 127 553
    constant n_La  : std_logic_vector := "11011101111100100";   -- 113 636
    constant n_Ti  : std_logic_vector := "11000101101110111";   -- 101 239

begin
u1 : entity work.UniBitCnt port map(
            clk => clk,
            clear => clear,
            c_out => cnt         
);

count_process : process(note, cnt, buzz)
    begin
            case note is
                when "000" => -- Do
                    if (cnt = n_Do) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
                --------------------
                when "001" => -- Re
                    if (cnt = n_Re) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               --------------------     
               when "010" => -- Mi
                    if (cnt = n_Mi) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               --------------------     
               when "011" => -- Fa
                    if (cnt = n_Fa) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               --------------------     
               when "100" => -- Sol
                    if (cnt = n_Sol) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               --------------------     
               when "101" => -- La
                    if (cnt = n_La) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               --------------------
               when "110" => -- Ti
                    if (cnt = n_Ti) then
                        clear <= '1';
                        buzz <= not buzz;
                    else clear <= '0';
                    end if;
               
               when others =>
                    buzz <= '0';
                    clear <= '1';
            end case;      
    end process count_process;
 audio_out <= buzz;


-- play notes using buttons
play : process(Do, Re, Mi, Fa, Sol, La, Ti)
    begin
            if Do = '1' then
                note <= "000"; 
            elsif Re = '1' then
                note <= "001";
            elsif Mi = '1' then
                note <= "010";
            elsif Fa = '1' then
                note <= "011";
            elsif Sol = '1' then
                note <= "100";               
            elsif La = '1' then
                note <= "101";
            elsif Ti = '1' then
                note <= "110";
            else note <= "111";
            end if;
    end process play;          
end Behavioral;