
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_clock_divider_2 IS
END tb_clock_divider_2;
 
ARCHITECTURE behavior OF tb_clock_divider_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_divider_2
    PORT(
            clk             : IN  STD_LOGIC;
            reset           : IN  STD_LOGIC;
            enable          : in  STD_LOGIC;
            ts_sec_dig1     : in STD_LOGIC_VECTOR(3 downto 0);
            ts_sec_dig2     : in STD_LOGIC_VECTOR(3 downto 0);
            ts_min_dig1     : in STD_LOGIC_VECTOR(3 downto 0);
            ts_min_dig2     : in STD_LOGIC_VECTOR(3 downto 0);
            sec_dig1        : OUT STD_LOGIC_VECTOR(3 downto 0);
            sec_dig2        : OUT STD_LOGIC_VECTOR(3 downto 0);
            min_dig1        : OUT STD_LOGIC_VECTOR(3 downto 0);
            min_dig2        : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk    : STD_LOGIC := '0';
   signal reset  : STD_LOGIC := '0';
   signal enable : STD_LOGIC := '0';
   signal ts_sec_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal ts_sec_dig2 : STD_LOGIC_VECTOR(3 downto 0);
   signal ts_min_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal ts_min_dig2 : STD_LOGIC_VECTOR(3 downto 0);
   
    --Outputs
   signal sec_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal sec_dig2 : STD_LOGIC_VECTOR(3 downto 0);
   signal min_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal min_dig2 : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: clock_divider_2
   PORT MAP (
              clk      => clk,
              reset    => reset,
              enable   => enable,
              ts_sec_dig1 => ts_sec_dig1,
              ts_sec_dig2 => ts_sec_dig2,
              ts_min_dig1 => ts_min_dig1,
              ts_min_dig2 => ts_min_dig2,
              sec_dig1 => sec_dig1,
              sec_dig2 => sec_dig2,
              min_dig1 => min_dig1,
              min_dig2 => min_dig2
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      ts_sec_dig1 <= "0110";
      ts_sec_dig2 <= "0111";
      ts_min_dig1 <= "0101";
      ts_min_dig2 <= "1001";
      reset <= '1';
      wait for 100 ns;   
      reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      wait for clk_period*10;
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      reset <= '1';
      wait for 100 ns;   
      reset <= '0';
      wait for clk_period*10;
      
      ts_sec_dig1 <= "0100";
      ts_sec_dig2 <= "0101";
      ts_min_dig1 <= "0100";
      ts_min_dig2 <= "0001";
      wait for clk_period*10;
      reset <= '1';
      wait for 100 ns;   
      reset <= '0';
      wait;
   end process;

END;
