library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity game_downcounter is
  Generic ( period: integer:= 4;       
            WIDTH  : integer:= 3
		  );
    PORT ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           zero   : out STD_LOGIC;
           value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           first_value : in STD_LOGIC_VECTOR(WIDTH -1 downto 0)
         );
end game_downcounter;

architecture Behavioral of game_downcounter is
  signal current_count : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal zero_i        : STD_LOGIC; 
  signal first_value_used: STD_LOGIC := '0';
  
  constant max_count   : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := 
                         STD_LOGIC_VECTOR(to_unsigned(period, WIDTH) -1);
  constant zeros       : STD_LOGIC_VECTOR(WIDTH-1 downto 0) := (others => '0');
  
BEGIN
   
   count: process(clk,reset) begin
     if (rising_edge(clk)) then 
       if (reset = '1') then 
          current_count <= zeros;
          zero_i        <= '0';
          first_value_used <= '0';           
       elsif (enable = '1' and first_value_used = '1') then 
          if (current_count = zeros) then
            current_count <= max_count;
            zero_i        <= '1';
          else 
            current_count <= current_count - '1'; -- continue counting down
            zero_i        <= '0';
          end if;
       elsif (first_value_used = '0') then
            current_count <= first_value;
            first_value_used <= '1';
       else 
          zero_i <= '0';
       end if;
     end if;
   end process;
   
   value <= current_count; 
   zero  <= zero_i; 
   
END Behavioral;