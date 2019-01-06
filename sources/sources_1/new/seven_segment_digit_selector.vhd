library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_segment_digit_selector is
    PORT ( clk          : in  STD_LOGIC;
           digit_select : out STD_LOGIC_VECTOR (3 downto 0);
           an_outputs   : out STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
		 );
end seven_segment_digit_selector;

architecture Behavioral of seven_segment_digit_selector is
   signal d, q  : STD_LOGIC_VECTOR(3 downto 0);
   signal count : STD_LOGIC_VECTOR(16 downto 0);
BEGIN
   
   one_kHz : process(reset, clk)
   begin
       if (reset = '1') then
          count <= (others => '0');
       elsif (rising_edge(clk)) then
          count <= count + '1';
       end if;
   end process;
   
   dffs: process(reset, clk)
   begin
   
      if (reset = '1') then
         -- Fill in the reset state values for q
         q(0) <= '1';
         q(1) <= '1';
         q(2) <= '1';
         q(3) <= '1';
      elsif (rising_edge(clk)) then
         if (count = 0) then -- have cycled 100MHz / (2^17-1) ~ 762 Hz (this is how quickly we strobe through the digits of the 7-segment display
            -- Propagate signals through the DFF
            -- From input to output
            if ((q(0) = '1') and (q(1) = '1')) then -- corrects from reset state, or some faulty states
               q(0) <= '1';
               q(1) <= '0';
               q(2) <= '0';
               q(3) <= '0';
            else 
               q(0) <= d(0); -- this is just ordinary flip flop behavior 
               q(1) <= d(1);
               q(2) <= d(2);
               q(3) <= d(3);
            end if; 
         end if;
      end if;
   end process;
   
   -- Connect the DFFs into a chain/loop
   -- This means output of one needs to connect to input of the next one
   d(0) <= q(3);
   d(1) <= q(0);
   d(2) <= q(1);
   d(3) <= q(2);
   
   digit_select(0) <= q(0);
   digit_select(1) <= q(1);
   digit_select(2) <= q(2);
   digit_select(3) <= q(3);

   -- Copying q to the LED anodes, invert because active low (turning on PNP transitor on Basys3 board to drive LED's anodes)
   an_outputs(0) <= not q(0);
   an_outputs(1) <= not q(1);
   an_outputs(2) <= not q(2);
   an_outputs(3) <= not q(3);
   
END Behavioral;
