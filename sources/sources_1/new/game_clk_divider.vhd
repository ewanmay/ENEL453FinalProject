-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end game_clock_divider;

architecture Behavioral of game_clock_divider is
-- Signals:
signal kilohertz, tenths, hundredths, thousandths, second_top: STD_LOGIC;
signal ten_i : STD_LOGIC_VECTOR(3 downto 0);
signal hun_i : STD_LOGIC_VECTOR(3 downto 0);
signal tho_i    : STD_LOGIC_VECTOR(3 downto 0);
signal sec_i   : STD_LOGIC_VECTOR(3 downto 0);
signal enable_i : STD_LOGIC:= '0';
signal en_allow : STD_LOGIC:= '1';
signal random_clk_i: STD_LOGIC_VECTOR(7 downto 0);
signal hun_start, ten_start: STD_LOGIC_VECTOR(3 downto 0);
-- Components declarations
component game_upcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

BEGIN
   
   kHzClock: game_upcounter
   generic map(
               period => (100000),   -- divide by 100_000 to divide 100 MHz down to 1 KHz 
--               period => (10),   -- for sim testing
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => kilohertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );
   
  thousandthsClock: game_upcounter
  generic map(
              period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
              WIDTH  => 4
             )
  PORT MAP (
              clk    => clk,
              reset  => reset,
              enable => kilohertz,
              zero   => thousandths,
              value  => tho_i
           );
           
 hundredthsClock: game_upcounter
  generic map(
              period => (10),   -- Counts numbers between 0 and 5 -> that's 6 values!
              WIDTH  => 4
             )
  PORT MAP (
              clk    => clk,
              reset  => reset,
              enable => thousandths,
              zero   => hundredths,
              value  => hun_i       
           );
tenthsClock: game_upcounter
  generic map(
              period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
              WIDTH  => 4
             )
  PORT MAP (
              clk    => clk,
              reset  => reset,
              enable => hundredths,
              zero   => tenths,
              value  => ten_i
           );
                         
secondClock: game_upcounter
 generic map(
             period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
             WIDTH  => 4
            )
 PORT MAP (
             clk    => clk,
             reset  => reset,
             enable => tenths,
             zero   => second_top,
             value  => sec_i
          );
  sec_dig1 <= tho_i;
  sec_dig2 <= hun_i;
  min_dig1 <= ten_i;
  min_dig2 <= sec_i;
END Behavioral;