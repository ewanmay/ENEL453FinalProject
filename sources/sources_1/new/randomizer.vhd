library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

 entity randomizer is
   port (
     start         : in STD_LOGIC;
     clk           : in  std_logic;
     rstb          : in  std_logic;
     sync_reset    : in  std_logic;
     seed          : in  std_logic_vector (7 downto 0);
     en            : in  std_logic:= '1';
     lfsr_out      : out std_logic_vector (7 downto 0)
   );
 end entity;

 architecture rtl of randomizer is
   signal lfsr       : std_logic_vector (7 downto 0);
   
 begin

   -- option for LFSR size 4
   lfsr_out  <= lfsr(7 downto 0);
   
 
   p_lfsr : process (clk,rstb) begin 
     if (rstb = '0') then 
       lfsr   <= (others=>'1');
     elsif rising_edge(clk) then 
       if(sync_reset='1') then
         lfsr   <= seed;
       elsif (en = '1') then        
         lfsr(7) <= lfsr(0);
         lfsr(6) <= lfsr(5);
         lfsr(5) <= lfsr(6) xor lfsr(0);
         lfsr(4) <= lfsr(5);
         lfsr(3) <= lfsr(4);
         lfsr(2) <= lfsr(3);
         lfsr(1) <= lfsr(2);
         lfsr(0) <= lfsr(1);
       end if; 
     end if; 
   end process p_lfsr;
  
 end architecture;
