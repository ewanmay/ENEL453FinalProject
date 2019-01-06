library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_vga_module is
end tb_vga_module;

ARCHITECTURE behavior OF tb_vga_module IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_module
    Port (  clk : in  STD_LOGIC;
            buttons: in STD_LOGIC_VECTOR(2 downto 0);
            switches: in STD_LOGIC_VECTOR(13 downto 0);
            red: out STD_LOGIC_VECTOR(3 downto 0);
            green: out STD_LOGIC_VECTOR(3 downto 0);
            blue: out STD_LOGIC_VECTOR(3 downto 0);
            hsync: out STD_LOGIC;
            vsync: out STD_LOGIC
         );
    END COMPONENT;
    
    --Inputs
    signal clk : std_logic;
    signal buttons : std_logic_vector(2 downto 0);
    signal switches: std_logic_vector(13 downto 0);

	--Outputs
	signal red: std_logic_vector(3 downto 0);
	signal green: std_logic_vector(3 downto 0);
	signal blue: std_logic_vector(3 downto 0);
    signal hsync: std_logic;
    signal vsync: std_logic;
    

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_module PORT MAP (
            clk => clk,
            buttons => buttons,
            switches => switches,
            red => red,
            green => green,
            blue => blue,
            hsync => hsync,
            vsync => vsync                       
        );

   -- Clock process 
   Clock :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process; 

   -- Stimulus process
   Stimulus: process
   begin
        -- Reset and sync tests
        buttons <= "000"; -- This sets all buttons to 0
        switches <= "00000000000000"; -- This sets all switches to 0
        wait for 20 ns;
        buttons(0) <= '1';
        wait for 200 ns;
        buttons(0) <= '0';
        wait for 200 ns;
        
        -- Test the box color
        switches(5 downto 2) <= "1111"; -- blue
        wait for 200 ns;
        switches(9 downto 6) <= "1111"; -- green
        wait for 200 ns;
        switches(13 downto 10) <= "1111"; -- red
        wait for 200 ns;
        
        -- Test changing box size (Counter operates on 100 Hz)
        buttons(1) <= '1'; -- increase size
        wait for 30 ms;
        buttons(1) <= '0';
        buttons(2) <= '1'; -- decrease size
        wait for 20 ms;
        buttons(2) <= '0';
        wait for 10 ms;
        
        -- Test VGA Mode Select
        switches(1) <= '1';
        wait for 2 ms;
        switches(1) <= '0';
        wait;
   end process;

END;