library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_10 is
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
end top_10;

architecture Behavioral of top_10 is

signal concat_time_i: STD_LOGIC_VECTOR(159 downto 0):= (others => '0');
signal time_LR: STD_LOGIC_VECTOR(9 downto 0):= (others => '0');
signal time_used: STD_LOGIC;

constant zeros : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');

begin

load: process(clk,reset) begin
    if(rising_edge(clk)) then
        if(reset = '1') then
            concat_time_i <= (others => '0');
            time_LR <= (others => '0');
            time_used <= '0';
        elsif(game_reset = '1') then
            time_used <= '0';
        elsif(win1 = '1' and time_used = '0') then
            time_LR <= time_LR(8 downto 0) & "0";
            concat_time_i <= concat_time_i(143 downto 0) & min_dig2 &  min_dig1 & sec_dig2 & sec_dig1;
            time_used <= '1';
        elsif(win2 = '1' and time_used = '0') then
            time_LR <= time_LR(8 downto 0) & "1";
            concat_time_i <= concat_time_i(143 downto 0) & min_dig2 &  min_dig1 & sec_dig2 & sec_dig1;
            time_used <= '1';
        end if;         
     end if;
end process;

concat_time <= concat_time_i;
round_win <= time_LR;

end Behavioral;
