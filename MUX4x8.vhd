----------------------------------------------------------------------------------
-- MULTIPLEXOR DE 4 ENTRADAS DE 8 BITS
-- un mux de 8 que varíe las cuatro entradas en el display, para representar 
-- la rotación en el display, siguiendo la descripción de la entity que aparece en 
-- el enunciado. En el tb se comprueba que siendo las señales de entrada “0”, “1”, 
-- “2” y “3” en binario, dependiendo de s, se muestra una u otra.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX4x8 is
    Port ( E0 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E0
           E1 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E1
           E2 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E2
           E3 : in   STD_LOGIC_VECTOR (7 downto 0);  -- entrada E3
           Y  : out  STD_LOGIC_VECTOR (7 downto 0);  -- salida Y
           S  : in   STD_LOGIC_VECTOR (1 downto 0)); -- entradas de control
    
end MUX4x8;

architecture a_MUX4x8  of MUX4x8 is
begin

Y <= E0 when S="00" else  -- se selecciona la salida en funcion de las entradas
     E1 when S="01" else  -- de control
     E2 when S="10" else
     E3 when S="11";	  

end a_MUX4x8 ;
