library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity text_unit is
    Port ( 
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
end text_unit;

architecture Behavioral of text_unit is
signal pixel_output: STD_LOGIC_VECTOR(11 downto 0);
signal inUse_output: STD_LOGIC := '0';
begin

build_character: process(number,
    start_point_x,
    start_point_y, 
    letter_enable, 
    width,
    scan_line_x,
    scan_line_y,
    pixel_colour)
    variable decoded_bits : STD_LOGIC_VECTOR(14 downto 0);
begin


if(rising_edge(clk)) then
    if(letter_enable = '0') then 
        case number is                  -- 6543210 
             when "0000" => decoded_bits := "111111111111000"; -- 0  --      A-6
             when "0001" => decoded_bits := "110000111000111"; -- 1  --  F-1     B-5
             when "0010" => decoded_bits := "111110111110010"; -- 2  --      G-0
             when "0011" => decoded_bits := "111111111010010"; -- 3  --  E-2     C-4
             when "0100" => decoded_bits := "101111100011010"; -- 4  --      D-3      DP
             when "0101" => decoded_bits := "111011111011010"; -- 5  --      A-6
             when "0110" => decoded_bits := "111011111111010"; -- 6  --  F-1     B-5
             when "0111" => decoded_bits := "111111100000000"; -- 7  --      G-0
             when "1000" => decoded_bits := "111111111111010"; -- 8  --  E-2     C-4
             when "1001" => decoded_bits := "111111111011010"; -- 9  --      D-3      DP
             when "1010" => decoded_bits := "111110001111010"; -- P -- need hexadecimal display values for stopwatch
             when "1011" => decoded_bits := "100000111111000"; -- L -- need hexadecimal display values for stopwatch
             when "1100" => decoded_bits := "111111101111010"; -- A -- need hexadecimal display values for stopwatch
             when "1101" => decoded_bits := "101100010001011"; -- Y -- need hexadecimal display values for stopwatch
             when "1110" => decoded_bits := "111010111111010"; -- E -- need hexadecimal display values for stopwatch
             when "1111" => decoded_bits := "110101101111010"; -- R -- need hexadecimal display values for stopwatch
          end case;
    elsif(letter_enable='1') then
        case number is                  -- 6543210 
             when "0000" => decoded_bits := "000000000000000"; -- [Space]  --      A-6
             when "0001" => decoded_bits := "111011111011010"; -- S  --  F-1     B-5
             when "0010" => decoded_bits := "010111010111000"; -- O  --      G-0
             when "0011" => decoded_bits := "101111111111000"; -- U --  E-2     C-4
             when "0100" => decoded_bits := "111111101111000"; -- N  --      D-3      DP
             when "0101" => decoded_bits := "110111011111000"; -- D  --      A-6
             when "0110" => decoded_bits := "111000111000111"; -- I  --  F-1     B-5
             when "0111" => decoded_bits := "111011111111000"; -- G  --      G-0
             when "1000" => decoded_bits := "111000010000111"; -- T  --  E-2     C-4
             when "1001" => decoded_bits := "111000111111000"; -- C  --      D-3      DP
             when "1010" => decoded_bits := "111101111111010"; -- B  -- need hexadecimal display values for stopwatch
             when "1011" => decoded_bits := "000000000000101"; -- :  -- need hexadecimal display values for stopwatch
             when "1100" => decoded_bits := "010000010000110"; -- !  -- need hexadecimal display values for stopwatch
             when "1101" => decoded_bits := "000000010000000"; -- .  -- need hexadecimal display values for stopwatch
             when "1110" => decoded_bits := "101111010111000"; -- V  -- need hexadecimal display values for stopwatch
             when "1111" => decoded_bits := "110101101111010"; -- R  -- need hexadecimal display values for stopwatch
          end case;    
    end if;
end if;
    if(scan_line_x >=  start_point_x and scan_line_y > start_point_y) then    
        if(scan_line_x <= start_point_x + width) then        
            if(scan_line_y <= start_point_y + width
                and decoded_bits(14) = '1') then        
                pixel_output <= pixel_colour;
                inUse_output <= '1';
            elsif(scan_line_y <= start_point_y + width + width
                and scan_line_y >= start_point_y + width
                and decoded_bits(3) = '1')    then
                pixel_output <= pixel_colour;
                inUse_output <= '1';
            elsif(scan_line_y <= start_point_y + width + width + width
                and scan_line_y >= start_point_y + width + width
                and decoded_bits(4) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';
            elsif(scan_line_y <= start_point_y + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width
                and decoded_bits(5) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';
            elsif(scan_line_y <=  start_point_y + width + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width + width
                and decoded_bits(6) = '1') then        
                pixel_output <= pixel_colour;     
                inUse_output <= '1';
            else
                inUse_output <= '0'; 
            end if;
        elsif(scan_line_x <= start_point_x + width + width
               and scan_line_x >= start_point_x + width) then
        
            if(scan_line_y <= start_point_y + width
                and decoded_bits(13) = '1') then        
                pixel_output <= pixel_colour;
                inUse_output <= '1';    
            elsif(scan_line_y <= start_point_y + width + width
                and scan_line_y >= start_point_y + width
                and decoded_bits(2) = '1')    then
                pixel_output <= pixel_colour;
                inUse_output <= '1';        
            elsif(scan_line_y <= start_point_y + width + width + width
                and scan_line_y >= start_point_y + width + width
                and decoded_bits(1) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';        
            elsif(scan_line_y <= start_point_y + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width
                and decoded_bits(0) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';        
            elsif(scan_line_y <=  start_point_y + width + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width + width
                and decoded_bits(7) = '1') then        
                pixel_output <= pixel_colour;
                inUse_output <= '1';
            else
                inUse_output <= '0';  
            end if; 
       elsif(scan_line_x <= start_point_x + width + width + width
             and scan_line_x >= start_point_x + width + width) then
                        
            if(scan_line_y <= start_point_y + width
                and decoded_bits(12) = '1') then        
                pixel_output <= pixel_colour;
                inUse_output <= '1';
           elsif(scan_line_y <= start_point_y + width + width
                and scan_line_y >= start_point_y + width
                and decoded_bits(11) = '1')    then
                pixel_output <= pixel_colour;
                inUse_output <= '1';       
           elsif(scan_line_y <= start_point_y + width + width + width
                and scan_line_y >= start_point_y + width + width
                and decoded_bits(10) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';       
           elsif(scan_line_y <= start_point_y + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width
                and decoded_bits(09) = '1') then
                pixel_output <= pixel_colour;
                inUse_output <= '1';       
           elsif(scan_line_y <=  start_point_y + width + width + width + width + width
                and scan_line_y >= start_point_y + width + width + width + width
                and decoded_bits(08) = '1') then        
                pixel_output <= pixel_colour;
                inUse_output <= '1';
           else 
                inUse_output <= '0';                    
           end if;
        else
            inUse_output <= '0';   
        end if;
    else
        inUse_output <= '0';   
    end if;
    
end process;

pixel_out <= pixel_output;
inUse <= inUse_output;
end Behavioral;
