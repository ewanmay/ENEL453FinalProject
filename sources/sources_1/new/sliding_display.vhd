library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity sliding_disp is
Port(  
       clk                : in STD_LOGIC;
       win_1              : in STD_LOGIC;
       win_2              : in STD_LOGIC;
       reset              : in STD_LOGIC;
       BUZZER             : out STD_LOGIC := '0';
       disp_dig1          : out STD_LOGIC_VECTOR := "0000";
       disp_dig2          : out STD_LOGIC_VECTOR := "0000";
       disp_dig3          : out STD_LOGIC_VECTOR := "0000";
       disp_dig4          : out STD_LOGIC_VECTOR := "0000"
   );
end sliding_disp;


architecture Behavioral of sliding_disp is

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

  signal onehertz       : STD_LOGIC;
  signal next_dig       : STD_LOGIC_VECTOR(3 downto 0):= "1110";
  signal disp_dig1_i    : STD_LOGIC_VECTOR(3 downto 0):= "1010";
  signal disp_dig2_i    : STD_LOGIC_VECTOR(3 downto 0):= "1011";
  signal disp_dig3_i    : STD_LOGIC_VECTOR(3 downto 0):= "1100";
  signal disp_dig4_i    : STD_LOGIC_VECTOR(3 downto 0):= "1101";
  signal end_word       : STD_LOGIC := '0';
  signal enable_i       : STD_LOGIC;
  signal reset_i        : STD_LOGIC;
  signal set_player     : STD_LOGIC := '0';
  signal win_used       : STD_LOGIC := '0';
  signal reset_slide    : STD_LOGIC := '0';

begin

oneHzClock: game_upcounter
   generic map(
               period => (100000000),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--               period => (10),   -- for sim testing
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable_i,
               zero   => onehertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );
            
          
output: process(clk, win_1, win_2, onehertz, reset_i)
begin   
    if(rising_edge(clk)) then                     
        if(reset_i = '1') then
            disp_dig1_i <= "1101";
            disp_dig2_i <= "1100";
            disp_dig3_i <= "1011";
            disp_dig4_i <= "1010";
            next_dig <= "1110";
            set_player <= '0';
            end_word <= '0';
            reset_slide <= '0';
        elsif(onehertz = '1') then
            if(set_player = '1') then
                if(win_1 = '1') then
                    next_dig <= "0001";
                else
                    next_dig <= "0010";
                end if;
                end_word <= '1';
                set_player <= '0';              
            elsif(end_word = '1') then
                if(
                    disp_dig4_i = "0000"  AND
                    disp_dig3_i = "0000"  AND
                    disp_dig2_i = "0000"  AND
                    disp_dig1_i = "0000"
                ) then
                    reset_slide <= '1';
                else 
                    next_dig <= "0000";
                end if;
            else
                next_dig <= next_dig + 1;
            end if;
            
            if(next_dig = "1111") then
                set_player <= '1';
            end if;     
            disp_dig1_i <= next_dig;
            disp_dig2_i <= disp_dig1_i; 
            disp_dig3_i <= disp_dig2_i;
            disp_dig4_i <= disp_dig3_i;                              
                             
        end if;
    end if;    
end process;

disp_dig1 <= disp_dig1_i;
disp_dig2 <= disp_dig2_i;
disp_dig3 <= disp_dig3_i;
disp_dig4 <= disp_dig4_i;
reset_i <= reset_slide OR reset;
enable_i <= win_1 or win_2;
end Behavioral;
