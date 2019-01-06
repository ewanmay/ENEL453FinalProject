library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_vga_stripes_dff2 is
end tb_vga_stripes_dff2;

architecture behaviour of tb_vga_stripes_dff2 is

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_stripes_dff
     Port ( 
            pixel_clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            next_pixel : in  STD_LOGIC;
            mode: in STD_LOGIC;
            B : out  STD_LOGIC_VECTOR (3 downto 0);
            G : out  STD_LOGIC_VECTOR (3 downto 0);
            R : out  STD_LOGIC_VECTOR (3 downto 0)
           );
    END COMPONENT; 
 
    COMPONENT vga_stripes_dff2
     Port ( 
            pixel_clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            next_pixel : in  STD_LOGIC;
            mode: in STD_LOGIC;
            B : out  STD_LOGIC_VECTOR (3 downto 0);
            G : out  STD_LOGIC_VECTOR (3 downto 0);
            R : out  STD_LOGIC_VECTOR (3 downto 0)
           );
    END COMPONENT;
    
    --Inputs
    signal pixel_clk : std_logic;
    signal reset : std_logic;
    signal next_pixel : std_logic := '1'; 
    signal mode : std_logic;

	--Outputs
    signal B,B2 : STD_LOGIC_VECTOR (3 downto 0);
    signal G,G2 : STD_LOGIC_VECTOR (3 downto 0);
    signal R,R2 : STD_LOGIC_VECTOR (3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut1: vga_stripes_dff PORT MAP (
          pixel_clk => pixel_clk,
          reset => reset,
          next_pixel => next_pixel,
          mode => mode,
          B => B,
          G => G,
          R => R
        );

	-- Instantiate the Unit Under Test (UUT)
   uut2: vga_stripes_dff2 PORT MAP (
          pixel_clk => pixel_clk,
          reset => reset,
          next_pixel => next_pixel,
          mode => mode,
          B => B2,
          G => G2,
          R => R2
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

  -- Mode process
  ModeProcess: process
  begin        
     -- Let the state machine cycle fully in each mode
       mode <= '0';
     wait for clk_period * 640;    
       mode <= '1';
     wait for clk_period * 640;
     next_pixel <= '0';
     wait for clk_period * 200;
     next_pixel <= '1';
  end process;
END;