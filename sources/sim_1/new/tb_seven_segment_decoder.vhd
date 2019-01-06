LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_seven_segment_decoder IS
END tb_seven_segment_decoder;
 
ARCHITECTURE behavior OF tb_seven_segment_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_segment_decoder
    PORT(
         CA    : OUT STD_LOGIC;
         CB    : OUT STD_LOGIC;
         CC    : OUT STD_LOGIC;
         CD    : OUT STD_LOGIC;
         CE    : OUT STD_LOGIC;
         CF    : OUT STD_LOGIC;
         CG    : OUT STD_LOGIC;
         DP    : OUT STD_LOGIC;
         dp_in : IN  STD_LOGIC;
         data  : IN  STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;   

   --Inputs
   signal dp_in_i : STD_LOGIC := '0';
   signal data  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    --Outputs
   signal CA_i : STD_LOGIC;
   signal CB_i : STD_LOGIC;
   signal CC_i : STD_LOGIC;
   signal CD_i : STD_LOGIC;
   signal CE_i : STD_LOGIC;
   signal CF_i : STD_LOGIC;
   signal CG_i : STD_LOGIC;
   signal DP_i : STD_LOGIC;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: seven_segment_decoder 
   PORT MAP (
              CA    => CA_i,
              CB    => CB_i,
              CC    => CC_i,
              CD    => CD_i,
              CE    => CE_i,
              CF    => CF_i,
              CG    => CG_i,
              DP    => DP_i,
              dp_in => dp_in_i,
              data  => data
            );

   -- Stimulus process
   stim_proc: process
   begin      
      dp_in_i <= '0';
      wait for 100 ns;
      data <= "0000"; -- 0
      wait for 50 ns;
      data <= "0001"; -- 1
      wait for 50 ns; 
      data <= "0010"; -- 2
      wait for 50 ns;
      data <= "0011"; -- 3
      wait for 50 ns;
      data <= "0100"; -- 4
      wait for 50 ns;
      data <= "0101"; -- 5
      wait for 50 ns;
      data <= "0110"; -- 6
      wait for 50 ns;
      data <= "0111"; -- 7
      wait for 50 ns;
      data <= "1000"; -- 8
      wait for 50 ns;
      data <= "1001"; -- 9
      wait for 50 ns;
      data <= "1010"; -- A
      wait for 50 ns;
      data <= "1011"; -- B
      wait for 50 ns;
      data <= "1100"; -- C
      wait for 50 ns;
      data <= "1101"; -- D
      wait for 50 ns;
      data <= "1111"; -- F
      wait for 50 ns;
      dp_in_i <= '1';
      wait for 50 ns;
      wait;
   end process;

END;