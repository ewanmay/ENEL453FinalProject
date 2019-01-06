library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity rectangle is
PORT ( 
   clk: in STD_LOGIC;
   start_point_x : in STD_LOGIC_VECTOR (10 downto 0);
   start_point_y : in STD_LOGIC_VECTOR (10 downto 0);   
   end_point_x : in STD_LOGIC_VECTOR (10 downto 0);
   end_point_y : in STD_LOGIC_VECTOR (10 downto 0);          
   scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
   scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);           
   pixel_colour: in STD_LOGIC_VECTOR(11 downto 0);
   word_pixel_out: out STD_LOGIC_VECTOR(11 downto 0);
   inUse: out STD_LOGIC
   );
end rectangle;

architecture Behavioral of rectangle is
signal inUse_i: STD_LOGIC;
begin

output: process(scan_line_x, clk, scan_line_y) 
begin
        if((scan_line_x >=  start_point_x and scan_line_x < end_point_x)    and  (scan_line_y >= start_point_y and scan_line_y <= end_point_y)
           ) then
           inUse_i <= '1';           
           word_pixel_out <= pixel_colour;
        else
           inUse_i <= '0';           
           word_pixel_out <= "111111111111";
    end if;
end process;

inUse <= inUse_i;
end Behavioral;
