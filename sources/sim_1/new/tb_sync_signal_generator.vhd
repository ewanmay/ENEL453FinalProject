library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sync_signal_generator is
end tb_sync_signal_generator;

architecture behaviour of tb_sync_signal_generator is

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sync_signals_generator
     Port ( pixel_clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            hor_sync: out STD_LOGIC;
            ver_sync: out STD_LOGIC;
            blank: out STD_LOGIC;
            scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
            scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
          );
    END COMPONENT;
    
    --Inputs
    signal pixel_clk : std_logic;
    signal reset : std_logic;

	--Outputs
    signal hor_sync: STD_LOGIC;
    signal ver_sync: STD_LOGIC;
    signal blank: STD_LOGIC;
    signal scan_line_x: STD_LOGIC_VECTOR(10 downto 0);
    signal scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sync_signals_generator PORT MAP (
          pixel_clk => pixel_clk,
          reset => reset,
          hor_sync => hor_sync,
          ver_sync => ver_sync,
          blank => blank,
          scan_line_x => scan_line_x,
          scan_line_y => scan_line_y
        );

   -- Clock process
   ClkProcess :process
   begin
		pixel_clk <= '0';
		wait for clk_period/2;
		pixel_clk <= '1';
		wait for clk_period/2;
   end process; 

   -- Reset process
   ResetProcess: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait;
   end process;

END;