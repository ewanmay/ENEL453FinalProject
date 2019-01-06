library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
library STD;
use STD.textio;
entity time_store is
    Port ( min_up       : in STD_LOGIC;
           sec_up       : in STD_LOGIC;
           clk          : in STD_LOGIC;
           reset        : in STD_LOGIC;
           enable       : in STD_LOGIC;
           ts_sec_dig1  : out STD_LOGIC_VECTOR(3 downto 0);
           ts_sec_dig2  : out STD_LOGIC_VECTOR(3 downto 0);
           ts_min_dig1  : out STD_LOGIC_VECTOR(3 downto 0);
           ts_min_dig2  : out STD_LOGIC_VECTOR(3 downto 0)
           );
end time_store;

architecture Behavioral of time_store is

component debounce is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           confirmed_press : out STD_LOGIC);
end component;

signal old_min_up, old_sec_up: STD_LOGIC := '0';
signal ts_sec_dig1_i, ts_sec_dig2_i, ts_min_dig1_i, ts_min_dig2_i: STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
signal min_press_i, min_conf_press_i, sec_press_i, sec_conf_press_i: STD_LOGIC:= '0';
begin

MIN_DEBOUNCE: debounce
PORT MAP (
    input => min_press_i,
    clk => clk,
    confirmed_press => min_conf_press_i
);

SEC_DEBOUNCE: debounce
PORT MAP (
    input => sec_press_i,
    clk => clk,
    confirmed_press => sec_conf_press_i
);

change_time: process (clk, reset, min_up, sec_up, enable)
    begin    
    if(reset = '1') then 
        ts_min_dig1_i <= "0000";
        ts_min_dig2_i <= "0000";
        ts_sec_dig1_i <= "0000";
        ts_sec_dig2_i <= "0000";        
    elsif(enable = '1' and rising_edge(clk)) then
        min_press_i <= min_up;
        sec_press_i <= sec_up;
        if(sec_conf_press_i = '1') then           
            if(ts_sec_dig1_i = "1001") then -- if seconds at 9
               if(ts_sec_dig2_i = "0101") then   -- if tens seconds at 5    
                    ts_sec_dig1_i <= "0000";
                    ts_sec_dig2_i <= "0000";
               else
                    ts_sec_dig2_i <= ts_sec_dig2_i + 1;
                    ts_sec_dig1_i <= "0000";
               end if;
            else
                ts_sec_dig1_i <= ts_sec_dig1_i + 1; 
            end if;
        end if;
        if(min_conf_press_i = '1') then          
            if(ts_min_dig1_i = "1001") then -- if minutes at 9
               if(ts_min_dig2_i = "0101") then  -- if tens minutes at 5 
                    ts_min_dig1_i <= "0000";
                    ts_min_dig2_i <= "0000";
               else
                    ts_min_dig2_i <= ts_min_dig2_i + 1;
                    ts_min_dig1_i <= "0000";
               end if;
            else
                    ts_min_dig1_i <= ts_min_dig1_i + 1;
               end if;
        end if;
    end if;                
end process;

ts_sec_dig1 <= ts_sec_dig1_i;
ts_sec_dig2 <= ts_sec_dig2_i;
ts_min_dig1 <= ts_min_dig1_i;
ts_min_dig2 <= ts_min_dig2_i;

end Behavioral;
