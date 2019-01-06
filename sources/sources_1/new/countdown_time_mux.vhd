----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2018 08:49:22 PM
-- Design Name: 
-- Module Name: COUNTDOWN_TIMER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countdown_time_mux is
 Port(
       sec_dig1           : in STD_LOGIC_VECTOR(3 downto 0);
       sec_dig2           : in STD_LOGIC_VECTOR(3 downto 0);
       min_dig1           : in STD_LOGIC_VECTOR(3 downto 0);
       min_dig2           : in STD_LOGIC_VECTOR(3 downto 0);
       cd_sec_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_sec_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_min_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_min_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       selector           : in STD_LOGIC;
       tm_sec_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_sec_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig2        : out STD_LOGIC_VECTOR(3 downto 0)
   );
end countdown_time_mux;

architecture Behavioral of countdown_time_mux is


begin
output: process
    (   
    selector, 
    sec_dig1,
    sec_dig2,
    min_dig1,
    min_dig2, 
    cd_sec_dig1, 
    cd_sec_dig2, 
    cd_min_dig1, 
    cd_min_dig2
    ) 
begin
    if(selector = '1') then
        tm_sec_dig1 <= cd_sec_dig1;
        tm_sec_dig2 <= cd_sec_dig2;
        tm_min_dig1 <= cd_min_dig1;
        tm_min_dig2 <= cd_min_dig2; 
    else 
        tm_sec_dig1 <= sec_dig1;
        tm_sec_dig2 <= sec_dig2;
        tm_min_dig1 <= min_dig1;
        tm_min_dig2 <= min_dig2; 
    end if;

end process;

end Behavioral;