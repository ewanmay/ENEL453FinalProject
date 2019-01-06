----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2018 10:46:17 PM
-- Design Name: 
-- Module Name: tb_downcounter_alarm - Behavioral
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

entity tb_downcounter_alarm is
--  Port ( );
end tb_downcounter_alarm;

architecture Behavioral of tb_downcounter_alarm is
 component downcounter_alarm is
   Port ( sec_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
          sec_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
          min_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
          min_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
          led1 : out STD_LOGIC;
          led2 : out STD_LOGIC;
          buzzer : out STD_LOGIC);
end component;

signal sec_dig1_i, sec_dig2_i, min_dig1_i, min_dig2_i: STD_LOGIC_VECTOR(3 downto 0);

signal led1_i, led2_i, buzzer_i: STD_LOGIC;


begin
uut: downcounter_alarm
    PORT MAP(
        sec_dig1 => sec_dig1_i,
        sec_dig2 => sec_dig2_i,
        min_dig1 => min_dig1_i,
        min_dig2 => min_dig2_i,
        led1 => led1_i,
        led2 => led2_i,
        buzzer => buzzer_i   
    );

stim_proc: process 
begin   
    sec_dig1_i <= "0001";
    sec_dig2_i <= "0001";
    min_dig1_i <= "0001";
    min_dig2_i <= "0001";
    wait for 100 ns;    
    sec_dig1_i <= "0000";
    sec_dig2_i <= "0000";
    min_dig1_i <= "0000";
    min_dig2_i <= "0000";
    wait for 100 ns;    
end process;
    


end Behavioral;
