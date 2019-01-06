-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_segment_decoder is
    PORT ( CA    : out STD_LOGIC;
           CB    : out STD_LOGIC;
           CC    : out STD_LOGIC;
           CD    : out STD_LOGIC;
           CE    : out STD_LOGIC;
           CF    : out STD_LOGIC;
           CG    : out STD_LOGIC;
           DP    : out STD_LOGIC;
           dp_in : in  STD_LOGIC;
           data  : in  STD_LOGIC_VECTOR (3 downto 0)
         );
end seven_segment_decoder;

architecture Behavioral of seven_segment_decoder is
   -- Signals:
   signal decoded_bits : STD_LOGIC_VECTOR(6 downto 0);

BEGIN
   
   Decoding: process(data) begin
                                      -- ABCDEFG         7-segment LED pattern for reference
      case data is                    -- 6543210 
         when "0000" => decoded_bits <= "1111110"; -- 0  --      A-6
         when "0001" => decoded_bits <= "0110000"; -- 1  --  F-1     B-5
         when "0010" => decoded_bits <= "1101101"; -- 2  --      G-0
         when "0011" => decoded_bits <= "1111001"; -- 3  --  E-2     C-4
         when "0100" => decoded_bits <= "0110011"; -- 4  --      D-3      DP
-- Students fill in the VHDL code between these two lines
-- The missing code is decoded binary values to the 7-segment display, as needed.
-- Hint, follow the pattern in the case statement, the missing code is in the middle of the case.
--==============================================
         when "0101" => decoded_bits <= "1011011"; -- 5  --      A-6
         when "0110" => decoded_bits <= "1011111"; -- 6  --  F-1     B-5
         when "0111" => decoded_bits <= "1110000"; -- 7  --      G-0
         when "1000" => decoded_bits <= "1111111"; -- 8  --  E-2     C-4
         when "1001" => decoded_bits <= "1110011"; -- 9  --      D-3      DP
--============================================== 
         when "1010" => decoded_bits <= "1100111"; -- P -- need hexadecimal display values for stopwatch
         when "1011" => decoded_bits <= "0001110"; -- L -- need hexadecimal display values for stopwatch
         when "1100" => decoded_bits <= "1110111"; -- A -- need hexadecimal display values for stopwatch
         when "1101" => decoded_bits <= "0111011"; -- Y -- need hexadecimal display values for stopwatch
         when "1110" => decoded_bits <= "1001111"; -- E -- need hexadecimal display values for stopwatch
         when "1111" => decoded_bits <= "1100110"; -- R -- need hexadecimal display values for stopwatch
         when others => decoded_bits <= "0000000"; -- all LEDS off
      end case;
      
   end process;
   
   -- The LEDs that compose the 7-segment displays are actually active-low, so invert logic levels below
   DP <= dp_in; -- this signal just passes through this block
   CA <= not decoded_bits(6);
   CB <= not decoded_bits(5);
   CC <= not decoded_bits(4);
   CD <= not decoded_bits(3);
   CE <= not decoded_bits(2);
   CF <= not decoded_bits(1);
   CG <= not decoded_bits(0);
   
END Behavioral;