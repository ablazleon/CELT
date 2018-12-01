--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:13:06 11/15/2018
-- Design Name:   
-- Module Name:   C:/Users/hengx/Documents/curso18-19/CELT/xilinxWorkspace/COMPARADOR_2/comp_16_tb.vhd
-- Project Name:  COMPARADOR_2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comp_16
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
-- TESTBENCH COMPARADOR DE 16
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY comp_16_tb IS
END comp_16_tb;
 
ARCHITECTURE behavior OF comp_16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comp_16
    PORT(
         P : IN  std_logic_vector(15 downto 0);
         Q : IN  std_logic_vector(15 downto 0);
         P_GT_Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal P : std_logic_vector(15 downto 0) := (others => '0');
   signal Q : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal P_GT_Q : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comp_16 PORT MAP (
          P => P,
          Q => Q,
          P_GT_Q => P_GT_Q
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		P <= "0000000000000001";
      wait for 100 ns;
		Q <= "0000000000000010";
		wait for 100 ns;
		P <= "0000000000000011";
		wait for 100 ns;
		Q <= "0000000000000100";
		wait for 100 ns;
		P <= "0000000000000101";
		wait for 100 ns;
		Q <= "0000000000000110";

      wait;
   end process;

END;
