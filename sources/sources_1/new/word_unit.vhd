
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity word_unit is
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
end word_unit;

architecture behavioral of word_unit is

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
type inUses is array (natural range <>) of STD_LOGIC;
signal inUses_i : inUses(number -1 downto 0);
type start_points is array (natural range <>) of STD_LOGIC_VECTOR(10 downto 0);
signal start_points_i : start_points(number -1 downto 0);
type pixel_outs is array (natural range <>) of STD_LOGIC_VECTOR(11 downto 0);
signal pixel_outs_i : pixel_outs( number - 1 downto 0);
signal pixel_out_i : STD_LOGIC_VECTOR(11 downto 0); 
begin
    GEN_TEXT:
    for I in 0 to number - 1 generate
    start_points_i(I) <=  start_point_x + std_logic_vector(to_unsigned((I * 4 * to_integer(unsigned(width))), 11));
    REGX: text_unit 
        Port Map (
               clk            => clk,
               number         => input_numbers((number - I)*4 - 1 downto (number - (I+1) )*4),
               width          => width,
               start_point_x  => start_points_i(I),
               start_point_y  => start_point_y,
               scan_line_x    => scan_line_x,
               scan_line_y    => scan_line_y,           
               pixel_colour   => pixel_colour ,
               letter_enable  => letter_enable(number - I - 1),
               pixel_out      => pixel_outs_i(I),
               inUse          => inUses_i(I)
    );
    end generate GEN_TEXT;
    
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
       for I in 0 to number - 1 loop
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
