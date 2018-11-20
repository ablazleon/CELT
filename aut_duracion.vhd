----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:04:41 11/20/2018 
-- Design Name: 
-- Module Name:    aut_duracion - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aut_duracion is
	Port( CLK_1ms  : in STD_LOGIC;    -- reloj de 1ms
				ENTRADA  : in STD_LOGIC;    -- línea de entrada de datos
				VALID    : out STD_LOGIC;   -- salida de validación de dato
				DATO	   : out STD_LOGIC;	-- salida de dato ( 0 o 1)
				DURACION : out STD_LOGIC_VECTOR (15 downto 0)); -- salida de duracion del dato
end aut_duracion;

architecture a_aut_duracion of aut_duracion is
	
	-- Declaracion de los estados de la maquina
	type STATE_TYPE is (CERO, ALM_CERO, VALID_CERO, UNO, ALM_UNO, VALID_UNO, VALID_FIN);
	
	-- Declaracion de las señales necesarias
	signal ST : STATE_TYPE := CERO;
	signal cont : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
	signal reg : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";

	begin

	process (CLK_1ms) -- autómata de Moore: el estado depende de las entradas
	 begin
	 if (CLK_1ms'event and CLK_1ms='1') then
	  case ST is
			-- Caso cuando el estado es cero
			when CERO => 
				cont <= cont + 1;
				if ( ENTRADA = '1') then 
					ST <= ALM_CERO;
				elsif cont > 600 then
					ST <= VALID_FIN;
				else
					ST <= CERO;
				end if;
			
			-- ALM_CERO
			when ALM_CERO =>
				reg <= cont;
				cont <= (others => '0');
				ST <= VALID_CERO;
			
			-- VALID_CERO
			when VALID_CERO =>
				ST <= UNO;
			
			--	UNO
			when UNO =>
				cont <= cont + 1;
				if (ENTRADA = '1') then
					ST <= UNO;
				else
					ST <= ALM_UNO;
				end if;
			
			-- ALM_UNO
			when ALM_UNO =>
				reg <= cont;
				cont <= (others => '0');
				ST <= VALID_UNO;
			
			-- VALID_UNO
			when VALID_UNO =>
				ST <= CERO;
			
			-- VALID_FIN
			when VALID_FIN =>
				reg <= cont;
				cont <= (others => '0');
				ST <= CERO;
		end case;
	end if;
	end process;
	
	-- Parte Combinacional
	
	VALID <= '1' when (ST = VALID_CERO or ST = VALID_UNO or ST = VALID_FIN)
				else '0';
	DATO <=  '1' when (ST = UNO or ST = ALM_UNO or ST = VALID_UNO)
				else '0';
	DURACION <= reg;

end a_aut_duracion;


