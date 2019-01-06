LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_downcounter_top_level IS
END tb_downcounter_top_level;
 
ARCHITECTURE behavior OF tb_downcounter_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT downcounter_top_level
    PORT ( clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           reset_sw : in STD_LOGIC;
           SW_START : in STD_LOGIC;
           MODE     : in STD_LOGIC;
           MIN_UP   : in STD_LOGIC;
           SEC_UP   : in STD_LOGIC;
           BUZZER   : out STD_LOGIC;
           LED1     : out STD_LOGIC;
           LED2     : out STD_LOGIC;
           msec_dig1: out STD_LOGIC_VECTOR(3 downto 0);
           msec_dig2: out STD_LOGIC_VECTOR(3 downto 0);
           mmin_dig1: out STD_LOGIC_VECTOR(3 downto 0);
           mmin_dig2: out STD_LOGIC_VECTOR(3 downto 0)
         );
    END COMPONENT;
    

   --Inputs
   signal clk_i   : STD_LOGIC := '0';
   signal reset_i : STD_LOGIC := '0';
   signal reset_sw_i : STD_LOGIC := '0';
   signal mode_i : STD_LOGIC:='0';
   signal min_up : STD_LOGIC:='0';
   signal sec_up : STD_LOGIC:='0';
   signal sw_start: STD_LOGIC:='0';
    --Outputs
   signal msec_dig1_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal msec_dig2_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal mmin_dig1_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal mmin_dig2_i  : STD_LOGIC_VECTOR(3 downto 0);
   signal BUZZER_i : STD_LOGIC;
   signal LED1_i: STD_LOGIC;
   signal LED2_i: STD_LOGIC;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: downcounter_top_level 
   PORT MAP (
              clk      => clk_i,
              reset    => reset_i,
              reset_sw => reset_sw_i,
              SW_START => sw_start,
              MODE     => mode_i,
              MIN_UP   => min_up,
              SEC_UP   => sec_up,
              msec_dig1       => msec_dig1_i,
              msec_dig2       => msec_dig2_i,
              mmin_dig1       => mmin_dig1_i,
              mmin_dig2       => mmin_dig2_i,
              LED1     => LED1_i,
              LED2     => LED2_i,
              BUZZER   => BUZZER_i
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
      reset_sw_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';
      reset_sw_i <= '0';
      wait for 100 ns;
      mode_i <= '1';
      wait for clk_period*10;
      MIN_UP <= '1';
      SEC_UP <= '1';
      wait for 3 ns;
      MIN_UP <= '0';
      SEC_UP <= '0';
      wait for 2 ns;    
      MIN_UP <= '1';
      SEC_UP <= '1';
      wait for clk_period/2;      
      MIN_UP <= '0';
      SEC_UP <= '0';
      wait for clk_period/2;        
      MIN_UP <= '1';
      SEC_UP <= '1';
      wait for clk_period*32;
      MIN_UP <= '0';
      SEC_UP <= '0';
      wait for clk_period*32;
      mode_i <= '0';
      
      reset_sw_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';
      reset_sw_i <= '0';
      wait for clk_period;
      sw_start <= '1';
      wait for clk_period*32;      
      reset_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';

      -- insert stimulus here 

   end process;
   
END;
