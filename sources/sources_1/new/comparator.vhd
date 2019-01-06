library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
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
end comparator;


architecture Behavioral of comparator is

component game_clock_divider is
    PORT ( 
    clk      : in  STD_LOGIC;
    reset    : in  STD_LOGIC;
    enable   : in  STD_LOGIC;
    sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
    sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
    min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
    min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;

component debounce is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           confirmed_press : out STD_LOGIC);
end component;

signal sec_dig1_i, sec_dig2_i, min_dig1_i, min_dig2_i: STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
signal min_press_i, player1_press_i, sec_press_i, player2_press_i: STD_LOGIC:= '0';
signal enable_stop, enable_i: STD_LOGIC:= '0';
signal win1_i, win2_i, button1_i, button2_i: STD_LOGIC:= '0';
begin

PLAYER1: debounce
PORT MAP (
    input => button1_i,
    clk => clk,
    confirmed_press => player1_press_i
);

PLAYER2: debounce
PORT MAP (
    input => button2_i,
    clk => clk,
    confirmed_press => player2_press_i
);

CLOCK_DIV: game_clock_divider 
PORT MAP ( 
    clk      => clk,
    reset    => reset,
    enable   => enable_i,
    sec_dig1 => sec_dig1_i,
    sec_dig2 => sec_dig2_i,
    min_dig1 => min_dig1_i,
    min_dig2 => min_dig2_i
  );
  
button_press : process (clk, button1, button2, reset) begin
    if(rising_edge(clk)) then    
        if(reset = '1') then
            enable_stop <= '0';
            win1_i <= '0';
            win2_i <= '0';
        else  
            button1_i <= button1;
            button2_i <= button2;
            if(player1_press_i = '1' and win2_i = '0' and enable = '1') then
                win1_i <= '1';
                enable_stop <= '1';
            elsif(player2_press_i = '1' and win1_i = '0' and enable = '1') then
                win2_i <= '1';
                enable_stop <= '1';        
            end if;
        end if;
     end if;
end process; 

stop_clk : process(clk, enable_stop)
begin
    if(rising_edge(clk)) then
        if(enable_stop = '1') then
            enable_i <= '0';
        else
            enable_i <= enable;
        end if;
     end if;
end process;

sec_dig1 <= sec_dig1_i;
sec_dig2 <= sec_dig2_i;
min_dig1 <= min_dig1_i;
min_dig2 <= min_dig2_i;
win1 <= win1_i;
win2 <= win2_i;

save <= enable_stop;

end Behavioral;
