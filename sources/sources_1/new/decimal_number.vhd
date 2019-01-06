
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity decimal_num is
Generic ( 	number: integer:= 4;
            decimal_place: integer:= 3
		);
    Port ( 
           clk: in STD_LOGIC;
           input_numbers : in STD_LOGIC_VECTOR (15 downto 0);
           width : in STD_LOGIC_VECTOR (7 downto 0);
           start_point_x : in STD_LOGIC_VECTOR (10 downto 0);
           start_point_y : in STD_LOGIC_VECTOR (10 downto 0);           
           scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);           
           pixel_colour: in STD_LOGIC_VECTOR(11 downto 0);
           letter_enable : in STD_LOGIC_VECTOR(3 downto 0);
           word_pixel_out: out STD_LOGIC_VECTOR(11 downto 0);
           inUse: out STD_LOGIC
           );
end decimal_num;

architecture behavioral of decimal_num is

component text_unit is 
PORT (
           clk: in STD_LOGIC;
           number : in STD_LOGIC_VECTOR (3 downto 0);
           width : in STD_LOGIC_VECTOR (7 downto 0);
           start_point_x : in STD_LOGIC_VECTOR (10 downto 0);
           start_point_y : in STD_LOGIC_VECTOR (10 downto 0);           
           scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);           
           pixel_colour: in STD_LOGIC_VECTOR(11 downto 0);
           letter_enable : in STD_LOGIC;
           pixel_out: out STD_LOGIC_VECTOR(11 downto 0);
           inUse: out STD_LOGIC:= '0'
     );
end component;
     
component rectangle is 
 PORT ( 
    clk              : in STD_LOGIC;
    start_point_x    : in STD_LOGIC_VECTOR (10 downto 0);
    start_point_y    : in STD_LOGIC_VECTOR (10 downto 0);   
    end_point_x      : in STD_LOGIC_VECTOR (10 downto 0);
    end_point_y      : in STD_LOGIC_VECTOR (10 downto 0);          
    scan_line_x      : in STD_LOGIC_VECTOR(10 downto 0);
    scan_line_y      : in STD_LOGIC_VECTOR(10 downto 0);           
    pixel_colour     : in STD_LOGIC_VECTOR(11 downto 0);
    word_pixel_out   : out STD_LOGIC_VECTOR(11 downto 0);
    inUse            : out STD_LOGIC:= '0'
    );
 end component;
 
 
type inUses is array (natural range <>) of STD_LOGIC;
signal inUses_i : inUses(4 downto 0);
type pixel_outs is array (natural range <>) of STD_LOGIC_VECTOR(11 downto 0);
signal pixel_outs_i : pixel_outs( 4 downto 0);
type start_points is array (natural range <>) of STD_LOGIC_VECTOR(10 downto 0);
signal start_points_i : start_points(number downto 0);
signal pixel_out_i : STD_LOGIC_VECTOR(11 downto 0); 
signal end_point_xi : STD_LOGIC_VECTOR (10 downto 0);
signal end_point_yi : STD_LOGIC_VECTOR (10 downto 0);
signal start_point_yi : STD_LOGIC_VECTOR (10 downto 0);

begin

GEN_STARTS: process begin
    if(rising_edge(clk)) then 
    start_points_i(0) <=  start_point_x;
    start_points_i(1) <=  start_point_x + std_logic_vector(to_unsigned((4  * to_integer(unsigned(width))), 10));
    end_point_xi      <=  start_point_x + std_logic_vector(to_unsigned((5  * to_integer(unsigned(width))), 10));
    start_point_yi    <=  start_point_y  + std_logic_vector(to_unsigned((4  * to_integer(unsigned(width))), 10));    
    end_point_yi      <=  start_point_y  + std_logic_vector(to_unsigned((5  * to_integer(unsigned(width))), 10));
    start_points_i(2) <=  start_point_x + std_logic_vector(to_unsigned((6  * to_integer(unsigned(width))), 10));
    start_points_i(3) <=  start_point_x + std_logic_vector(to_unsigned((10 * to_integer(unsigned(width))), 10));
    start_points_i(4) <=  start_point_x + std_logic_vector(to_unsigned((14 * to_integer(unsigned(width))), 10));
    end if;
 end process;
 

SEC:text_unit 
Port Map (
    clk            => clk,
    number         => input_numbers(15 downto 12),
    width          => width,
    start_point_x  => start_points_i(0),
    start_point_y  => start_point_y,
    scan_line_x    => scan_line_x,
    scan_line_y    => scan_line_y,           
    pixel_colour   => pixel_colour ,
    letter_enable  => letter_enable(3),
    pixel_out      => pixel_outs_i(0),
    inUse          => inUses_i(0)
);
TENTHS:text_unit 
Port Map (
    clk            => clk,
    number         => input_numbers(11 downto 8),
    width          => width,
    start_point_x  => start_points_i(2),
    start_point_y  => start_point_y,
    scan_line_x    => scan_line_x,
    scan_line_y    => scan_line_y,           
    pixel_colour   => pixel_colour ,
    letter_enable  => letter_enable(2),
    pixel_out      => pixel_outs_i(1),
    inUse          => inUses_i(1)
);
HUNDREDTHS:text_unit 
Port Map (
    clk            => clk,
    number         => input_numbers(7 downto 4),
    width          => width,
    start_point_x  => start_points_i(3),
    start_point_y  => start_point_y,
    scan_line_x    => scan_line_x,
    scan_line_y    => scan_line_y,           
    pixel_colour   => pixel_colour ,
    letter_enable  => letter_enable(1),
    pixel_out      => pixel_outs_i(2),
    inUse          => inUses_i(2)
);
THOUSANDTHS:text_unit 
Port Map (
    clk            => clk,
    number         => input_numbers(3 downto 0),
    width          => width,
    start_point_x  => start_points_i(4),
    start_point_y  => start_point_y,
    scan_line_x    => scan_line_x,
    scan_line_y    => scan_line_y,           
    pixel_colour   => pixel_colour ,
    letter_enable  => letter_enable(0),
    pixel_out      => pixel_outs_i(4),
    inUse          => inUses_i(4)
);

DECIMAL: rectangle
PORT MAP(
    clk             => clk,
    start_point_x   => start_points_i(1),
    start_point_y   => start_point_yi,
    end_point_x     => end_point_xi,
    end_point_y     => end_point_yi,
    scan_line_x     => scan_line_x,
    scan_line_y     => scan_line_y,
    pixel_colour    => pixel_colour,
    word_pixel_out  => pixel_outs_i(3),
    inUse           => inUses_i(3)           
);
    
    
output : process (
    input_numbers,
    start_point_x,
    start_point_y, 
    letter_enable, 
    width,
    scan_line_x,
    scan_line_y,
    pixel_colour)
    variable inUse_Var : std_logic := '0';
begin
   inUse_Var := '0';
   for I in 0 to number loop
        if(inUses_i(I) = '1') then
            pixel_out_i <= pixel_outs_i(I);
            inUse_Var := '1';
            inUse <= '1';
        elsif(inUse_Var = '0') then
            pixel_out_i <= "111111111111";               
            inUse <= '0';              
        end if;
   
   end loop;
end process;

word_pixel_out <= pixel_out_i;
end behavioral;
