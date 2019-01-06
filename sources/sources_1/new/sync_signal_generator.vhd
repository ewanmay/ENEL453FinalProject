
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sync_signals_generator is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
          );
end sync_signals_generator;

architecture Behavioral of sync_signals_generator is
	
-- VGA Sync definitions (DON'T CHANGE THESE)
-- Horizontal definitions (measured in # of clock cycles)
constant h_disp_time: integer:= 640; -- horizontal display area (640)
constant h_sync_pulse: integer:= 800; -- maximum horizontal amount (limit)(800)
constant h_front_porch: integer:= 16; -- h. front porch
constant h_back_porch: integer:= 48;	-- h. back porch
constant h_pulse_width: integer:= 96;	-- h. pulse width
-- Vertical definitions (measured in # of horiz lines)
constant v_disp_time: integer:= 480; -- vertical display area
constant v_sync_pulse: integer:= 521; -- maximum vertical amount (limit) 521
constant v_front_porch: integer:= 10;	-- v. front porch 10
constant v_back_porch: integer:= 29;	-- v. back porch 29
constant v_pulse_width: integer:= 2;	-- v. pulse width 2  	
	
signal current_hor_pos: std_logic_vector(10 downto 0) := (others => '0');
signal current_ver_pos: std_logic_vector(10 downto 0) := (others => '0');
signal hor_blank, ver_blank, i_blank: std_logic;

begin
	PixelPosition: process(pixel_clk, reset)
	begin
	    if (reset = '1') then
            -- Reset all outputs
            current_hor_pos <= (others => '0');
            current_ver_pos <= (others => '0');	    
		elsif (rising_edge(pixel_clk)) then
            if current_hor_pos < h_sync_pulse-1 then
                current_hor_pos <= current_hor_pos + 1;
            else
                if current_ver_pos < v_sync_pulse-1 then
                    current_ver_pos <= current_ver_pos + 1;
                else
                   -- Resets Vertical position (reached bottom of screen)
                    current_ver_pos <= (others => '0');		
                end if;
                -- Resets Horizontal position (reached right side of screen)
                current_hor_pos <= (others => '0');			
            end if;	
		end if;
	end process PixelPosition;

-- Complete the description with relevant VERTICAL signals (ver_sync, ver_blank and scan_line_y)
hor_sync <= '0' when current_hor_pos < h_pulse_width else '1';

hor_blank <= '0' when (current_hor_pos >= h_pulse_width + h_back_porch) and 
                      (current_hor_pos < h_pulse_width + h_back_porch + h_disp_time) else '1';

scan_line_x <= (current_hor_pos - h_pulse_width - h_back_porch) when i_blank = '0' else (others => '0');

-- ADDED:
ver_sync <= '0' when current_ver_pos < v_pulse_width else '1';
ver_blank <= '0' when (current_ver_pos >= v_pulse_width + v_back_porch) and 
                      (current_ver_pos < v_pulse_width + v_back_porch + v_disp_time) else '1';
scan_line_y <= (current_ver_pos - v_pulse_width - v_back_porch) when i_blank = '0' else (others => '0');

i_blank	<= '1' when hor_blank = '1' or ver_blank = '1' else '0';
blank <= i_blank;
end Behavioral;

