----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2018 09:10:24 PM
-- Design Name: 
-- Module Name: tb_random_clk - Behavioral
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

entity tb_random_clk is
--  Port ( );
end tb_random_clk;

architecture Behavioral of tb_random_clk is
component random_clk is
   port (
     enable        : in STD_LOGIC;
     clk           : in  std_logic;
     enable_out    : out std_logic;
     reset         : in STD_LOGIC
   );
 end component;
--inputs
 signal enable_i        : STD_LOGIC := '0';
 signal clk             : STD_LOGIC := '0';
 signal reset_i         : STD_LOGIC;
 signal enable_out_i    : STD_LOGIC;
 
 --clock constant
 constant clk_period : time := 10 ns;
 begin
  uut: random_clk
    PORT MAP (
               enable         =>  enable_i,    
               clk            =>  clk,         
               enable_out     =>  enable_out_i,     
               reset          =>  reset_i 
               
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
        enable_i <= '0';
        reset_i <= '1';
        wait for 40 ns;
        reset_i <= '0';
        wait for 100 ns;
        enable_i <= '1';
        wait;
    end process;
end Behavioral;
