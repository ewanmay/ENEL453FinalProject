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

entity tb_randomizer is
--  Port ( );
end tb_randomizer;

architecture Behavioral of tb_randomizer is
component randomizer is
   port (
     clk           : in  std_logic;
     rstb          : in  std_logic;
     sync_reset    : in  std_logic;
     seed          : in  std_logic_vector (7 downto 0);
     en            : in  std_logic;
     lsfr_out      : out std_logic_vector (7 downto 0)
   );
 end component;
--inputs
 signal input       : STD_LOGIC := '0';
 signal clk         : STD_LOGIC := '0';
 signal sync_reset  : STD_LOGIC := '0';
 signal rstb        : STD_LOGIC := '0';
 signal seed        : STD_LOGIC_VECTOR (7 downto 0):= "11010101";
 signal en          : STD_LOGIC := '0';
 --outputs
 signal lsfr_out    : STD_LOGIC_VECTOR (7 downto 0):= "00000000";
 
 --clock constant
 constant clk_period : time := 10 ns;
 begin
  uut: randomizer
    PORT MAP (
                clk         =>  clk,      
                rstb        =>  rstb,      
                sync_reset  =>  sync_reset,
                seed        =>  seed,      
                en          =>  en,        
                lsfr_out    =>  lsfr_out  
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
        sync_reset <= '1';
        wait for 40 ns;
        rstb <= '1';
        wait for 20 ns;
        sync_reset <= '0';
        wait for 20 ns;
        en <= '1';
        wait for 300ns;
    end process;
end Behavioral;
