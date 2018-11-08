----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:56:26 10/25/2018 
-- Design Name: 
-- Module Name:    detector_franco - Behavioral 
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

entity detector_flanco is
    Port ( CLK_1ms : in  STD_LOGIC;
           LIN : in  STD_LOGIC;
           VALOR : out  STD_LOGIC);
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
	VALOR<=s_valor;
end Behavioral;

