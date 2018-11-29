----------------------------------------------------------------------------------
-- COMPARADOR DE 16 BITS
-- Los comparadores son circuitos combinacionales que comparan los valores binarios
-- de sus dos entradas de 16 bits (P y Q) y generan una salida P>Q activa a nivel alto
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comp_16 is
	port ( 	P : in STD_LOGIC_VECTOR (15 downto 0);	-- entrada a comparar
		Q : in STD_LOGIC_VECTOR (15 downto 0); 	-- senal de referencia
		P_GT_Q : out STD_LOGIC);		-- resultado de la comparacion, activa a nivel alto
end comp_16;

architecture Behavioral of comp_16 is
begin
	 P_GT_Q <= '1' when P > Q else -- Asignacion de la salida en funcion del resultado de la comparacion
		   '0' when P <= Q;
end Behavioral;
