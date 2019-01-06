----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/20/2018 09:13:07 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           confirmed_press : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

signal counter: STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
signal last_on: STD_LOGIC:= '0';
--debounce target
constant target: STD_LOGIC_VECTOR(9 downto 0) := "1111101000";
begin
Process(CLK)     
    begin     
    if(rising_edge(CLK)) then
        if(counter = target and last_on = '0') then
            confirmed_press <= '1';
            counter         <= (others => '0');
            last_on         <= '1';
        elsif(input = '1' and counter < target) then
            counter         <= (counter + 1);
            confirmed_press <= '0';
        elsif(input = '0' and counter > 0) then
            counter         <= (counter - 1);
            confirmed_press <= '0';
        elsif(counter = "0000000000") then
            last_on         <= '0';
        end if;     
    end if;
     
    end process;
    
 
end Behavioral;