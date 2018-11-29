----------------------------------------------------------------------------------
-- REFRESCO
-- Este bloque controla la visualización sucesiva de cada carácter en cada display. 
-- Para ello va alternando las entradas del multiplexor con la activación del display
-- correspondiente. Como entrada toma la señal de reloj de 1 KHz y como salidas: 
-- la entrada de selección del multiplexor y las entradas de activación de los displays.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
	Port ( 	CLK_1ms : in STD_LOGIC; 		-- reloj de refresco
		S : out STD_LOGIC_VECTOR (1 downto 0); 	-- Control para el mux
		AN : out STD_LOGIC_VECTOR (3 downto 0));-- Control displays
end refresco;

architecture Behavioral of refresco is

signal contador: STD_LOGIC_VECTOR(1 downto 0):= "00";
signal salida_s: STD_LOGIC_VECTOR(1 downto 0):= "00";
signal salida_an: STD_LOGIC_VECTOR (3 downto 0):= "0000";

begin
process (CLK_1ms)
begin
-- Se observa que para que el refresco sea correcto con la Basys2, debe seguir la forma 
-- especificada en la pagina 17 del manual de la Basys2.
	
if CLK_1ms'event and CLK_1ms = '1' then
	contador <= contador + '1';
	if contador = 0 then
		salida_an <= "0111";
		salida_s <= "00";
	elsif contador = 1 then
		salida_an <= "1011";
		salida_s <= "01";
	elsif contador = 2 then
		salida_an <= "1101";
		salida_s <= "10";
	else
		salida_an <= "1110";
		salida_s <= "11";
	end if;
	
end if;
end process;

AN <= salida_an;
s <= salida_s;

end Behavioral;
