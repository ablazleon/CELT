--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:25:56 10/11/2018
-- Design Name:   
-- Module Name:   C:/Users/hengx/Documents/curso18-19/CELT/xilinxWorkspace/refresco/refresco_tb.vhd
-- Project Name:  refresco
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: refresco
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY refresco_tb IS
END refresco_tb;
 
ARCHITECTURE behavior OF refresco_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT refresco
    PORT(
         CLK_1ms : IN  std_logic;
         S : OUT  std_logic_vector(1 downto 0);
         AN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_1ms : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(1 downto 0);
   signal AN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_1ms_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: refresco PORT MAP (
          CLK_1ms => CLK_1ms,
          S => S,
          AN => AN
        );

   -- Clock process definitions
   CLK_1ms_process :process
   begin
		CLK_1ms <= '0';
		wait for CLK_1ms_period/2;
		CLK_1ms <= '1';
		wait for CLK_1ms_period/2;
   end process;
	

END;
