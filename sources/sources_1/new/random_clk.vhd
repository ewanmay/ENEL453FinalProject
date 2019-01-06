library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 entity random_clk is
   port (
     enable        : in STD_LOGIC;
     clk           : in  std_logic;
     enable_out    : out std_logic;
     reset         : in STD_LOGIC
   );
 end entity;
 
 architecture behavioral of random_clk is
  signal hundredhertz : STD_LOGIC;
  signal kilohertz, tenths, hundredths, thousandths, second_top: STD_LOGIC;
  signal ten_i : STD_LOGIC_VECTOR(3 downto 0);
  signal hun_i : STD_LOGIC_VECTOR(3 downto 0);
  signal tho_i    : STD_LOGIC_VECTOR(3 downto 0);
  signal sec_i   : STD_LOGIC_VECTOR(3 downto 0);
  signal enable_i : STD_LOGIC:= '0';
  signal en_allow : STD_LOGIC:= '1';
  signal random_clk_i: STD_LOGIC_VECTOR(7 downto 0);
  signal hun_start, ten_start: STD_LOGIC_VECTOR(3 downto 0);
  
  component game_downcounter is
    Generic ( period : integer:= 4;
              WIDTH  : integer:= 3
            );
       PORT (  clk    : in  STD_LOGIC;
               reset  : in  STD_LOGIC;
               enable : in  STD_LOGIC;
               first_value : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
               zero   : out STD_LOGIC;
               value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
            );
 end component;
 
 component randomizer is 
    port (
      clk           : in  std_logic;
      rstb          : in  std_logic;
      sync_reset    : in  std_logic;
      seed          : in  std_logic_vector (7 downto 0);
      en            : in  std_logic:= '1';
      lfsr_out      : out std_logic_vector (7 downto 0)
    );
  end component;
 
 BEGIN
    randomClk: randomizer
    PORT MAP(
     clk         =>  clk,
     rstb        =>  '1',
     sync_reset  =>  reset,
     seed        =>  "10111001",      
     en          => '1',         
     lfsr_out    =>  random_clk_i   
    ); 
     
    KHzClock: game_downcounter
    generic map(
                period => (100000),   -- divide by 100_000 to divide 100 MHz down to 1 KHz 
--                period => (10),   -- for sim testing
                WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => enable_i,
                zero   => kilohertz, -- this is a 1 Hz clock signal
                value  => open,  -- Leave open since we won't display this value
 --               first_value => "0101111101011110000100000000"
                first_value => "0000000000000000000000001010"
             );
    
    thousandthsClock: game_downcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => kilohertz,
                zero   => thousandths,
                value  => tho_i, -- binary value of seconds we decode to drive the 7-segment display    
                first_value => "0000"  
             );
    
  hundredthsClock: game_downcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 5 -> that's 6 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => thousandths,
                zero   => hundredths,
                value  => hun_i, -- binary value of seconds we decode to drive the 7-segment display
                first_value => "0000"         
             );
             
 tenthsClock: game_downcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => hundredths,
                zero   => tenths,
                value  => ten_i, -- binary value of seconds we decode to drive the 7-segment display
                first_value => hun_start         
             );
                         
  secondClock: game_downcounter
    generic map(
                period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
                WIDTH  => 4
               )
    PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => tenths,
                zero   => second_top,
                value  => sec_i, -- binary value of seconds we decode to drive the 7-segment display
                first_value =>  ten_start        
             );
             
             
   ending : process (second_top, clk, reset, tenths, thousandths, tenths, hundredths, enable)
   begin   
         if(rising_edge(clk)) then
             if(reset = '1') then
                 en_allow <= '1';
                 enable_out <= '0';
             elsif(
             sec_i = "0000" AND
             ten_i = "0000" AND
             tho_i = "0000" AND
             hun_i = "0000" AND        
             enable = '1'
             ) then
                 en_allow <= '0';
                 enable_out <='1';
             end if;
         end if;
   end process;
   hun_start <= random_clk_i(7 downto 4);
   ten_start <= random_clk_i(3 downto 0);
   enable_i <= en_allow AND enable;
 END Behavioral;