library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity monitor_display is
     Port ( 	
     
            clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			green: out std_logic_vector(3 downto 0);
            
            --ENABLE
            timer_on: in STD_LOGIC;
            countdown_enable: in STD_LOGIC;
            round_start_signal: in STD_LOGIC;
            flash_p2: in STD_LOGIC;
            flash_p1: in STD_LOGIC;
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
                        
            playing_to_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
            playing_to_dig2 : in STD_LOGIC_VECTOR(3 downto 0); 
                       
            countdown_num: in STD_LOGIC_VECTOR(3 downto 0);
            rounds_array_in: in STD_LOGIC_VECTOR(159 downto 0);
            round_winners_in: in STD_LOGIC_VECTOR(9 downto 0) 
		  );
end monitor_display;

architecture Behavioral of monitor_display is

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

component round_result is
      Port (
        clk              : in STD_LOGIC;
        round            : in STD_LOGIC_VECTOR(3 downto 0);
        sec              :  in STD_LOGIC_VECTOR(3 downto 0);
        ten              : in STD_LOGIC_VECTOR(3 downto 0);
        hun              : in STD_LOGIC_VECTOR(3 downto 0);
        mil              : in STD_LOGIC_VECTOR(3 downto 0);
        width            : in STD_LOGIC_VECTOR (7 downto 0);
        start_point_x    : in STD_LOGIC_VECTOR (10 downto 0);
        start_point_y    : in STD_LOGIC_VECTOR (10 downto 0);           
        scan_line_x      : in STD_LOGIC_VECTOR(10 downto 0);
        scan_line_y      : in STD_LOGIC_VECTOR(10 downto 0);           
        pixel_colour     : in STD_LOGIC_VECTOR(11 downto 0);
        word_pixel_out   : out STD_LOGIC_VECTOR(11 downto 0);
        inUse            : out STD_LOGIC:= '0' 
           );
end component;

signal redraw: std_logic_vector(5 downto 0):=(others=>'0');
constant box_loc_x_min: std_logic_vector(10 downto 0) := "00000000000";
constant box_loc_y_min: std_logic_vector(10 downto 0) := "00000000000";
signal box_loc_x_max: std_logic_vector(10 downto 0); -- Not constants because these dependant on box_width 
signal box_loc_y_max: std_logic_vector(10 downto 0);
signal pixel_color: std_logic_vector(11 downto 0);
signal inUse_1, inUse_2, inUse_3: STD_LOGIC:= '0';
signal pixel_out_i : std_logic_vector(11 downto 0);
signal center_array_i: STD_LOGIC_VECTOR(15 downto 0);
signal score_i: STD_LOGIC_VECTOR(19 downto 0);
signal playing_to_i: STD_LOGIC_VECTOR(51 downto 0);

signal right_back_pix, center_back_pix, left_back_pix : std_logic_vector(11 downto 0);

signal r1,r2,r3,r4,r5,r6,r7,r8,r9,r10 : STD_LOGIC_VECTOR(10 downto 0);

constant components : Integer := 23; 
constant shift      : Integer := 15;
constant zeros      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
constant Player_1_X : STD_LOGIC_VECTOR(10 downto 0) := "00000010010";
constant Player_2_X : STD_LOGIC_VECTOR(10 downto 0) := "00111110010";

type pixel_outs is array (natural range <>) of STD_LOGIC_VECTOR(11 downto 0);
signal pixel_outs_i : pixel_outs( components downto 0);

type in_use_i is array (natural range <>) of STD_LOGIC;
signal in_use : in_use_i( components downto 0);


begin

LEFT_BACK: rectangle
PORT MAP(
        clk             => clk,
        start_point_x   => "00000000000",
        start_point_y   => "00000000000",
        end_point_x     => "00010100000",
        end_point_y     => "00111100001",
        scan_line_x     => scan_line_x,
        scan_line_y     => scan_line_y,
        pixel_colour    => left_back_pix,
        word_pixel_out  => pixel_outs_i(0)  ,
        inUse           => in_use(0)           
);
CENTER_BACK: rectangle
PORT MAP(
        clk             => clk,
        start_point_x   => "00010100000",
        start_point_y   => "00000000000",
        end_point_x     => "00111100000",
        end_point_y     => "00111100001",
        scan_line_x     => scan_line_x,
        scan_line_y     => scan_line_y,
        pixel_colour    => center_back_pix,
        word_pixel_out  => pixel_outs_i(1)  ,
        inUse           => in_use(1)           
);
RIGHT_BACK: rectangle
PORT MAP(
        clk             => clk,
        start_point_x   => "00111100000",
        start_point_y   => "00000000000",
        end_point_x     => "01111100000",
        end_point_y     => "00111100001",
        scan_line_x     => scan_line_x,
        scan_line_y     => scan_line_y,
        pixel_colour    => right_back_pix,
        word_pixel_out  => pixel_outs_i(2)  ,
        inUse           => in_use(2)           
);

PLAYER2: word_unit  
GENERIC MAP(
    number => 8
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => "10101011110011011110111100000010",
           width         => "00000100",
           start_point_x => "00111110010",
           start_point_y => "00000100000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "000000001111",
           letter_enable => "00000010" ,
           inUse         => in_use(3) ,
           word_pixel_out=> pixel_outs_i(3)  
);

PLAYER1: word_unit  
GENERIC MAP(
    number => 8
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => "10101011110011011110111100000001",
           width         => "00000100",
           start_point_x => "00000010010",
           start_point_y => "00000100000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111100000000",
           letter_enable => "00000010" ,
           inUse         => in_use(4) ,
           word_pixel_out=> pixel_outs_i(4)  
);

SCORE_WORD: word_unit  
GENERIC MAP(
    number => 5
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => "00011001001011111110",
           width         => "00000110",
           start_point_x => "00100000111",
           start_point_y => "00000100000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "11100" ,
           inUse         => in_use(5) ,
           word_pixel_out=> pixel_outs_i(5)  
);

COUNTDOWN_NUMBER: word_unit  
GENERIC MAP(
    number => 1
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => countdown_num,
           width         => "00000110",
           start_point_x => "00100110111",
           start_point_y => "00011100001",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0" ,
           inUse         => in_use(6) ,
           word_pixel_out=> pixel_outs_i(6)  
);


SCORE_NUM: word_unit  
GENERIC MAP(
    number => 5
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => score_i,
           width         => "00000100",
           start_point_x => "00100011010",
           start_point_y => "00001000100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "00100" ,
           inUse         => in_use(7) ,
           word_pixel_out=> pixel_outs_i(7)  
);

PLAYING_TO: word_unit  
GENERIC MAP(
    number => 13
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => playing_to_i,
           width         => "00000100",
           start_point_x => "00011101010",
           start_point_y => "00111001000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000111111100" ,
           inUse         => in_use(8) ,
           word_pixel_out=> pixel_outs_i(8)  
);

CENTER_NUMBER: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => center_array_i,
           width         => "00000110",
           start_point_x => "00100001101",
           start_point_y => "00011100001",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(9) ,
           word_pixel_out=> pixel_outs_i(9)  
);

Spacing: process (round_winners_in)
    begin
    
    if(round_winners_in(9)='1')then
        r1 <= "00111110010";
    else 
        r1 <= "00000010010"; 
    end if;
    
    if(round_winners_in(8)='1')then
        r2 <= "00111110010";
    else 
        r2 <= "00000010010"; 
    end if;
    
    if(round_winners_in(7)='1')then
        r3 <= "00111110010";
    else 
        r3 <= "00000010010"; 
    end if;
    
    if(round_winners_in(6)='1')then
        r4 <= "00111110010";
    else 
        r4 <= "00000010010"; 
    end if;
    
    if(round_winners_in(5)='1')then
        r5 <= "00111110010";
    else 
        r5 <= "00000010010"; 
    end if;
    
    if(round_winners_in(4)='1')then
        r6 <= "00111110010";
    else 
        r6 <= "00000010010"; 
    end if;
    
    if(round_winners_in(3)='1')then
        r7 <= "00111110010";
    else 
        r7 <= "00000010010"; 
    end if;
    
    if(round_winners_in(2)='1')then
        r8 <= "00111110010";
    else 
        r8 <= "00000010010"; 
    end if;
    
    if(round_winners_in(1)='1')then
        r9 <= "00111110010";
    else 
        r9 <= "00000010010"; 
    end if;
    
    if(round_winners_in(0)='1')then
        r10 <= "00111110010";
    else 
        r10 <= "00000010010"; 
    end if;
    
end process;

ROUND_1: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(159 downto 144),
           width         => "00000110",
           start_point_x => r1,
           start_point_y => "00001000100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(13) ,
           word_pixel_out=> pixel_outs_i(13)  
);

ROUND_2: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(143 downto 128),
           width         => "00000110",
           start_point_x => r2,
           start_point_y => "00001101000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(14) ,
           word_pixel_out=> pixel_outs_i(14)  
);

ROUND_3: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(127 downto 112),
           width         => "00000110",
           start_point_x => r3,
           start_point_y => "00010001100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(15) ,
           word_pixel_out=> pixel_outs_i(15)  
);

ROUND_4: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(111 downto 96),
           width         => "00000110",
           start_point_x => r4,
           start_point_y => "00010110000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(16) ,
           word_pixel_out=> pixel_outs_i(16)  
);

ROUND_5: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(95 downto 80),
           width         => "00000110",
           start_point_x => r5,
           start_point_y => "00011010100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(17) ,
           word_pixel_out=> pixel_outs_i(17)  
);

ROUND_6: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(79 downto 64),
           width         => "00000110",
           start_point_x => r6,
           start_point_y => "00011111000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(18) ,
           word_pixel_out=> pixel_outs_i(18)  
);


ROUND_7: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(63 downto 48),
           width         => "00000110",
           start_point_x => r7,
           start_point_y => "00100011100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(19) ,
           word_pixel_out=> pixel_outs_i(19)  
);

ROUND_8: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(47 downto 32),
           width         => "00000110",
           start_point_x => r8,
           start_point_y => "00101000000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(20) ,
           word_pixel_out=> pixel_outs_i(20)  
);

ROUND_9: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(31 downto 16),
           width         => "00000110",
           start_point_x => r9,
           start_point_y => "00101100100",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(21) ,
           word_pixel_out=> pixel_outs_i(21)  
);

ROUND_10: decimal_num
GENERIC MAP(
    number => 4,
    decimal_place => 3
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => rounds_array_in(15 downto 0),
           width         => "00000110",
           start_point_x => r10,
           start_point_y => "00110001000",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "111111111111",
           letter_enable => "0000" ,
           inUse         => in_use(22) ,
           word_pixel_out=> pixel_outs_i(22)  
);

--ROUND_1: round_result 
--    PORT MAP (
--        clk              => clk   ,
--        round            => "0010" ,
--        sec              => "0000",
--        ten              => "0010",
--        hun              => "0100",
--        mil              => "1000",
--        width            => "00000011" ,
--        start_point_x    => "00000101000",
--        start_point_y    => "00001000000",
--        scan_line_x      => scan_line_x  ,
--        scan_line_y      => scan_line_y  ,
--        pixel_colour     => "000000000000",
--        word_pixel_out   => pixel_outs_i(10)    ,
--        inUse            => in_use(10)          
--    );
    
PLAYER_1_VICTORY: word_unit  
GENERIC MAP(
   number => 16
)
PORT MAP ( 
        clk           => clk,           
        input_numbers => "1010101111001101111011110000000100001110011010011000001011111101",
        width         => "00001010",
        start_point_x => "00000000101",
        start_point_y => "00011010111",
        scan_line_x   => scan_line_x,
        scan_line_y   => scan_line_y,
        pixel_colour  => "111100000000",
        letter_enable => "0000001011111100" ,
        inUse         => in_use(11) ,
        word_pixel_out=> pixel_outs_i(11)  
);

PLAYER_2_VICTORY: word_unit  
GENERIC MAP(
    number => 16
)
PORT MAP ( 
           clk           => clk,           
           input_numbers => "1010101111001101111011110000001000001110011010011000001011111101",
           width         => "00001010",
           start_point_x => "00000000101",
           start_point_y => "00011010111",
           scan_line_x   => scan_line_x,
           scan_line_y   => scan_line_y,
           pixel_colour  => "000000001111",
           letter_enable => "0000001011111100" ,
           inUse         => in_use(12) ,
           word_pixel_out=> pixel_outs_i(12)  
);
variables: process(clk, scan_line_x, scan_line_y) begin
    center_array_i <= seconds_in & tenths_in & hundredths_in & thousandths_in;
    score_i <= score_p1_dig2_in  & score_p1_dig1_in & "1011" & score_p2_dig2_in & score_p2_dig1_in;
    playing_to_i <= "10101011110011010110010001110000100000101011" & playing_to_dig2 & playing_to_dig1;
end process;

background: process(clk, flash_p2, flash_p1, round_start_signal) begin
   if(rising_edge(clk)) then
        if(flash_p1 = '1') then
            left_back_pix <= "111110010000";
        else 
            left_back_pix <= "111101010111";
        end if;
        if(flash_p2 = '1') then            
            right_back_pix <= "010001001111";
        else 
            right_back_pix <= "011101011111";                
        end if;
        if(round_start_signal = '1') then            
            center_back_pix <= "000000000000";
        else 
            center_back_pix <= "011101110111";                                
        end if;
   end if; 
end process;
output: process(clk, scan_line_x, scan_line_y)
       variable inUse_Var : std_logic := '0';
    begin
    inUse_Var := '0';
    for I in 0 to components loop
        if(in_use(I) = '1') then
        
            if( I = 6 and countdown_enable = '1' ) then                
                pixel_out_i <= pixel_outs_i(I);
                inUse_Var := '1';
            elsif( I = 9 and timer_on = '1') then                               
                 pixel_out_i <= pixel_outs_i(I);
                 inUse_Var := '1';
            elsif( I = 11 and player_1_win = '1') then                               
                pixel_out_i <= pixel_outs_i(I);
                inUse_Var := '1';
            elsif( I = 12 and player_2_win = '1') then                               
                pixel_out_i <= pixel_outs_i(I);
                inUse_Var := '1';                
            elsif( I /= 6 and I /= 9 and I /= 11 and I /= 12) then                
                pixel_out_i <= pixel_outs_i(I);
                inUse_Var := '1';          
            end if;
        elsif(inUse_Var = '0') then
            pixel_out_i <= "111111111111";             
        end if;
    end loop;
end process;


red   <= pixel_out_i(11 downto 8);
green <= pixel_out_i(7 downto 4);
blue  <= pixel_out_i(3 downto 0);


end Behavioral;

