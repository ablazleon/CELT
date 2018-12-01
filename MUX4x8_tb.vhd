--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:35:41 10/11/2018
-- Design Name:   
-- Module Name:   C:/Users/ablaz/Documents/Celt/Practica/MUX4x8_tb.vhd
-- Project Name:  Practica
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX4x8
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
-- TESTBENCH MULTIPLEXOR DE 4 ENTRADAS DE 8 BITS
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MUX4x8_tb IS
END MUX4x8_tb;
 
ARCHITECTURE behavior OF MUX4x8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX4x8
    PORT(
         E0 : IN  std_logic_vector(7 downto 0);
         E1 : IN  std_logic_vector(7 downto 0);
         E2 : IN  std_logic_vector(7 downto 0);
         E3 : IN  std_logic_vector(7 downto 0);
         Y : OUT  std_logic_vector(7 downto 0);
         S : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal E0 : std_logic_vector(7 downto 0) := (others => '0');
   signal E1 : std_logic_vector(7 downto 0) := (others => '0');
   signal E2 : std_logic_vector(7 downto 0) := (others => '0');
   signal E3 : std_logic_vector(7 downto 0) := (others => '0');
   signal S : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX4x8 PORT MAP (
          E0 => E0,
          E1 => E1,
          E2 => E2,
          E3 => E3,
          Y => Y,
          S => S
        );


   -- Stimulus process
   stim_proc: process
   begin	
		E0 <= "00000000";
		E1 <= "00000001";
		E2 <= "00000010";
		E3 <= "00000011";
		s<="00";
      -- hold first state for 20 ns.
      wait for 20 ns;
			s<="01";
			wait for 20 ns;
			s<="10";
			wait for 20 ns;
			s<="11";

      wait;
   end process;

END;
