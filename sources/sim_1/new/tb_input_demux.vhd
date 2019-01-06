LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity tb_input_mux is
end entity;

ARCHITECTURE behavior OF tb_input_mux IS 

 COMPONENT input_mux
    PORT (   
          selector               : in STD_LOGIC;
          MIN_UP_IN              : in STD_LOGIC;
          SEC_UP_IN              : in STD_LOGIC;
          TIMER_RESET_IN         : in STD_LOGIC;
          COUNTER_RESET_IN       : in STD_LOGIC;
          LAP_MODE_IN            : in STD_LOGIC;
          SW_START_IN            : in STD_LOGIC;
          MIN_UP_OUT             : out STD_LOGIC;
          SEC_UP_OUT             : out STD_LOGIC;
          TIMER_RESET_OUT1        : out STD_LOGIC;
          COUNTER_RESET_OUT      : out STD_LOGIC;          
          TIMER_RESET_OUT2        : out STD_LOGIC;
          LAP_MODE_OUT1          : out STD_LOGIC;
          LAP_MODE_OUT2          : out STD_LOGIC;        
          SW_START_OUT1          : out STD_LOGIC;  
          SW_START_OUT2          : out STD_LOGIC
        );
END COMPONENT;
signal min_up, sec_up, timer_reset, lap_mode, sw_start, counter_reset, selector: STD_LOGIC;
signal min_up_i, sec_up_i, timer_reset2_i, timer_reset1_i, counter_reset_i: STD_LOGIC;
signal lap_mode2_i,lap_mode1_i, sw_start2_i, sw_start1_i: STD_LOGIC;


BEGIN
  uut: input_mux
   PORT MAP (
         selector              => selector,
         MIN_UP_IN             => min_up,
         SEC_UP_IN             => sec_up,
         TIMER_RESET_IN        => timer_reset,
         COUNTER_RESET_IN      => counter_reset,
         LAP_MODE_IN           => lap_mode,
         SW_START_IN           => sw_start,
         MIN_UP_OUT            => min_up_i,
         SEC_UP_OUT            => sec_up_i,
         TIMER_RESET_OUT1      => timer_reset1_i,
         COUNTER_RESET_OUT     => counter_reset_i,        
         TIMER_RESET_OUT2      => timer_reset2_i,          
         LAP_MODE_OUT1         => lap_mode1_i,
         LAP_MODE_OUT2         => lap_mode2_i,       
         SW_START_OUT1         => sw_start1_i,            
         SW_START_OUT2         => sw_start2_i
              );     
     stim_proc: process
     begin
     selector <= '0';
     min_up <= '1';
     sec_up <= '1';
     sw_start <= '1';
     timer_reset <='1';
     wait for 40 ns;     
     sw_start <= '1';
     counter_reset <= '1';
     timer_reset <= '0';
     lap_mode <= '1';
     wait for 40 ns;
     selector <= '1';
     wait for 100 ns;
     counter_reset <= '1';      
     sw_start <= '0';
     end process;
     
END;