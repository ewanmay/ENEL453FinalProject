library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity win_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC;
       led1               : out STD_LOGIC := '0';
       led2               : out STD_LOGIC := '0';
       led3               : out STD_LOGIC := '0';
       led4               : out STD_LOGIC := '0';
       reset              : in STD_LOGIC := '0'
   );
end win_disp;


architecture Behavioral of win_disp is

component music_box is
  Port (
    clk         : in STD_LOGIC;
    reset       : in STD_LOGIC;
    enable      : in STD_LOGIC;
    buzzer_out  : out STD_LOGIC
    );
end component;

component game_upcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 3
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

  signal onehertz : STD_LOGIC;
  signal buzzerfreq: STD_LOGIC;
  signal downfreq: STD_LOGIC;
  signal noteChange: STD_LOGIC;
  signal noteCounter: STD_LOGIC_VECTOR(4 downto 0);
  signal frequency: integer;
  signal dutyCycle: integer; 
  
  signal song_play: STD_LOGIC;
  signal buzzer_out: STD_LOGIC;
  signal counter_max : STD_LOGIC_VECTOR(4 downto 0):= "10101";
  signal counter  : STD_LOGIC_VECTOR(4 downto 0):= "00000";
  signal reset_i  : STD_LOGIC;
  signal enable_i : STD_LOGIC;
  signal new_flash : STD_LOGIC := '1';
  signal onOff    : STD_LOGIC := '0';
  signal nextOn   : STD_LOGIC := '0';
  signal win_used : STD_LOGIC := '0';

begin

music: music_box
   port map (
    clk         =>   clk,       
    reset       =>   song_play,     
    enable      =>   enable_i,
    buzzer_out  =>   buzzer_out
   );
   
oneHzClock: game_upcounter
   generic map(
               period => (20000000),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--               period => (30),   -- for sim testing
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset_i,
               enable => enable_i,
               zero   => onehertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );
output: process(clk, win_1, win_2, onehertz)
    begin   
    if(rising_edge(clk)) then
        if(reset = '1') then
            counter <= (others => '0');
            enable_i <= '1';
            onOff <= '0';
            nextOn <= '1';
            win_used <= '0';
            new_flash <= '0';
            song_play <= '0';
        elsif(win_used = '0' and (win_1 = '1' or win_2 = '1')) then
            counter <= (others => '0');
            enable_i <= '1';
            onOff <= '0';
            nextOn <= '1';
            win_used <= '1';
            new_flash <= '0';
            song_play <= '1';
        elsif(onehertz = '1') then
            if(win_1 = '1') then
                if(counter = counter_max) then         
                   enable_i <= '0';
                   new_flash <= '1';
                   song_play <= '0';
                else                          
                  counter <= counter + 1;
                  nextOn <= onOff; 
                  onOff <= nextOn; 
                  led3 <= onOff;
                  led4 <= onOff;  
                end if;              
            elsif(win_2 = '1') then
                if(counter = counter_max) then   
                   enable_i <= '0';                   
                   new_flash <= '1';
                   song_play <= '0';
                else                          
                  counter <= counter + 1;
                  nextOn <= onOff;                                   
                  onOff <= nextOn; 
                  led1 <= onOff;
                  led2 <= onOff;                   
                end if;
            end if;
        elsif(win_used = '1' and win_1 = '0' and win_2 = '0') then
            win_used <= '0';      
        end if;
    end if;
end process;    
reset_i    <= (win_1 or win_2) and new_flash;
buzzer <= buzzer_out;
end Behavioral;

