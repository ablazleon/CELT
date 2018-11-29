----------------------------------------------------------------------------------
-- AUTOMATA  DE MEDIDA DE DURACION
-- Este autómata toma como entrada la salida del detector de flancos y genera varias 
-- salidas: DURACIÓN (registro de 16 bits que almacena el número de ciclos de reloj 
-- contados), DATO (valor binario que indica si se trata de un intervalo a 0 o a 1) 
-- y VALID (señal de validación que indica que el intervalo en cuestión ha terminado 
-- (al llegar un flanco) y por lo tanto que la cuenta ha terminado. Esta señal dura 
-- un ciclo de reloj).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
	VALID <= '1' when (ST = VALID_CERO or ST = VALID_UNO or ST = VALID_FIN) -- Asignacion de salida en funcion del estado
				else '0';
	DATO <=  '1' when (ST = UNO or ST = ALM_UNO or ST = VALID_UNO)		-- Asignacion de salida en funcion del estado
				else '0';
	DURACION <= reg;							-- Asignacion de duracion medida

end a_aut_duracion;


