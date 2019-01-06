LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_stopwatch_top_level IS
END tb_stopwatch_top_level;
 
ARCHITECTURE behavior OF tb_stopwatch_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stopwatch_top_level
    PORT(     
               clk      : in  STD_LOGIC;     
               reset    : in  STD_LOGIC;
               SW_START : in  STD_LOGIC;
               LAP_TIME : in  STD_LOGIC;
               msec_dig1: out STD_LOGIC_VECTOR(3 downto 0);
               msec_dig2: out STD_LOGIC_VECTOR(3 downto 0);
               mmin_dig1: out STD_LOGIC_VECTOR(3 downto 0);
               mmin_dig2: out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i   : STD_LOGIC := '0';
   signal reset_i : STD_LOGIC := '0';
   signal lap_time_i : STD_LOGIC:='0';
   signal sw_start_i : STD_LOGIC:='0';

    --Outputs
   signal msec_dig1_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal msec_dig2_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal mmin_dig1_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal mmin_dig2_i  : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: stopwatch_top_level 
   PORT MAP (
              clk      => clk_i,
              reset    => reset_i,
              SW_START => sw_start_i,
              LAP_TIME => lap_time_i,
              mmin_dig2 => mmin_dig2_i,
              mmin_dig1 => mmin_dig1_i,
              msec_dig2 => msec_dig2_i,
              msec_dig1 => msec_dig1_i
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
      reset_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';
      sw_start_i <= '1';
      wait for 100 ns;
      lap_time_i <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;
   
END;
