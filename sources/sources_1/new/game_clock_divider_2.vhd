-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity three_sec_countdown is
    PORT ( clk          : in STD_LOGIC;
           reset        : in STD_LOGIC;
           enable       : in STD_LOGIC;
           sec_dig1     : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2     : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1     : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2     : out STD_LOGIC_VECTOR(3 downto 0);
           enable_out   : out STD_LOGIC;
           enable_cd    : out STD_LOGIC 
           );
end three_sec_countdown;

architecture Behavioral of three_sec_countdown is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz, tensseconds, onesminutes, singlesec, tensmin: STD_LOGIC;
signal singleSeconds : STD_LOGIC_VECTOR(3 downto 0);
signal singleMinutes : STD_LOGIC_VECTOR(3 downto 0);
signal tenSeconds    : STD_LOGIC_VECTOR(3 downto 0);
signal tenMinutes   : STD_LOGIC_VECTOR(3 downto 0);
signal enable_i : STD_LOGIC:= '0';
signal en_allow : STD_LOGIC:= '1';
-- Components declarations
component game_downcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              first_value : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

BEGIN
   oneHzClock: game_downcounter
   generic map(
               period => (100000000),   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
--               period => (10),   -- for sim testing
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable_i,
               zero   => onehertz, -- this is a 1 Hz clock signal
               value  => open,  -- Leave open since we won't display this value
--               first_value => "0101111101011110000100000000" -- "0000000000000000000000001010"
               first_value => "0000000000000000000000001010"
            );
   
   singleSecondsClock: game_downcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               zero   => singlesec,
               value  => singleSeconds, -- binary value of seconds we decode to drive the 7-segment display    
               first_value => "0101"  
            );
   
tensSecondsClock: game_downcounter
   generic map(
               period => (6),   -- Counts numbers between 0 and 5 -> that's 6 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => singlesec,
               zero   => tensseconds,
               value  => tenSeconds, -- binary value of seconds we decode to drive the 7-segment display
               first_value =>  "0000"        
            );
            
singleMinutesClock: game_downcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => tensseconds,
               zero   => onesminutes,
               value  => singleMinutes, -- binary value of seconds we decode to drive the 7-segment display
               first_value =>  "0000"         
            );
                        
 tensMinutesClock: game_downcounter
   generic map(
               period => (6),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onesminutes,
               zero   => tensmin,
               value  => tenMinutes, -- binary value of seconds we decode to drive the 7-segment display
               first_value =>  "0000"        
            );
            
            
  ending : process (tensmin, clk, reset, singleSeconds, tenSeconds, singleMinutes, tenMinutes, enable)
  begin
  
        if(rising_edge(clk)) then
            if(reset = '1') then
                en_allow <= '1';
                enable_out <= '0';
                enable_cd <= '1';
            elsif(
            singleSeconds = "0000" AND
            tenSeconds    = "0000" AND
            singleMinutes = "0000" AND
            tenMinutes    = "0000" AND        
            enable = '1'
            ) then
                en_allow <= '0';
                enable_out <= '1';                
                enable_cd <= '0';
            end if;
        end if;
  end process;
 
  sec_dig1 <= singleSeconds;
  sec_dig2 <= tenSeconds;
  min_dig1 <= singleMinutes;
  min_dig2 <= tenMinutes;
  enable_i <= en_allow AND enable;
END Behavioral;