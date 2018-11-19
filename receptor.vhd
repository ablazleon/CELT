----------------------------------------------------------------------------------
-- Company: UPM
-- Engineer: Hengxuan Y.
-- 
-- Create Date:    21:06:03 11/18/2018 
-- Design Name: 
-- Module Name:    receptor - Behavioral 
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

entity receptor is
	Port( CLK	: in STD_LOGIC; 								-- reloj de la FPGA
			LIN	: in STD_LOGIC; 								-- Línea de entrada de datos
			SEG7	: out STD_LOGIC_VECTOR (0 to 6);			-- Salida para los displays
			AN 	: out STD_LOGIC_VECTOR (3 downto 0));	-- Activacion individual
end receptor;

architecture a_receptor of receptor is

constant UMBRAL0: STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral ceros
constant UMBRAL1: STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral unos

component div_reloj
	Port( CLK : in STD_LOGIC;
			CLK_1ms : out STD_LOGIC);
end component;

component detector_flanco
	Port(CLK_1ms : in STD_LOGIC; 		-- reloj
		  LIN		 : in STD_LOGIC; 		-- Línea de datos
		  VALOR	 : out STD_LOGIC); 	-- Valor detectado en el flanco
end component;

component aut_duracion
	Port(CLK_1ms : in STD_LOGIC; 									-- reloj de 1 ms
		  ENTRADA : in STD_LOGIC; 									-- línea de entrada de datos
		  VALID	 : out STD_LOGIC; 								-- salida de validacion de dato
		  DATO	 : out STD_LOGIC; 								-- salida de dato (0 o 1)
		  DURACION: out STD_LOGIC_VECTOR (15 downto 0));	-- salida de duracion del dato
end component;

component comp_16
	Port( P 		: in STD_LOGIC_VECTOR (15 downto 0);
			Q 		: in STD_LOGIC_VECTOR (15 downto 0);
			P_GT_Q: out STD_LOGIC);
end component;

component aut_control
	Port ( CLK_1ms 	: in STD_LOGIC; 								-- reloj
			 VALID		: in STD_LOGIC; 								-- entrada de dato valido
			 DATO			: in STD_LOGIC; 								-- dato (0 o 1)
			 C0			: in STD_LOGIC; 								-- resultado comparador de ceros
			 C1			: in STD_LOGIC; 								-- resultado comparador de unos
			 CODIGO		: out STD_LOGIC_VECTOR (7 downto 0);	--codigo morse obtenido
			 VALID_DISP	: out STD_LOGIC); 							-- validacion del display
end component;

component visualizacion
	Port ( E0		: in STD_LOGIC_VECTOR (7 downto 0); -- Entrada siguiente caracter
			 EN		: in STD_LOGIC;							-- Activacion para desplazamiento
			 CLK_1ms	: in STD_LOGIC;							-- Entrada de reloj de refresco
			 SEG7		: out STD_LOGIC_VECTOR(0 to 6);		-- Salida para los displays
			 AN		: out STD_LOGIC_VECTOR(3 downto 0));-- Activacion individual
end component;

-- SEÑALES NECESARIAS PARA LAS INTERCONEXIONES

-- Señales a la entrada del receptor
signal reloj : STD_LOGIC;
signal linDatos : STD_LOGIC;

-- Señal del divisor de reloj
signal reloj_1ms : STD_LOGIC;

-- Señal del detector de franco
signal valor_franco : STD_LOGIC;

-- Señales para el automata de duracion
signal valido : STD_LOGIC;
signal datoAutomata : STD_LOGIC;
signal duracionAuto : STD_LOGIC_VECTOR (15 downto 0);

-- Señales para el comparador de 16 bits (Como implementar dos comparadores?)
signal s_C0 : STD_LOGIC;
signal s_C1 : STD_LOGIC;

-- Señales para el automata de control
signal codigoAuto : STD_LOGIC_VECTOR (7 downto 0);
signal validoDisplay : STD_LOGIC;

-- Señales para el modulo visualizacion
signal segmento7 : STD_LOGIC_VECTOR (0 to 6);
signal anVisual : STD_LOGIC_VECTOR (3 downto 0);

begin

-- Interconexiones de modulos

U1: receptor
	Port map ( CLK => reloj,
				  LIN => linDatos,
				  SEG7 => segmento7,
				  AN => anVisual);

U2: div_reloj
	Port map ( CLK => reloj,
				  CLK_1ms => reloj_1ms);

U3: detector_flanco
	Port map ( CLK_1ms => reloj_1ms,
				  LIN => linDatos,
				  VALOR => valor_franco);
				  
U4: aut_duracion
	Port map ( CLK_1ms => reloj_1ms,
				  ENTRADA => valor_franco,
				  VALID => valido,
				  DATO => datoAutomata,
				  DURACION => duracionAuto);

-- Este es el comparador del ceros, falta el comparador de unos(ver el esquema pag 21)				  
U5: comp_16
	Port map ( P => duracionAuto,
				  Q => UMBRAL0, -- comparador de ceros
				  P_GT_Q => s_C0);
				  
-- Comparador de unos--------------------------------------------------

-- Codigo

-----------------------------------------------------------------------

U6: aut_control
	Port map ( CLK_1ms => STD_LOGIC,
				  VALID => valido,
				  DATO => datoAutomata,
				  C0 => s_C0,
				  C1 => s_C1,
				  CODIGO => codigoAuto,
				  VALID_DISP => validoDisplay);
				  
U7: visualizacion
	Port map ( E0 => codigoAuto,
				  EN => validoDisplay,
				  CLK_1ms => reloj_1ms,
				  SEG7 => segmento7,
				  AN => anVisual);

end a_receptor;

