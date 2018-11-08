-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use IEEE.STD_LOGIC_ARITH.ALL;
  USE ieee.std_logic_unsigned.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT comp_16
          PORT(
                  P : in STD_LOGIC_VECTOR (15 downto 0); 
						Q : in STD_LOGIC_VECTOR (15 downto 0);
						P_GT_Q : out STD_LOGIC
                  );
          END COMPONENT;

          SIGNAL in_P :  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
          SIGNAL in_Q :  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
			 SIGNAL s_P_GT_Q : STD_LOGIC;
          

  BEGIN

  -- Component Instantiation
          uut: comp_16 PORT MAP(
                  in_P => P,
                  in_Q => Q,
						P_GT_Q => s_P_GT_Q
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here
		  in_Q <= in_Q + "10";
		  
		  wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here
		  in_p <= in_P + "10";
		  
		  wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here
		  in_Q <= in_Q + "10";
		  
		  wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here
		  in_P <= in_P + "10";

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
