library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round_result is
      Port (
           clk: in STD_LOGIC;
           round: in STD_LOGIC_VECTOR(3 downto 0);
           sec: in STD_LOGIC_VECTOR(3 downto 0);
           ten: in STD_LOGIC_VECTOR(3 downto 0);
           hun: in STD_LOGIC_VECTOR(3 downto 0);
           mil: in STD_LOGIC_VECTOR(3 downto 0);
           width : in STD_LOGIC_VECTOR (7 downto 0);
           start_point_x : in STD_LOGIC_VECTOR (10 downto 0);
           start_point_y : in STD_LOGIC_VECTOR (10 downto 0);           
           scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);           
           pixel_colour: in STD_LOGIC_VECTOR(11 downto 0);
           word_pixel_out: out STD_LOGIC_VECTOR(11 downto 0);
           inUse: out STD_LOGIC:= '0' 
           );
end round_result;

architecture Behavioral of round_result is

component word_unit is
Generic ( 	number: integer:= 4
		);
    Port ( 
           clk: in STD_LOGIC;
           input_numbers : in STD_LOGIC_VECTOR (number*4 - 1 downto 0);
           width : in STD_LOGIC_VECTOR (7 downto 0);
           start_point_x : in STD_LOGIC_VECTOR (10 downto 0);
           start_point_y : in STD_LOGIC_VECTOR (10 downto 0);           
           scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);           
           pixel_colour: in STD_LOGIC_VECTOR(11 downto 0);
           letter_enable : in STD_LOGIC_VECTOR(number - 1 downto 0);
           word_pixel_out: out STD_LOGIC_VECTOR(11 downto 0);
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

component decimal_num is
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
           inUse: out STD_LOGIC:= '0'
           );
end component;

type pixel_outs is array (natural range <>) of STD_LOGIC_VECTOR(11 downto 0);
signal pixel_outs_i : pixel_outs( 3 downto 0);

type in_use_i is array (natural range <>) of STD_LOGIC;
signal in_use : in_use_i( 3 downto 0);
signal title: STD_LOGIC_VECTOR (27 downto 0) := "111100100011010001010000" & round;
signal end_point_xi : STD_LOGIC_VECTOR (10 downto 0):= start_point_x + std_logic_vector(to_unsigned((27  * to_integer(unsigned(width))), 10));
signal start_point_yi : STD_LOGIC_VECTOR (10 downto 0):= start_point_y + std_logic_vector(to_unsigned((6  * to_integer(unsigned(width))), 10));
signal end_point_yi : STD_LOGIC_VECTOR (10 downto 0):= start_point_y +  std_logic_vector(to_unsigned((7  * to_integer(unsigned(width))), 10));
signal start_point_xnum : STD_LOGIC_VECTOR (10 downto 0):= start_point_x + std_logic_vector(to_unsigned((5  * to_integer(unsigned(width))), 10)); 
signal start_point_ynum : STD_LOGIC_VECTOR (10 downto 0):= start_point_y + std_logic_vector(to_unsigned((9  * to_integer(unsigned(width))), 10));
signal numarray: STD_LOGIC_VECTOR (15 downto 0):= sec & ten & hun & mil;
signal pixel_out_i : std_logic_vector(11 downto 0);

begin

ROUND_NUM: word_unit  
GENERIC MAP(
    number => 7
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => title,
           width         => width,
           start_point_x => start_point_x,
           start_point_y => start_point_y,
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => pixel_colour,
           letter_enable => "0111110" ,
           inUse         => in_use(0) ,
           word_pixel_out=> pixel_outs_i(0)  
);

RECT_UNDERLINE: rectangle
PORT MAP(
        clk             => clk,
        start_point_x   => start_point_x,
        start_point_y   => start_point_yi,
        end_point_x     => end_point_xi,
        end_point_y     => end_point_yi,
        scan_line_x     => scan_line_x,
        scan_line_y     => scan_line_y,
        pixel_colour    => pixel_colour,
        word_pixel_out  => pixel_outs_i(1)  ,
        inUse           => in_use(1)           
);


CENTER_NUMBER: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => numarray,
           width         => width,
           start_point_x => start_point_xnum,
           start_point_y => start_point_ynum,
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => pixel_colour,
           letter_enable => "0000" ,
           inUse         => in_use(2) ,
           word_pixel_out=> pixel_outs_i(2)  
);

output: process(clk, scan_line_x, scan_line_y)
       variable inUse_Var : std_logic := '0';
    begin
    inUse_Var := '0';
    for I in 0 to 3 loop
        if(in_use(I) = '1') then
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
end Behavioral;
