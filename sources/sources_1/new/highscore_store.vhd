library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
library STD;
use STD.textio;
entity highscore_store is
    Port ( score_up   : in STD_LOGIC;
           score_down   : in STD_LOGIC;
           clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           enable   : in STD_LOGIC;
           ts_dig1  : out STD_LOGIC_VECTOR(3 downto 0);
           ts_dig2  : out STD_LOGIC_VECTOR(3 downto 0)
           );
end highscore_store;

architecture Behavioral of highscore_store is

component debounce is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           confirmed_press : out STD_LOGIC);
end component;

signal ts_dig1_i, ts_dig2_i: STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
signal up_press_i, up_conf_press_i, down_press_i, down_conf_press_i: STD_LOGIC:= '0';
signal score_up_i, score_down_i: STD_LOGIC:= '0';
begin

UP_COUNT: debounce
PORT MAP (
    input => up_press_i,
    clk => clk,
    confirmed_press => up_conf_press_i
);

DOWN_COUNT: debounce
PORT MAP (
    input => down_press_i,
    clk => clk,
    confirmed_press => down_conf_press_i
);

change_time: process (clk, reset, score_up, score_down, enable)
    begin    
    if(reset = '1') then 
        ts_dig1_i <= "0001";
        ts_dig2_i <= "0000";       
    elsif(enable = '1' and rising_edge(clk)) then
        up_press_i <= score_up;
        down_press_i <= score_down;
        if(up_conf_press_i = '1') then           
            if(ts_dig1_i = "1001") then -- if seconds at 9
               if(ts_dig2_i = "1001") then   -- if tens seconds at 5    
                    ts_dig1_i <= "0000";
                    ts_dig2_i <= "0000";
               else
                    ts_dig2_i <= ts_dig2_i + "0001";
                    ts_dig1_i <= "0000";
               end if;
            else
                ts_dig1_i <= ts_dig1_i + "0001"; 
            end if;
        end if;
        if(down_conf_press_i = '1') then          
            if(ts_dig1_i = "0000") then -- if minutes at 9
               if(ts_dig2_i = "0000") then  -- if tens minutes at 5 
                    ts_dig1_i <= "1001";
                    ts_dig2_i <= "1001";
               else
                    ts_dig2_i <= ts_dig2_i - "0001";
                    ts_dig1_i <= "1001";
               end if;
            else
                    ts_dig1_i <= ts_dig1_i - "0001";
               end if;
        end if;
    end if;                
end process;

ts_dig1 <= ts_dig1_i;
ts_dig2 <= ts_dig2_i;

end Behavioral;
