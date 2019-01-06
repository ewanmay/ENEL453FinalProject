
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity score_keep is
    port (        
        win_1               : in STD_LOGIC;
        win_2               : in STD_LOGIC;
        clk                 : in STD_LOGIC;
        reset               : in STD_LOGIC;
        high_score_dig1     : in STD_LOGIC_VECTOR(3 downto 0):= "0011";
        high_score_dig2     : in STD_LOGIC_VECTOR(3 downto 0):= "0000";        
        high_score_dig1_out : out STD_LOGIC_VECTOR(3 downto 0);
        high_score_dig2_out : out STD_LOGIC_VECTOR(3 downto 0);
        player1_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
        player1_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
        player2_dig1        : out STD_LOGIC_VECTOR(3 downto 0);
        player2_dig2        : out STD_LOGIC_VECTOR(3 downto 0);
        player1_win         : out STD_LOGIC;
        player2_win         : out STD_LOGIC
    );
end score_keep;

architecture Behavioral of score_keep is
 signal player1_dig1_i      : STD_LOGIC_VECTOR(3 downto 0) := ( others => '0');
 signal player1_dig2_i      : STD_LOGIC_VECTOR(3 downto 0) := ( others => '0');
 signal player2_dig1_i      : STD_LOGIC_VECTOR(3 downto 0) := ( others => '0');
 signal player2_dig2_i      : STD_LOGIC_VECTOR(3 downto 0) := ( others => '0');
 signal high_score_dig1_i   : STD_LOGIC_VECTOR(3 downto 0) := "0011";
 signal high_score_dig2_i   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
 signal player1_win_i       : STD_LOGIC;
 signal player2_win_i       : STD_LOGIC;
 signal win_used            : STD_LOGIC;
begin
  
    set_score: process  (clk, reset, win_1, win_2) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                player1_dig1_i <= ( others => '0');
                player1_dig2_i <= ( others => '0');
                player2_dig1_i <= ( others => '0');
                player2_dig2_i <= ( others => '0');
                if(high_score_dig1 = "0000" and high_score_dig2 = "0000") then                
                        high_score_dig1_i <= "0011";
                        high_score_dig2_i <= "0000";
                else                                                           
                        high_score_dig1_i <= high_score_dig1;
                        high_score_dig2_i <= high_score_dig2;
                end if;
                player1_win_i <= '0';
                player2_win_i <= '0';
            else
                 if(win_1 = '1' and win_used = '0') then                 
                    if(player1_dig1_i = "1001") then                            
                        player1_dig2_i <= player1_dig2_i + 1;
                        player1_dig1_i <= "0000";
                        win_used <= '1';
                    else
                        player1_dig1_i <= player1_dig1_i + 1;
                        win_used <= '1';
                    end if;
                 elsif(win_2 = '1' and win_used = '0') then
                    if(player2_dig1_i = "1001") then                            
                        player2_dig2_i <= player2_dig2_i + 1;
                        player2_dig1_i <= "0000";
                        win_used <= '1';
                    else
                        player2_dig1_i <= player2_dig1_i + 1;
                        win_used <= '1';
                    end if;
                 elsif(win_1 = '0' and win_2 = '0') then                  
                    win_used <= '0';       
                end if;
            end if;
            if(player1_dig1_i = high_score_dig1_i and player1_dig2_i = high_score_dig2_i) then
                player1_win_i <= '1';
            elsif(player2_dig1_i = high_score_dig1_i and player2_dig2_i = high_score_dig2_i) then
                player2_win_i <= '1';
            end if;
        end if;
    end process; 


player1_dig1 <= player1_dig1_i;
player1_dig2 <= player1_dig2_i;
player2_dig1 <= player2_dig1_i;
player2_dig2 <= player2_dig2_i;
player1_win <= player1_win_i;
player2_win <= player2_win_i;
high_score_dig1_out <= high_score_dig1_i;
high_score_dig2_out <= high_score_dig2_i;
end Behavioral;
