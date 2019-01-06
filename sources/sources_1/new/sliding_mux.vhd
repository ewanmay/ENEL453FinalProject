library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sliding_mux is
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
end sliding_mux;

architecture Behavioral of sliding_mux is
begin
output: process
    (   
    selector, 
    sliding_dig1,
    sliding_dig2,
    sliding_dig3,
    sliding_dig4, 
    output_dig1, 
    output_dig2, 
    output_dig3, 
    output_dig4
    ) 
begin
    if(selector = '1') then
        m_dig1 <= sliding_dig1;
        m_dig2 <= sliding_dig2;
        m_dig3 <= sliding_dig3;
        m_dig4 <= sliding_dig4; 
    else 
        m_dig1 <= output_dig1;
        m_dig2 <= output_dig2;
        m_dig3 <= output_dig3;
        m_dig4 <= output_dig4; 
    end if;

end process;

end Behavioral;
