library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sample_clock is
  Port (
    score_1: in STD_LOGIC_VECTOR(3 downto 0); 
    score_2: in STD_LOGIC_VECTOR(3 downto 0);
    seconds: in STD_LOGIC_VECTOR(3 downto 0);
    hundredths: in STD_LOGIC_VECTOR(3 downto 0);
    tenths: in STD_LOGIC_VECTOR(3 downto 0);
    thousandths: in STD_LOGIC_VECTOR(3 downto 0);
    clk: in STD_LOGIC;
    win_1: in STD_LOGIC;
    win_2: in STD_LOGIC;
    rounds_array: in STD_LOGIC_VECTOR(159 downto 0);
    round_winners: in STD_LOGIC_VECTOR(9 downto 0);
   );
   
end sample_clock;

architecture Behavioral of sample_clock is

begin


end Behavioral;
