library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity music_box is
  Port (
    clk: in STD_LOGIC;
    reset: in STD_LOGIC;
    enable: in STD_LOGIC;
    buzzer_out: out STD_LOGIC;
    counter_out: out STD_LOGIC_VECTOR(3 downto 0);
    b_en: OUT STD_LOGIC;
    c_en: OUT STD_LOGIC;
    d_en: OUT STD_LOGIC
    );
end music_box;

architecture Behavioral of music_box is

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

signal D_enable, C_enable, Bb_enable, DC1_enable, DC2_enable, noteChange, reset_used, enable_i: STD_LOGIC;
signal D_zero,   C_zero, Bb_zero, DC1_zero, DC2_zero: STD_LOGIC;
signal note_reset, DC1_reset, DC2_reset, reset_i: STD_LOGIC;
signal counter: STD_LOGIC_VECTOR(3 downto 0):= "0000";
signal buzzer_up, buzzer_down: STD_LOGIC;
begin
            
    D: game_upcounter
    generic map(
       period => (34052),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--                   period => (6),   -- for sim testing
       WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
    PORT MAP (
       clk    => clk,
       reset  => note_reset,
       enable => D_enable,
       zero   => D_zero, -- this is a 1 Hz clock signal
       value  => open  -- Leave open since we won't display this value
    );
    
    C: game_upcounter
        generic map(
           period => (38221),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--                       period => (6),   -- for sim testing
           WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
          )
        PORT MAP (
           clk    => clk,
           reset  => note_reset,
           enable => C_enable,
           zero   => C_zero, -- this is a 1 Hz clock signal
           value  => open  -- Leave open since we won't display this value
        );
    
    Bb: game_upcounter
    generic map(
       period => (42904),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--                   period => (6),   -- for sim testing
       WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
    PORT MAP (
       clk    => clk,
       reset  => note_reset,
       enable => Bb_enable,
       zero   => Bb_zero, -- this is a 1 Hz clock signal
       value  => open  -- Leave open since we won't display this value
    );
    
    dutyCycle1: game_upcounter
    generic map(
       period => (10000),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--                   period => (2),   -- for sim testing
       WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
    PORT MAP (
       clk    => clk,
       reset  => DC1_reset,
       enable => DC1_enable,
       zero   => DC1_zero, -- this is a 1 Hz clock signal
       value  => open  -- Leave open since we won't display this value
    );
    
    dutyCycle2: game_upcounter
    generic map(
           period => (32000),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--           period => (4),   -- for sim testing
       WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
      )
    PORT MAP (
       clk    => clk,
       reset  => DC2_reset,
       enable => DC2_enable,
       zero   => DC2_zero, -- this is a 1 Hz clock signal
       value  => open  -- Leave open since we won't display this value
    );
     
    noteChanger: game_upcounter
        generic map(
           period => (10000000),   -- divide by 10_000_000 to divide 100 MHz down to 10 Hz 
--                       period => (20),   -- for sim testing
           WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
          )
        PORT MAP (
           clk    => clk,
           reset  => reset_i,
           enable => enable_i,
           zero   => noteChange, -- this is a 1 Hz clock signal
           value  => open  -- Leave open since we won't display this value
        );
    

    
output: process(clk)
begin            
    if(rising_edge(clk)) then
        if(noteChange = '1') then
            counter <= counter + "0001";            
        end if;
        if(reset_used = '0' and (reset = '1')) then
           enable_i <= '1';
           reset_used <= '1';
           counter <= "0000";
           note_reset <= '0';
           reset_i <= '1';           
           DC1_reset <= '0';
           DC2_reset <= '0';
           
        elsif((counter < "0100" or counter = "0110") and reset_used = '1') then --D
            reset_i <= '0';
            D_enable <= '1';
            Bb_enable <= '0';                
            C_enable <= '0';
            DC1_enable <= '1';
            DC2_enable <= '0';                
            DC1_reset <= D_zero;
            if( D_zero = '1') then
                buzzer_up <= '1';
                buzzer_down <= '0';                    
            elsif( DC1_zero = '1') then
                buzzer_down <= '1';    
            end if;
        elsif(counter = "0100") then
            D_enable <= '0';
            Bb_enable <= '1';               
            C_enable <= '0';
            DC1_reset <= Bb_zero;
            if( Bb_zero = '1') then
                buzzer_up <= '1';
                buzzer_down <= '0';                    
            elsif( DC1_zero = '1') then
                buzzer_down <= '1';    
            end if;
        elsif(counter = "0101" or counter = "0111") then
            D_enable <= '0';
            C_enable <= '1';
            Bb_enable <= '0';
            DC1_reset <= C_zero;
            if( C_zero = '1') then
                buzzer_up <= '1';
                buzzer_down <= '0';                    
            elsif( DC1_zero = '1') then
                buzzer_down <= '1';    
            end if;
        elsif(counter = "1000") then
            D_enable <= '1';
            Bb_enable <= '0';                
            C_enable <= '0';                
            DC2_reset <= D_zero;
            DC1_enable <= '0';
            DC2_enable <= '1';
            if( D_zero = '1') then
                buzzer_up <= '1';
                buzzer_down <= '0';                    
            elsif( DC2_zero = '1') then
                buzzer_down <= '1';    
            end if;
        else
            enable_i <= '0';
            note_reset <= '1';
            reset_i <= '1';
            reset_used <= '0';
            DC1_reset <= '1';
            DC2_reset <= '1';
        end if;
    end if;
end process;

buzzer_out <= buzzer_up xor buzzer_down;
b_en <= Bb_enable;
c_en <= C_enable;
d_en <= D_enable;
counter_out <= counter;
end Behavioral;
