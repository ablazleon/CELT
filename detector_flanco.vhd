----------------------------------------------------------------------------------
-- DETECTOR DE FLANCO
-- El detector de flancos toma como entrada la línea de datos (LIN) y el reloj, 
-- y genera una salida (VALOR) 0 o 1 dependiendo de si el flanco que llega es de
-- bajada o de subida respectivamente. Para ello muestrea constantemente la señal 
-- de entrada acumulando las muestras dentro de un registro de desplazamiento en 
-- sincronía con el reloj de 1 KHz de modo que siempre haya 20 bits. Además calcula 
-- constantemente la suma de los 20 bits que están dentro del registro. Si la suma 
-- supera el umbral de 15 interpreta que llega un flanco de subida y la salida (VALOR)
-- toma el valor 1, si la suma pasa por debajo del umbral de 5 interpreta que llega 
-- un flanco de bajada y la salida (VALOR) toma el valor „0‟. En otro caso la salida 
-- no cambia y mantiene su valor. Este detector se comporta como un autómata que implementa 
-- un comparador con histéresis. El diagrama de estados correspondiente a este autómata, 
-- así como la curva de histéresis se muestran en la Figura 22. Este procedimiento 
-- permite ignorar los flancos correspondientes a glitches o los múltiples flancos en
-- el caso de que aparezcan rebotes.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity detector_flanco is
    Port ( CLK_1ms : in  STD_LOGIC;	-- reloj de 1khz
           LIN : in  STD_LOGIC;		-- entrada de muestreo
           VALOR : out  STD_LOGIC);	-- duracion de la entrada
end detector_flanco;

architecture Behavioral of detector_flanco is

constant UMBRAL0 : STD_LOGIC_VECTOR (7 downto 0) := "00000101"; --5
constant UMBRAL1 : STD_LOGIC_VECTOR (7 downto 0) := "00001111"; --15

signal reg_desp : STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
signal suma : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal s_valor : STD_LOGIC := '0';



begin

	process (CLK_1ms)
		variable count : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
		begin
			if (CLK_1ms'event and CLK_1ms='1') then
				
				-- codigo a desarrollar---------------------------------------
				-- Sumamos la nueva entrada
				count := count+ LIN;
				-- Restamos el bit que sale
				count := count-reg_desp(19);
				suma <= count;
				-- Desplazamos los bits uno a la izquierda
				reg_desp(19 downto 1) <= reg_desp(18 downto 0);
				-- Guardamos el nuevo bit de la entrada en el primer bit del registro
				reg_desp(0) <= LIN;
				
				if (suma > UMBRAL1) then
					s_valor <= '1';
				elsif (suma < UMBRAL0) then
					s_valor <= '0';
				end if;
				-------------------------------------------------------------
				
			end if;
	end process;
	VALOR<=s_valor; --Asignacion de la salida
end Behavioral;

