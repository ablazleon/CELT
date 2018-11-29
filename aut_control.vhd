----------------------------------------------------------------------------------
-- AUTOMATA DE CONTROL
-- Este autómata es el encargado de componer el código y validar su visualización 
-- en el display cuando se recibe un ESPACIO. Su organización en estados responde 
-- al diagrama.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity aut_control is
	Port (	CLK_1ms		: in STD_LOGIC; 			-- reloj de 1 khz
		VALID		: in STD_LOGIC; 			-- entrada de dato
		DATO		: in STD_LOGIC; 			-- dato (0 o 1)
		C0		: in STD_LOGIC; 			-- resultado comparador de ceros
		C1		: in STD_LOGIC;				-- resultado comparador de unos
		CODIGO		: out STD_LOGIC_VECTOR (7 downto 0); 	-- codigo morse obtenido
		VALID_DISP	: out STD_LOGIC);			-- validacion del display
end aut_control;

architecture a_aut_control of aut_control is

type STATE_TYPE is (ESPACIO, RESET, SIMBOLO, ESPERA); 	-- Los estados del autómata
signal ST: STATE_TYPE := RESET;				-- Estado inicial del autómata

signal s_ncod : STD_LOGIC_VECTOR (2 downto 0):="000";
signal s_cod  : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal n 	  : INTEGER range 0 to 4;

begin

process (CLK_1ms)
	begin
	if (CLK_1ms'event and CLK_1ms='1') then
		case ST is
			when SIMBOLO =>
				s_ncod<=s_ncod+1;
				s_cod(n)<=C1;		-- el resultado del comparador indica punto o raya
				n<=n-1;
				ST<=ESPERA;
			
			--Estado ESPERA
			when ESPERA =>
				-- Decidir el siguiente estado
				if (VALID='1' and dato='1') then
					ST<=SIMBOLO;
				elsif (VALID='1' and dato='0' and C0='1') then
					ST<=ESPACIO;
				else
					ST<=ESPERA;
				end if;
			
			--Estado ESPACIO
			when ESPACIO =>
				ST<=RESET;
			
			
			when RESET =>
				n <= 4;
				s_ncod<="000";
				s_cod<="00000";
				if (VALID='1' and dato='1') then
					ST<=SIMBOLO;
				else
					ST<=RESET;
				end if;
				
		end case;
	end if;
end process;

VALID_DISP<= '1' when ST = ESPACIO 	-- Asignacion de las salidas en funcion del estado
		else '0';
CODIGO(4 downto 0)<=s_cod;		-- Asignacion del codigo morse
CODIGO(7 downto 5)<=s_ncod;

end a_aut_control;

