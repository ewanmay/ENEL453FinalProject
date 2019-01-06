library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_module is
    Port (  
        clk             : in  STD_LOGIC;
        red             : out STD_LOGIC_VECTOR(3 downto 0);
        green           : out STD_LOGIC_VECTOR(3 downto 0);
        blue            : out STD_LOGIC_VECTOR(3 downto 0);
        hsync           : out STD_LOGIC;
        vsync           : out STD_LOGIC;            
        seconds_in      : in STD_LOGIC_VECTOR(3 downto 0);
        hundredths_in   : in STD_LOGIC_VECTOR(3 downto 0);
        tenths_in       : in STD_LOGIC_VECTOR(3 downto 0);
        thousandths_in  : in STD_LOGIC_VECTOR(3 downto 0);
        rounds_array_in : in STD_LOGIC_VECTOR(159 downto 0);
        round_winners_in: in STD_LOGIC_VECTOR(9 downto 0);      
        score_p2_dig1_in: in STD_LOGIC_VECTOR(3 downto 0); 
        score_p2_dig2_in: in STD_LOGIC_VECTOR(3 downto 0);            
        score_p1_dig1_in: in STD_LOGIC_VECTOR(3 downto 0); 
        score_p1_dig2_in: in STD_LOGIC_VECTOR(3 downto 0);        
        playing_to_dig1: in STD_LOGIC_VECTOR(3 downto 0);
        playing_to_dig2: in STD_LOGIC_VECTOR(3 downto 0);
        countdown_num : in STD_LOGIC_VECTOR(3 downto 0);
      --ENABLE
        timer_on           : in STD_LOGIC;
        countdown_enable   : in STD_LOGIC;
        round_start_signal : in STD_LOGIC;
        flash_p2           : in STD_LOGIC;
        flash_p1           : in STD_LOGIC;        
        player_1_win: in STD_LOGIC;
        player_2_win: in STD_LOGIC
      );
end vga_module;

architecture Behavioral of vga_module is
-- Components:
component sync_signals_generator is
    Port ( pixel_clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           hor_sync: out STD_LOGIC;
           ver_sync: out STD_LOGIC;
           blank: out STD_LOGIC;
           scan_line_x: out STD_LOGIC_VECTOR(10 downto 0);
           scan_line_y: out STD_LOGIC_VECTOR(10 downto 0)
		  );
end component;


-- ADDED
component clock_divider is
Port (  clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        enable: in STD_LOGIC;
        kHz: out STD_LOGIC;	  
        twentyfive_MHz: out STD_LOGIC;
        hHz: out STD_LOGIC
	  );
end component;

 component monitor_display is
 Port ( 	
      
             clk : in  STD_LOGIC;
             reset : in  STD_LOGIC;
             scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
             scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
             red: out STD_LOGIC_VECTOR(3 downto 0);
             blue: out STD_LOGIC_VECTOR(3 downto 0);
             green: out std_logic_vector(3 downto 0);
             
             --ENABLE
             timer_on           : in STD_LOGIC;
             countdown_enable   : in STD_LOGIC;
             round_start_signal : in STD_LOGIC;
             flash_p2           : in STD_LOGIC;
             flash_p1           : in STD_LOGIC;      
             player_1_win: in STD_LOGIC;
             player_2_win: in STD_LOGIC;
             
             --INPUT_NUMBERS
             score_p1_dig1_in  : in STD_LOGIC_VECTOR(3 downto 0); 
             score_p1_dig2_in  : in STD_LOGIC_VECTOR(3 downto 0);
             score_p2_dig1_in  : in STD_LOGIC_VECTOR(3 downto 0); 
             score_p2_dig2_in  : in STD_LOGIC_VECTOR(3 downto 0);
             
             seconds_in: in STD_LOGIC_VECTOR(3 downto 0);
             hundredths_in: in STD_LOGIC_VECTOR(3 downto 0);
             tenths_in: in STD_LOGIC_VECTOR(3 downto 0);
             thousandths_in: in STD_LOGIC_VECTOR(3 downto 0);
                         
             countdown_num : in STD_LOGIC_VECTOR(3 downto 0);
             playing_to_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
             playing_to_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
             rounds_array_in: in STD_LOGIC_VECTOR(159 downto 0);
             round_winners_in: in STD_LOGIC_VECTOR(9 downto 0) 
           );
end component;
-- END ADDED

-- Signals:
signal reset: std_logic;
signal vga_select: std_logic;

signal disp_blue: std_logic_vector(3 downto 0);
signal disp_red: std_logic_vector(3 downto 0);
signal disp_green: std_logic_vector(3 downto 0);

-- Stripe block signals:
signal show_stripe: std_logic;

-- Clock divider signals:
signal i_kHz, i_hHz, i_pixel_clk: std_logic;

-- Sync module signals:
signal vga_blank : std_logic;
signal scan_line_x, scan_line_y: STD_LOGIC_VECTOR(10 downto 0);

-- Box size signals:
signal inc_box, dec_box: std_logic;
signal box_size: std_logic_vector(8 downto 0);

-- Bouncing box signals:
signal box_color: std_logic_vector(11 downto 0);
signal box_red: std_logic_vector(3 downto 0);
signal box_green: std_logic_vector(3 downto 0);
signal box_blue: std_logic_vector(3 downto 0);

-- ADDED
signal stripe_red: std_logic_vector(3 downto 0);
signal stripe_green: std_logic_vector(3 downto 0);
signal stripe_blue: std_logic_vector(3 downto 0);

begin

VGA_SYNC: sync_signals_generator
    Port map( 	pixel_clk   => i_pixel_clk,
                reset       => reset,
                hor_sync    => hsync,
                ver_sync    => vsync,
                blank       => vga_blank,
                scan_line_x => scan_line_x,
                scan_line_y => scan_line_y
			  );


-- ADDED	
DIVIDER: clock_divider
    Port map (  clk              => clk,
                reset            => reset,
                kHz              => i_kHz,
                twentyfive_MHz   => i_pixel_clk,
                enable           => '1',
                hHz              => i_hHz
		  );
		  
             
MON_DISP: monitor_display
    Port map ( 
               clk                  =>  i_pixel_clk,
               reset                =>  reset,
               scan_line_x          =>  scan_line_x,
               scan_line_y          =>  scan_line_y,
               red                  =>  box_red,
               blue                 =>  box_blue,
               green                =>  box_green,
               
               --SCOREBOARD
               score_p1_dig1_in     => score_p1_dig1_in,
               score_p1_dig2_in     => score_p1_dig2_in,
               score_p2_dig1_in     => score_p2_dig1_in,
               score_p2_dig2_in     => score_p2_dig2_in,
               --CENTRAL NUMBER
               seconds_in           => seconds_in,
               hundredths_in        => hundredths_in,
               tenths_in            => tenths_in,
               thousandths_in       => thousandths_in,               
               round_start_signal   => round_start_signal,
               --COUNTDOWN
               countdown_num        => countdown_num,
               countdown_enable     => countdown_enable,
               --PLAYING_TO               
               playing_to_dig1      => playing_to_dig1,
               playing_to_dig2      => playing_to_dig2,
               rounds_array_in      => rounds_array_in,
               round_winners_in     => round_winners_in,
               timer_on             => timer_on,
               flash_p2             => flash_p2,
               flash_p1             => flash_p1,          
               --WINNER DISPLAY
               player_1_win         => player_1_win,
               player_2_win         => player_2_win
           );
-- END ADDED

show_stripe <= not vga_blank;

-- BLANKING:
-- Follow this syntax to assign other colors when they are not being blanked
red <= "0000" when (vga_blank = '1') else disp_red;
-- ADDED:
blue  <= "0000" when (vga_blank = '1') else disp_blue;
green <= "0000" when (vga_blank = '1') else disp_green;

-- Connect input buttons and switches:
-- ADDED
-- These can be assigned to different switches/buttons

-----------------------------------------------------------------------------
-- OUTPUT SELECTOR:
-- Select which component to display - stripes or bouncing box
selectOutput: process(box_red, box_blue, box_green, stripe_blue, stripe_red, stripe_green)
begin
	case (vga_select) is
		-- Select which input gets written to disp_red, disp_blue and disp_green
		-- ADDED
		when '0' => disp_red <= box_red; disp_blue <= box_blue; disp_green <= box_green;
		when '1' => disp_red <= stripe_red; disp_blue <= stripe_blue; disp_green <= stripe_green;
		when others => disp_red <= "0000"; disp_blue <= "0000"; disp_green <= "0000";
	end case;
end process selectOutput;
-----------------------------------------------------------------------------

end Behavioral;

