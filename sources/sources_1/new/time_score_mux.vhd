library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity time_score_mux is
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
end time_score_mux;

architecture Behavioral of time_score_mux is
begin
output: process
    (   
    selector, 
    tm_sec_dig1,
    tm_sec_dig2,
    tm_min_dig1,
    tm_min_dig2, 
    score_dig1, 
    score_dig2, 
    score_dig3, 
    score_dig4
    ) 
begin
    if(selector = '1') then
        m_dig1 <= score_dig1;
        m_dig2 <= score_dig2;
        m_dig3 <= score_dig3;
        m_dig4 <= score_dig4; 
    else 
        m_dig1 <= tm_sec_dig1;
        m_dig2 <= tm_sec_dig2;
        m_dig3 <= tm_min_dig1;
        m_dig4 <= tm_min_dig2; 
    end if;

end process;

end Behavioral;