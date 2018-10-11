-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT mux8
          PORT(
					  E0 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E0
					  E1 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E1
					  E2 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E2
					  E3 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E3
					  Y  : out  STD_LOGIC_VECTOR (7 downto 0);  -- salida Y
					  S  : in   STD_LOGIC_VECTOR (1 downto 0)); -- entradas de control
          END COMPONENT;

          SIGNAL input1 :  std_logic;
          SIGNAL input2 :  std_logic_vector(3 downto 0);
			 SIGNAL input3 : 
          

  BEGIN

  -- Component Instantiation
          uut: <component name> PORT MAP(
                  <port1> => <signal1>,
                  <port3> => <signal2>
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes

        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
