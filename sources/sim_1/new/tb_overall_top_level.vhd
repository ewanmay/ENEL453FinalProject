LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_overall_top_level IS
END tb_overall_top_level;
 
ARCHITECTURE behavior OF tb_overall_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT overall_top_level is
        Port ( min_up        : in STD_LOGIC;
               sec_up        : in STD_LOGIC;
               timer_reset   : in STD_LOGIC;
               counter_reset : in STD_LOGIC;
               lap_mode      : in STD_LOGIC;
               selector      : in STD_LOGIC;
               sw_start      : in STD_LOGIC;
               clk           : in STD_LOGIC;           
               CA            : out STD_LOGIC;
               CB            : out STD_LOGIC;
               CC            : out STD_LOGIC;
               CD            : out STD_LOGIC;
               CE            : out STD_LOGIC;
               CF            : out STD_LOGIC;
               CG            : out STD_LOGIC;
               DP            : out STD_LOGIC;
               AN1           : out STD_LOGIC;
               AN2           : out STD_LOGIC;
               AN3           : out STD_LOGIC;
               AN4           : out STD_LOGIC;
               BUZZER        : out STD_LOGIC;
               LED1          : out STD_LOGIC;
               LED2          : out STD_LOGIC
               );
    END COMPONENT;
    

   --Inputs
   signal clk_i   : STD_LOGIC := '0';
   signal timer_reset_i : STD_LOGIC := '0';
   signal selector_i : STD_LOGIC:='0';
   signal sw_start_i : STD_LOGIC:='0';
   signal lap_mode_i   : STD_LOGIC := '0';
   signal counter_reset_i : STD_LOGIC := '0';
   signal sec_up_i : STD_LOGIC:='0';
   signal min_up_i : STD_LOGIC:='0';

    --Outputs
  signal  CA            :  STD_LOGIC;
  signal  CB            :  STD_LOGIC;
  signal  CC            :  STD_LOGIC;
  signal  CD            :  STD_LOGIC;
  signal  CE            :  STD_LOGIC;
  signal  CF            :  STD_LOGIC;
  signal  CG            :  STD_LOGIC;
  signal  DP            :  STD_LOGIC;
  signal  AN1           :  STD_LOGIC;
  signal  AN2           :  STD_LOGIC;
  signal  AN3           :  STD_LOGIC;
  signal  AN4           :  STD_LOGIC;
  signal  BUZZER        :  STD_LOGIC;
  signal  LED1          :  STD_LOGIC;
  signal  LED2          :  STD_LOGIC;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
   -- Instantiate the Unit Under Test (UUT)
   uut: overall_top_level 
   PORT MAP (
              clk      => clk_i,
              timer_reset => timer_reset_i,
              counter_reset => counter_reset_i,
              sw_start => sw_start_i,
              lap_mode => lap_mode_i,
              selector => selector_i,
              sec_up => sec_up_i,
              min_up => min_up_i,
              CA => CA,
              CB => CB,
              CC => CC,
              CD => CD,
              CE => CE,
              CF => CF,
              CG => CG,
              DP => DP,
              AN1 => AN1,
              AN2 => AN2,
              AN3 => AN3,
              AN4 => AN4,
              BUZZER => BUZZER,
              LED1 => LED1,
              LED2 => LED2
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
      
      timer_reset_i <= '1';
      wait for 40 ns;
      timer_reset_i <= '0';
      sw_start_i <= '1';
      wait for 100 ns;
      lap_mode_i <= '1';
      wait for 30 ns;
      lap_mode_i <='0';
      wait for 30 ns;
      sw_start_i <= '0';
      wait for 30 ns;
      sw_start_i <= '1'; 
      wait for 100 ns;  
      timer_reset_i <= '1';
      wait for 20 ns;
      timer_reset_i <= '0';
      sw_start_i <= '0';
      selector_i <= '1';      
      wait for 20 ns;
      lap_mode_i <= '1';     
      wait for 20 ns;      
      min_up_i <= '1';
      SEC_UP_i <= '1';
      wait for 3 ns;
      min_up_i <= '0';
      SEC_UP_i <= '0';
      wait for 2 ns;    
      min_up_i <= '1';
      SEC_UP_i <= '1';
      wait for clk_period/2;      
      min_up_i <= '0';
      SEC_UP_i <= '0';
      wait for clk_period/2;        
      min_up_i <= '1';
      SEC_UP_i <= '1';
      wait for clk_period*32;
      min_up_i <= '0';
      SEC_UP_i <= '0';
      wait for 100 ns;
      lap_mode_i <= '0';
      counter_reset_i <= '1';    
      wait for 20 ns;      
      lap_mode_i <= '0';
      counter_reset_i <= '0';          
      sw_start_i <= '1';     
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;
   
END;
