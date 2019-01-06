library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_debounce is
--  Port ( );
end tb_debounce;

architecture Behavioral of tb_debounce is
component debounce is 
   Port ( input : in STD_LOGIC;
        clk : in STD_LOGIC;
        confirmed_press : out STD_LOGIC);
end component;
 
--inputs
signal input: STD_LOGIC := '0';
signal clk: STD_LOGIC := '0';
--outputs
signal confirmed_press: STD_LOGIC;

--clock constant
constant clk_period : time := 10 ns;
begin
 uut: debounce
   PORT MAP (
               input => input,
               clk => clk,
               confirmed_press => confirmed_press
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
            input <= '1';
            wait for 3 ns;
            input <= '0';
            wait for 2 ns;    
            input <= '1';
            wait for clk_period/2;
            input <= '0';
            wait for clk_period/2;        
            input <= '1';
            wait for clk_period*32;
            input <= '0';
            wait for clk_period*32;
   end process;
end Behavioral;
