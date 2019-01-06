----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2018 02:09:15 PM
-- Design Name: 
-- Module Name: tb_digit_multiplexor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_digit_multiplexor is
end tb_digit_multiplexor;

architecture Behavioral of tb_digit_multiplexor is

    COMPONENT digit_multiplexor
    PORT ( 
          sec_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          selector   : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
        
    --IN
    signal sec_dig1   :  STD_LOGIC_VECTOR(3 downto 0);
    signal sec_dig2   :  STD_LOGIC_VECTOR(3 downto 0);
    signal min_dig1   :  STD_LOGIC_VECTOR(3 downto 0);
    signal min_dig2   :  STD_LOGIC_VECTOR(3 downto 0);
    signal selector   :  STD_LOGIC_VECTOR(3 downto 0);    
        
    --OUT
    signal time_digit : STD_LOGIC_VECTOR(3 downto 0);
    
    BEGIN    
    uut: digit_multiplexor
    PORT MAP (
                sec_dig1 => sec_dig1,
                sec_dig2 => sec_dig2,
                min_dig1 => min_dig1,
                min_dig2 => min_dig2,
                selector => selector,
                time_digit => time_digit
                );
                    
        
    stim_proc: process
    begin    
        sec_dig1 <= "1011";
        sec_dig2 <= "1101";
        min_dig1 <= "1010";
        min_dig2 <= "1000";        
        wait for 100ns;         
        selector <= "0001";
        wait for 100ns;
        selector <= "0010";
        wait for 100ns;
        selector <= "0100";
        wait for 100ns;
        selector <= "1000";
        wait for 100ns;    
    end process;
    
    END;
    
    











