library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_top_level is
  Port (
         reset              : in STD_LOGIC;
         clk                : in STD_LOGIC;
         red                : out STD_LOGIC_VECTOR(3 downto 0);
         green              : out STD_LOGIC_VECTOR(3 downto 0);
         blue               : out STD_LOGIC_VECTOR(3 downto 0);
         hsync              : out STD_LOGIC;
         vsync              : out STD_LOGIC;    
         btn_1              : in STD_LOGIC;
         btn_2              : in STD_LOGIC;
         btn_3              : in STD_LOGIC;
         btn_4              : in STD_LOGIC;
         new_game           : in STD_LOGIC;
         game_start         : in STD_LOGIC;
         score_display      : in STD_LOGIC;
         set_highscore      : in STD_LOGIC;
         reset_highscore    : in STD_LOGIC;
         buzzer             : out STD_LOGIC;
         led1               : out STD_LOGIC;
         led2               : out STD_LOGIC;
         led3               : out STD_LOGIC;
         led4               : out STD_LOGIC;
         led5               : out STD_LOGIC;
         led6               : out STD_LOGIC;
         CA                 : out STD_LOGIC;
         CB                 : out STD_LOGIC;
         CC                 : out STD_LOGIC;
         CD                 : out STD_LOGIC;
         CE                 : out STD_LOGIC;
         CF                 : out STD_LOGIC;
         CG                 : out STD_LOGIC;
         DP                 : out STD_LOGIC;
         AN1                : out STD_LOGIC;
         AN2                : out STD_LOGIC;
         AN3                : out STD_LOGIC;
         AN4                : out STD_LOGIC
      );
end game_top_level;

architecture Behavioral of game_top_level is

component top_10 is
 PORT(
    clk         : in STD_LOGIC;
    reset       : in STD_LOGIC;
    game_reset  : in STD_LOGIC;
    win1        : in STD_LOGIC;
    win2        : in STD_LOGIC;
    sec_dig1    : in STD_LOGIC_VECTOR(3 downto 0);
    sec_dig2    : in STD_LOGIC_VECTOR(3 downto 0);
    min_dig1    : in STD_LOGIC_VECTOR(3 downto 0);
    min_dig2    : in STD_LOGIC_VECTOR(3 downto 0);
    concat_time : out STD_LOGIC_VECTOR(159 downto 0);
    round_win   : out STD_LOGIC_VECTOR(9 downto 0)
 );
end component;

component comparator is
 PORT(
        button1     : in STD_LOGIC;
        button2     : in STD_LOGIC;
        clk         : in STD_LOGIC;
        reset       : in STD_LOGIC;
        enable      : in STD_LOGIC;
        win1        : out STD_LOGIC;
        win2        : out STD_LOGIC;
        save        : out STD_LOGIC;
        sec_dig1    : out STD_LOGIC_VECTOR(3 downto 0);
        sec_dig2    : out STD_LOGIC_VECTOR(3 downto 0);
        min_dig1    : out STD_LOGIC_VECTOR(3 downto 0);
        min_dig2    : out STD_LOGIC_VECTOR(3 downto 0)
 );
end component;

component three_sec_countdown 
    PORT ( 
        clk          : in STD_LOGIC;
        reset        : in STD_LOGIC;
        enable       : in STD_LOGIC;
        sec_dig1     : out STD_LOGIC_VECTOR(3 downto 0);
        sec_dig2     : out STD_LOGIC_VECTOR(3 downto 0);
        min_dig1     : out STD_LOGIC_VECTOR(3 downto 0);
        min_dig2     : out STD_LOGIC_VECTOR(3 downto 0);
        enable_out   : out STD_LOGIC;
        enable_cd    : out STD_LOGIC
           );
end component;

component random_clk is
   port (
        enable        : in STD_LOGIC;
        clk           : in  std_logic;
        enable_out    : out std_logic;
        reset         : in STD_LOGIC
   );
end component;

component score_keep is
  port (        
        win_1               : in STD_LOGIC;
        win_2               : in STD_LOGIC;
        clk                 : in STD_LOGIC;
        reset               : in STD_LOGIC;
        high_score_dig1     : in STD_LOGIC_VECTOR(3 downto 0);
        high_score_dig2     : in STD_LOGIC_VECTOR(3 downto 0);      
        high_score_dig1_out : out STD_LOGIC_VECTOR(3 downto 0);
        high_score_dig2_out : out STD_LOGIC_VECTOR(3 downto 0);
        player1_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
        player1_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
        player2_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
        player2_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
        player1_win         : out STD_LOGIC;
        player2_win         : out STD_LOGIC
    );
end component;

component sliding_mux is
 Port(
       sliding_dig1       : in STD_LOGIC_VECTOR(3 downto 0);
       sliding_dig2       : in STD_LOGIC_VECTOR(3 downto 0);
       sliding_dig3       : in STD_LOGIC_VECTOR(3 downto 0);
       sliding_dig4       : in STD_LOGIC_VECTOR(3 downto 0);
       output_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       output_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       output_dig3        : in STD_LOGIC_VECTOR(3 downto 0);
       output_dig4        : in STD_LOGIC_VECTOR(3 downto 0);
       selector          : in STD_LOGIC;
       m_dig1            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig2            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig3            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig4            : out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component time_score_mux is
 Port(
       tm_sec_dig1       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_sec_dig2       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig1       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig2       : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig3        : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig4        : in STD_LOGIC_VECTOR(3 downto 0);
       selector          : in STD_LOGIC;
       m_dig1            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig2            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig3            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig4            : out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component sliding_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       reset              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC;
       disp_dig1          : out STD_LOGIC_VECTOR := "0000";
       disp_dig2          : out STD_LOGIC_VECTOR := "0000";
       disp_dig3          : out STD_LOGIC_VECTOR := "0000";
       disp_dig4          : out STD_LOGIC_VECTOR := "0000"
   );
end component;

component countdown_time_mux is
 Port(
       sec_dig1           : in STD_LOGIC_VECTOR(3 downto 0);
       sec_dig2           : in STD_LOGIC_VECTOR(3 downto 0);
       min_dig1           : in STD_LOGIC_VECTOR(3 downto 0);
       min_dig2           : in STD_LOGIC_VECTOR(3 downto 0);
       cd_sec_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_sec_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_min_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       cd_min_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       selector           : in STD_LOGIC;
       tm_sec_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_sec_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig2        : out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component digit_multiplexor is
  PORT ( 
          sec_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          selector   : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;

component seven_segment_decoder is
    PORT ( 
           CA    : out STD_LOGIC;
           CB    : out STD_LOGIC;
           CC    : out STD_LOGIC;
           CD    : out STD_LOGIC;
           CE    : out STD_LOGIC;
           CF    : out STD_LOGIC;
           CG    : out STD_LOGIC;
           DP    : out STD_LOGIC;
           dp_in : in  STD_LOGIC;
           data  : in  STD_LOGIC_VECTOR (3 downto 0)
         );
end component;

component seven_segment_digit_selector is 
   PORT  
          ( clk          : in  STD_LOGIC;
           digit_select : out STD_LOGIC_VECTOR (3 downto 0);
           an_outputs   : out STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
		 );
end component;

component win_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC;
       led1               : out STD_LOGIC;
       led2               : out STD_LOGIC;
       led3               : out STD_LOGIC;
       led4               : out STD_LOGIC
   );
end component;

component highscore_store is
    Port ( 
       score_up     : in STD_LOGIC;
       score_down   : in STD_LOGIC;
       clk          : in STD_LOGIC;
       reset        : in STD_LOGIC;
       enable       : in STD_LOGIC;
       ts_dig1      : out STD_LOGIC_VECTOR(3 downto 0);
       ts_dig2      : out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component highscore_mux is
 Port(
       tm_sec_dig1       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_sec_dig2       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig1       : in STD_LOGIC_VECTOR(3 downto 0);
       tm_min_dig2       : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig1        : in STD_LOGIC_VECTOR(3 downto 0);
       score_dig2        : in STD_LOGIC_VECTOR(3 downto 0);
       selector          : in STD_LOGIC;
       m_dig1            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig2            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig3            : out STD_LOGIC_VECTOR(3 downto 0);
       m_dig4            : out STD_LOGIC_VECTOR(3 downto 0)
   );
end component;

component vga_module is
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
end component;

signal sec_dig1_i, cd_sec_dig1_i, tm_sec_dig1_i, hsm_dig1_i, out_dig1_i, m_dig1_i, ts_dig1_i : STD_LOGIC_VECTOR(3 downto 0); 
signal sec_dig2_i, cd_sec_dig2_i, tm_sec_dig2_i, hsm_dig2_i, out_dig2_i, m_dig2_i, ts_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal min_dig1_i, cd_min_dig1_i, tm_min_dig1_i, hsm_dig3_i, out_dig3_i, m_dig3_i : STD_LOGIC_VECTOR(3 downto 0);
signal min_dig2_i, cd_min_dig2_i, tm_min_dig2_i, hsm_dig4_i, out_dig4_i, m_dig4_i : STD_LOGIC_VECTOR(3 downto 0);

signal win1_i : STD_LOGIC;
signal win2_i : STD_LOGIC;
signal BUZZER_i : STD_LOGIC;

signal SLIDE_BUZZER_i : STD_LOGIC;

signal decimal_decider : STD_LOGIC;

signal led1_i, led2_i, led3_i, led4_i : STD_LOGIC;
signal CA_i, CB_i, CC_i, CD_i, CE_i, CF_i, CG_i, out_dp, in_DP: STD_LOGIC;

signal high_score_dig1_i, high_score_dig1_out_i     : STD_LOGIC_VECTOR(3 downto 0);  
signal high_score_dig2_i, high_score_dig2_out_i     : STD_LOGIC_VECTOR(3 downto 0);  
signal player1_dig1_i, sliding_dig1_i               : STD_LOGIC_VECTOR(3 downto 0);  
signal player1_dig2_i, sliding_dig2_i               : STD_LOGIC_VECTOR(3 downto 0);  
signal player2_dig1_i, sliding_dig3_i               : STD_LOGIC_VECTOR(3 downto 0);  
signal player2_dig2_i, sliding_dig4_i               : STD_LOGIC_VECTOR(3 downto 0);  
signal player1_win_i                                : STD_LOGIC;  
signal player2_win_i                                : STD_LOGIC;  
signal digit_select_i, time_digit_i                 : STD_LOGIC_VECTOR(3 downto 0);
signal timer_start_i                                : STD_LOGIC;
signal final_start_i                                : STD_LOGIC;
signal enable_random, enable_mux                    : STD_LOGIC;
signal an_i, digit_to_display                       : STD_LOGIC_VECTOR(3 downto 0);
signal save_i                                       : STD_LOGIC;

--VGA

signal rounds_array_in_i: STD_LOGIC_VECTOR(159 downto 0):= (others => '0');
signal round_winners_in_i: STD_LOGIC_VECTOR(9 downto 0):= (others => '0');

begin

HIGHSCORE_MULTIPLEXOR: highscore_mux 
PORT MAP (
        tm_sec_dig1     =>     m_dig1_i,  
        tm_sec_dig2     =>     m_dig2_i,  
        tm_min_dig1     =>     m_dig3_i,  
        tm_min_dig2     =>     m_dig4_i,  
        score_dig1      =>     high_score_dig1_i,
        score_dig2      =>     high_score_dig2_i,
        selector        =>     set_highscore,
        m_dig1          =>     hsm_dig1_i,
        m_dig2          =>     hsm_dig2_i,
        m_dig3          =>     hsm_dig3_i,
        m_dig4          =>     hsm_dig4_i
);

SCOREBOARD: top_10
 PORT MAP (
        clk             =>    clk,
        reset           =>    reset,
        game_reset      =>    new_game,
        win1            =>    win1_i,
        win2            =>    win2_i,
        sec_dig1        =>    sec_dig1_i,
        sec_dig2        =>    sec_dig2_i,
        min_dig1        =>    min_dig1_i,
        min_dig2        =>    min_dig2_i,
        concat_time     =>    rounds_array_in_i,
        round_win       =>    round_winners_in_i
 );

COMPARER: comparator
PORT MAP (
        button1     =>      btn_2, 
        button2     =>      btn_1, 
        clk         =>      clk,     
        reset       =>      new_game,   
        enable      =>      timer_start_i,  
        win1        =>      win1_i,    
        win2        =>      win2_i,
        save        =>      save_i,    
        sec_dig1    =>      sec_dig1_i,
        sec_dig2    =>      sec_dig2_i,
        min_dig1    =>      min_dig1_i,
        min_dig2    =>      min_dig2_i
);

HIGHSCORE_STORER: highscore_store
PORT MAP (
        score_up   => btn_3,
        score_down => btn_4,
        clk        => clk,
        reset      => reset_highscore,
        enable     => set_highscore,
        ts_dig1    => high_score_dig1_i,
        ts_dig2    => high_score_dig2_i    
);

SLIDING_DISPLAY: sliding_disp
PORT MAP (
        clk        => clk,      
        win_1      => player1_win_i,    
        win_2      => player2_win_i,    
        reset      => reset,    
        BUZZER     => SLIDE_BUZZER_i,   
        disp_dig1  => sliding_dig1_i,
        disp_dig2  => sliding_dig2_i,
        disp_dig3  => sliding_dig3_i,
        disp_dig4  => sliding_dig4_i
);

THREE_SEC_CD: three_sec_countdown 
PORT MAP(
        clk          =>  clk,       
        reset        =>  new_game,     
        enable       =>  game_start,    
        sec_dig1     =>  cd_sec_dig1_i,  
        sec_dig2     =>  cd_sec_dig2_i,  
        min_dig1     =>  cd_min_dig1_i,  
        min_dig2     =>  cd_min_dig2_i,  
        enable_out   =>  enable_random,
        enable_cd    =>  enable_mux
);

RANDOM_CLOCK: random_clk
PORT MAP(
        enable     => enable_random,   
        clk        => clk,        
        enable_out => timer_start_i,
        reset      => new_game      
);

SCORE_KEEPER: score_keep
PORT MAP (
        win_1             =>  win1_i,           
        win_2             =>  win2_i,            
        clk               =>  clk,              
        reset             =>  reset,            
        high_score_dig1   =>  high_score_dig1_i,  
        high_score_dig2   =>  high_score_dig2_i,
        high_score_dig1_out => high_score_dig1_out_i,
        high_score_dig2_out => high_score_dig2_out_i,  
        player1_dig1      =>  player1_dig1_i,     
        player1_dig2      =>  player1_dig2_i,     
        player2_dig1      =>  player2_dig1_i,     
        player2_dig2      =>  player2_dig2_i,     
        player1_win       =>  player1_win_i,      
        player2_win       =>  player2_win_i      
);

SCORE_COUNTER_MUX : time_score_mux
PORT MAP (
        tm_sec_dig1     =>     tm_sec_dig1_i,  
        tm_sec_dig2     =>     tm_sec_dig2_i,  
        tm_min_dig1     =>     tm_min_dig1_i,  
        tm_min_dig2     =>     tm_min_dig2_i,  
        score_dig1      =>     player1_dig1_i,
        score_dig2      =>     player1_dig2_i,
        score_dig3      =>     player2_dig1_i,
        score_dig4      =>     player2_dig2_i,
        selector        =>     SCORE_DISPLAY,
        m_dig1          =>     m_dig1_i,
        m_dig2          =>     m_dig2_i,
        m_dig3          =>     m_dig3_i,
        m_dig4          =>     m_dig4_i
);

COUNTDOWN_TIMER_MUX: countdown_time_mux 
PORT MAP (
        sec_dig1     =>     sec_dig1_i,   
        sec_dig2     =>     sec_dig2_i,   
        min_dig1     =>     min_dig1_i,   
        min_dig2     =>     min_dig2_i,   
        cd_sec_dig1  =>     cd_sec_dig1_i,
        cd_sec_dig2  =>     cd_sec_dig2_i,
        cd_min_dig1  =>     cd_min_dig1_i,
        cd_min_dig2  =>     cd_min_dig2_i,
        selector     =>     enable_mux,   
        tm_sec_dig1  =>     tm_sec_dig1_i,
        tm_sec_dig2  =>     tm_sec_dig2_i,
        tm_min_dig1  =>     tm_min_dig1_i,
        tm_min_dig2  =>     tm_min_dig2_i
);

SLIDING_MULTIPLEXOR: sliding_mux
 PORT MAP(
       sliding_dig1  =>  sliding_dig1_i,
       sliding_dig2  =>  sliding_dig2_i,
       sliding_dig3  =>  sliding_dig3_i,
       sliding_dig4  =>  sliding_dig4_i,
       output_dig1   =>  hsm_dig1_i,
       output_dig2   =>  hsm_dig2_i,
       output_dig3   =>  hsm_dig3_i,
       output_dig4   =>  hsm_dig4_i,
       selector      =>  final_start_i,
       m_dig1        =>  out_dig1_i,
       m_dig2        =>  out_dig2_i,
       m_dig3        =>  out_dig3_i,
       m_dig4        =>  out_dig4_i   
   );

WINNER_DISPLAY: win_disp
PORT MAP (
        clk       => clk,
        win_1     => win1_i,
        win_2     => win2_i,
        BUZZER    => BUZZER_i,
        led1      => led1_i,
        led2      => led2_i,
        led3      => led3_i,
        led4      => led4_i   
);

DIGIT_MUX: digit_multiplexor
PORT MAP (
        sec_dig1    =>  out_dig1_i,  
        sec_dig2    =>  out_dig2_i,  
        min_dig1    =>  out_dig3_i,  
        min_dig2    =>  out_dig4_i,  
        selector    =>  digit_select_i,  
        time_digit  =>  digit_to_display
);

DECODER: seven_segment_decoder
PORT MAP(
        CA      =>   CA_i,    
        CB      =>   CB_i,    
        CC      =>   CC_i,    
        CD      =>   CD_i,    
        CE      =>   CE_i,    
        CF      =>   CF_i,    
        CG      =>   CG_i,    
        DP      =>   out_DP,    
        dp_in   =>   in_DP,
        data    =>   digit_to_display  
);

SELECTOR: seven_segment_digit_selector
PORT MAP(
        clk           => clk,
        digit_select   => digit_select_i,
        an_outputs     => an_i,
        reset          => reset     
);

VGA: vga_module
    PORT MAP ( 
            clk              => clk,
            red              => red,
            green            => green,
            blue             => blue,
            hsync            => hsync,
            vsync            => vsync,
            score_p1_dig1_in => player1_dig1_i,
            score_p1_dig2_in => player1_dig2_i,
            score_p2_dig1_in => player2_dig1_i,
            score_p2_dig2_in => player2_dig2_i,
            seconds_in       => min_dig2_i,
            hundredths_in    => sec_dig2_i,
            tenths_in        => min_dig1_i,
            thousandths_in   => sec_dig1_i,
            rounds_array_in  => rounds_array_in_i,
            round_winners_in => round_winners_in_i,
            player_1_win     => player1_win_i,
            player_2_win     => player2_win_i,
                           --COUNTDOWN
            countdown_num        => cd_sec_dig1_i,
            countdown_enable     => enable_mux,
                           --PLAYING_TO               
            playing_to_dig1      =>  high_score_dig1_out_i,
            playing_to_dig2      =>  high_score_dig2_out_i,
            timer_on              =>  timer_start_i,
            flash_p2              =>  led1_i,
            flash_p1              =>  led3_i,
            round_start_signal   =>   timer_start_i
	 );
decimal: process (clk, reset) begin
        if(rising_edge(clk)) then
         if(reset = '1') then
             decimal_decider <= '0';
         elsif(timer_start_i = '1' and score_display = '0') then
             decimal_decider <= '1';
         elsif(timer_start_i = '0' or score_display = '1') then
             decimal_decider <= '0';
         end if;         
         if(decimal_decider = '1') then
              in_dp <= an_i(3);
         else
              in_dp <= an_i(2);    
         end if;
      end if;
     
     end process;

led1  <=   led1_i;
led2  <=   led2_i;
led3  <=   led3_i;
led4  <=   led4_i;
led5  <=   timer_start_i;
led6  <=   timer_start_i; 

final_start_i <= player1_win_i or player2_win_i;
 
DP <= out_dp;
CA <= CA_i;
CB <= CB_i;
CC <= CC_i;
CD <= CD_i;
CE <= CE_i;
CF <= CF_i;
CG <= CG_i;

 
AN1 <= an_i(0); -- seconds digit
AN2 <= an_i(1); -- tens of seconds digit
AN3 <= an_i(2); -- minutes digit
AN4 <= an_i(3); -- tens of minutes digit           

LED1    <= LED1_i;
LED2    <= LED2_i;
BUZZER  <= BUZZER_i; 

end Behavioral;
