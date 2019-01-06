----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2018 12:54:58 PM
-- Design Name: 
-- Module Name: tb_win_disp - Behavioral
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

entity tb_win_disp is
--  Port ( );
end tb_win_disp;

architecture Behavioral of tb_win_disp is
component win_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC;
       led1               : out STD_LOGIC;
       led2               : out STD_LOGIC;
       led3               : out STD_LOGIC;
       led4               : out STD_LOGIC  
   );
   
end component;

 signal   clk      : STD_LOGIC := '0';
 signal   win_1_i    : STD_LOGIC := '0';
 signal   win_2_i    : STD_LOGIC := '0';
 signal   BUZZER_i   : STD_LOGIC := '0';
 signal   led1_i     : STD_LOGIC := '0';
 signal   led2_i     : STD_LOGIC := '0';
 signal   led3_i     : STD_LOGIC := '0';
 signal   led4_i     : STD_LOGIC := '0';
 
 constant clk_period : time := 10 ns;
begin


uut: win_disp
PORT MAP (
     clk     =>   clk,
    win_1    =>   win_1_i,
    win_2    =>   win_2_i,
    BUZZER   =>   BUZZER_i,
    led1     =>   led1_i,
    led2     =>   led2_i,
    led3     =>   led3_i,
    led4     =>   led4_i
);

clk_process: process
begin
   clk <= '0';
   wait for clk_period/2;
   clk <= '1';
   wait for clk_period/2;
end process;
        
stim_proc: process
begin
   win_1_i <= '1';
   win_2_i <= '0';
   wait for 1000ns;
   win_1_i <= '0';
   wait for 40 ns;
   win_2_i <= '1';  
   win_1_i <= '0';
      wait for 1000ns; 
   win_2_i <= '0';   
    wait for 40 ns;
end process;

end Behavioral;
