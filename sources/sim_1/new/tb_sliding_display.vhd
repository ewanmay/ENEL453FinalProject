----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2018 03:43:13 PM
-- Design Name: 
-- Module Name: tb_sliding_display - Behavioral
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

entity tb_sliding_display is
--  Port ( );
end tb_sliding_display;

architecture Behavioral of tb_sliding_display is
component sliding_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       reset              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC := '0';
       disp_dig1          : out STD_LOGIC_VECTOR := "0000";
       disp_dig2          : out STD_LOGIC_VECTOR := "0000";
       disp_dig3          : out STD_LOGIC_VECTOR := "0000";
       disp_dig4          : out STD_LOGIC_VECTOR := "0000"
   );
end component;


signal clk       :  STD_LOGIC;        
signal win_1     :  STD_LOGIC;        
signal win_2     :  STD_LOGIC;        
signal reset     :  STD_LOGIC;        
signal BUZZER    :  STD_LOGIC := '0';
signal disp_dig1_i :  STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal disp_dig2_i :  STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal disp_dig3_i :  STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal disp_dig4_i :  STD_LOGIC_VECTOR(3 downto 0) := "0000";

constant clk_period : time := 10 ns;
begin
uut: sliding_disp
PORT MAP (
    clk           => clk,
    win_1         => win_1,
    win_2         => win_2,
    reset         => reset,
    BUZZER        => BUZZER,
    disp_dig1     => disp_dig1_i,    
    disp_dig2     => disp_dig2_i,    
    disp_dig3     => disp_dig3_i,    
    disp_dig4     => disp_dig4_i
);
clk_process: process
    begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
    end process;
    
stim_process: process
    begin
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait for 40 ns;
    win_1 <= '1';
    wait for 1000 ns;
    win_1 <= '0';
    wait for 40 ns; 
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait for 40 ns;
    win_2 <= '1';
    wait for 1000 ns;
    win_2 <= '0';
    wait for 40 ns;    
end process;
 

end Behavioral;
