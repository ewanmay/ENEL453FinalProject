LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_seven_segment_digit_selector IS
END tb_seven_segment_digit_selector;
 
ARCHITECTURE behavior OF tb_seven_segment_digit_selector IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_segment_digit_selector
    PORT(
         clk          : IN  STD_LOGIC;
         digit_select : OUT  STD_LOGIC_VECTOR(3 downto 0);
         an_outputs   : out STD_LOGIC_VECTOR (3 downto 0);
         reset        : IN  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i    : STD_LOGIC := '0';
   signal reset_i  : STD_LOGIC := '0';

    --Outputs
   signal digit_select_i, an_outputs_i : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: seven_segment_digit_selector 
   PORT MAP (
              clk    => clk_i,
              digit_select => digit_select_i,
              an_outputs => an_outputs_i,
              reset  => reset_i
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk_i <= '0';
      wait for clk_period/2;
      clk_i <= '1';
      wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset_i <= '0';
      wait for 100 ns;   
      reset_i <= '1';
      wait for clk_period*10;
      reset_i <= '0';
      -- insert stimulus here 

      wait for clk_period*100;
      wait;
   end process;

END;
