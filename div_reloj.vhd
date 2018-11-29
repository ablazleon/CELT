----------------------------------------------------------------------------------
-- DIVISOR DE RELOJ
-- Como toda la lógica interna del receptor estará sincronizada con un reloj de
-- 1 KHz de frecuencia, es necesario desarrollar un divisor de frecuencia que obtenga
-- un reloj de 1 KHz a partir del reloj de la FPGA (50 MHz).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DIV_RELOJ is
    Port ( CLK : in  STD_LOGIC;   	-- Entrada reloj de la FPGA 50 MHz
           CLK_1ms : out  STD_LOGIC); 	-- salida reloj a 1kHz
end DIV_RELOJ;

architecture a_div_reloj of DIV_RELOJ is
signal contador : STD_LOGIC_VECTOR (15 downto 0);
signal flag : STD_LOGIC;
begin
	PROC_CONT : process (CLK)
		begin
		if CLK'event and CLK='1' then
			contador<=contador + '1';
			if contador = 25000 then 
			-- el reloj tiene un periodo de 20 ns (50 MHz)								
			-- se quiere una seÃ±al de reloj de 1kHz, con T=1ms
				flag<=not flag; 			
				-- tras 50k cuentas => 20*10-9*50*10^3 =1000*10^-6 = 1ms de periodo
				contador<=(others=>'0');
			end if;
		end if;
		end process;
			
	CLK_1ms<=flag;
end a_div_reloj;
