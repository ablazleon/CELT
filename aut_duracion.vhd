----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:03 11/08/2018 
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
			DURACION : out STD_LOGIC_VECTOR (15 downto 0)); 
			-- salida de duracion del dato

end aut_duracion;

architecture a_aut_duracion of aut_duracion is

type STATE_TYPE is (CERO, ALM_CERO, VALID_CERO, UNO, ALM_UNO, VALID_UNO, VALID_FIN);
signal ST : STATE_TYPE := CERO;
signal cont : STD_LOGIC_VECTOR (15 downto 0) := "000000000000000"

begin

process (CLK_1ms) -- autómata de Moore: el estado depende de las entradas
 begin
 if (CLK_1ms'event and CLK_1ms='1') then
  case ST is
		when CERO => 
			cont <= cont + 1;
			if ( ENTRADA = '0') then 
				ST <= CERO;
			if 
			else
				ST <= ALM_CERO;
			end if;
		when ALM_CERO
			if 
		when VALID_CERO
		when UNO
		when ALM_UNO
		when VALID_UNO
		when VALID_FIN
			
			
	end case;
end if;
end process;

-- Parte Combinacional

VALID <= '1' when (ST = VALID_CERO or S = VALID_UNO or ST = VALID_FIN) else '0';
DATO <=  '1' when (ST = UNO or ALM_UNO or VALID_UNO) else '0'
DURACION <= 

end a_aut_duracion;

