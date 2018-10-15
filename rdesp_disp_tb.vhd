--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:49:10 10/12/2018
-- Design Name:   
-- Module Name:   C:/Users/hengx/Documents/curso18-19/CELT/xilinxWorkspace/regDes8/regDesp8_tb.vhd
-- Project Name:  regDes8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: regDesp8
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
 
ENTITY regDesp8_tb IS
END regDesp8_tb;
 
ARCHITECTURE behavior OF regDesp8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT regDesp8
    PORT(
         CLK : IN  std_logic;
         E : IN  std_logic_vector(7 downto 0);
         EN : IN  std_logic;
         Q0 : OUT  std_logic_vector(7 downto 0);
         Q1 : OUT  std_logic_vector(7 downto 0);
         Q2 : OUT  std_logic_vector(7 downto 0);
         Q3 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal E : std_logic_vector(7 downto 0) := (others => '0');
   signal EN : std_logic := '0';

 	--Outputs
   signal Q0 : std_logic_vector(7 downto 0);
   signal Q1 : std_logic_vector(7 downto 0);
   signal Q2 : std_logic_vector(7 downto 0);
   signal Q3 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: regDesp8 PORT MAP (
          CLK => CLK,
          E => E,
          EN => EN,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		E <= "00000001";
		EN <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;
		E <= "00000001";
		EN <= '1';
		
      wait for CLK_period;
		E <= "00000010";
		
		wait for CLK_period;
		E <= "00000100";
		
		wait for CLK_period;
		E <= "00001000";
		
		wait for CLK_period;
		E <= "00010000";
		
		wait for CLK_period;
		E <= "00100000";
		
		wait for CLK_period;
		E <= "01000000";
		
		wait for CLK_period;
		E <= "10000000";
		
      wait;
   end process;

END;
