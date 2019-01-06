library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_downcounter is
	Generic ( 	period: integer:= 4;				
					WIDTH: integer:= 3);
		Port ( clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  enable : in  STD_LOGIC;
				  zero : out  STD_LOGIC;
				  value: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end vga_downcounter;

architecture Behavioral of vga_downcounter is
	signal 	current_count: std_logic_vector(WIDTH-1 downto 0);
	signal 	i_zero: 			std_logic;	
	
	-- Convert the max counter to a logic vector (this is done during synthesis) 
	constant max_count: 		std_logic_vector(WIDTH-1 downto 0) := 
									std_logic_vector(to_unsigned(period, WIDTH));
	-- Create a logic vector of proper length filled with zeros (also done during synthesis)
	constant zeros: 			std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	
begin

count: process(clk,reset) begin
	if (reset = '1') then					-- Asynchronous reset
        current_count 	<= max_count;
        i_zero 			<= '0';
	elsif (rising_edge(clk)) then 
        if (enable = '1') then				-- When counter is enabled
            if (current_count = zeros) then
                current_count 	<= max_count;
                i_zero 			<= '1';
            else 
                current_count 	<= current_count - '1';
                i_zero 			<= '0';
            end if;
		else 
			i_zero <= '0';
		end if;
	end if;
end process;

-- Connect internal signals to output
value <= current_count;	
zero <= i_zero;		-- Connect internal signals to output

end Behavioral;