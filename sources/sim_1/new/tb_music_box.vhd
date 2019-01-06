library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_music_box is
--  Port ( );
end tb_music_box;

architecture Behavioral of tb_music_box is
component music_box is 
   Port (
    clk: in STD_LOGIC;
    reset: in STD_LOGIC;
    enable: in STD_LOGIC;
    buzzer_out: out STD_LOGIC;
    counter_out: out STD_LOGIC_VECTOR(3 downto 0);
    b_en: OUT STD_LOGIC;
    c_en: OUT STD_LOGIC;
    d_en: OUT STD_LOGIC
    );
end component;
 
--inputs
signal enable: STD_LOGIC := '0';
signal b_en: STD_LOGIC := '0';
signal c_en: STD_LOGIC := '0';
signal d_en: STD_LOGIC := '0';

signal counter_out: STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal reset: STD_LOGIC := '0';
signal clk: STD_LOGIC := '0';
--outputs
signal buzzer_out: STD_LOGIC;

--clock constant
constant clk_period : time := 10 ns;
begin
 uut: music_box
    PORT MAP (
               reset => reset,
               clk => clk,
               enable => enable,
               buzzer_out => buzzer_out,
               d_en => d_en,
               b_en => b_en,
               c_en => c_en,
               counter_out => counter_out
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
            wait for 30 ns;
            reset <= '0';
            wait for 30 ns;    
            enable <= '1';
            wait;
   end process;
end Behavioral;
