library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_bouncing_box is
end tb_bouncing_box;

architecture behavior of tb_bouncing_box is
 -- Component Declaration for the Unit Under Test (UUT)

   COMPONENT bouncing_box
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
           box_color: in STD_LOGIC_VECTOR(11 downto 0);
           box_width: in STD_LOGIC_VECTOR(8 downto 0);
           kHz: in STD_LOGIC;
           red: out STD_LOGIC_VECTOR(3 downto 0);
           blue: out STD_LOGIC_VECTOR(3 downto 0);
           green: out STD_LOGIC_VECTOR(3 downto 0)
         );
    END COMPONENT;
    
    --Inputs
    signal clk : std_logic;
    signal reset : std_logic;
    signal scan_line_x: std_logic_vector(10 downto 0) := "00000000001"; -- stay on the same x,y location
    signal scan_line_y: std_logic_vector(10 downto 0) := "00000000001";
    signal box_color: std_logic_vector(11 downto 0) := "111100001111"; -- don't need to change the color
    signal box_width: std_logic_vector(8 downto 0);
    signal kHz: std_logic;

	--Outputs
    signal red:   std_logic_vector(3 downto 0);
    signal blue:  std_logic_vector(3 downto 0);
    signal green: std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bouncing_box PORT MAP (
          clk => clk,
          reset => reset,
          scan_line_x => scan_line_x,
          scan_line_y => scan_line_y,
          box_color => box_color,
          box_width => box_width,
          kHz => kHz,
          red => red,
          blue => blue,
          green => green                           
        );

   -- Clock process want kHz to be the same frequency for the test
   ClkProcess: process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process; 
   
   -- kHz process
   KHzProcess: process
   begin
        kHz <= '1';
        wait for clk_period;
        kHz <= '0';
        wait for clk_period * 10;
    end process;
        
   -- Reset process
   ResetProcess: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '0';
      wait for 10 ns;	
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
      wait;
   end process;
   
   -- Box width process
    BoxWidth: process
    begin
        box_width <= "000000000";
        wait for 100 ns;
        box_width <= "000000010";
        wait for 100 ns;
        box_width <= "000001000";
        wait for 100 ns;
        box_width <= "000100000";
        wait for 100 ns;
        box_width <= "100000000";
        wait for 100 ns;
        box_width <= "100001000";
        wait for 100 ns;
    end process;
    
END;