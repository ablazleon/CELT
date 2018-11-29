----------------------------------------------------------------------------------
-- RECEPTOR
-- Integra todos los componentes de la parte digital del proyecto.
-- Se encarga de procesar la senal morse recibida y mostrar por los 4 displays
-- los mensajes descodificados.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity receptor is
	Port( CLK : in STD_LOGIC; 			-- reloj de la FPGA
	      LIN : in STD_LOGIC; 			-- Línea de entrada de datos
	      SEG7: out STD_LOGIC_VECTOR (0 to 6);	-- Salida para los displays
	      AN  : out STD_LOGIC_VECTOR (3 downto 0));	-- Activacion individual
end receptor;

architecture a_receptor of receptor is

constant UMBRAL0: STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral ceros
constant UMBRAL1: STD_LOGIC_VECTOR (15 downto 0) := "0000000011001000"; -- 200 umbral unos

component div_reloj
	Port( CLK : in STD_LOGIC;
			CLK_1ms : out STD_LOGIC);
end component;

component detector_flanco
	Port(CLK_1ms : in STD_LOGIC; 		 -- reloj
		  LIN		 : in STD_LOGIC; -- Línea de datos
		  VALOR	 : out STD_LOGIC); 	 -- Valor detectado en el flanco
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
	Port ( E0		: in STD_LOGIC_VECTOR (7 downto 0);		-- Entrada siguiente caracter
			 EN		: in STD_LOGIC;							-- Activacion para desplazamiento
			 CLK_1ms	: in STD_LOGIC;							-- Entrada de reloj de refresco
			 SEG7		: out STD_LOGIC_VECTOR(0 to 6);		-- Salida para los displays
			 AN		: out STD_LOGIC_VECTOR(3 downto 0));	-- Activacion individual
end component;

-- SEÑALES NECESARIAS PARA LAS INTERCONEXIONES

-- Señal del divisor de reloj
signal reloj_1ms : STD_LOGIC;

-- Señal del detector de franco
signal valor_franco : STD_LOGIC;

-- Señales para el automata de duracion
signal valido : STD_LOGIC;
signal datoAutomata : STD_LOGIC;
signal duracionAuto : STD_LOGIC_VECTOR (15 downto 0);

-- Señales para el comparador de 16 bits
signal s_C0 : STD_LOGIC;
signal s_C1 : STD_LOGIC;

-- Señales para el automata de control
signal codigoAuto : STD_LOGIC_VECTOR (7 downto 0);
signal validoDisplay : STD_LOGIC;

begin

-- Interconexiones de modulos
U1: div_reloj
	Port map ( CLK => CLK,
				  CLK_1ms => reloj_1ms);

U2: detector_flanco
	Port map ( CLK_1ms => reloj_1ms,
				  LIN => LIN,
				  VALOR => valor_franco);
				  
U3: aut_duracion
	Port map ( CLK_1ms => reloj_1ms,
				  ENTRADA => valor_franco,
				  VALID => valido,
				  DATO => datoAutomata,
				  DURACION => duracionAuto);

-- Este es el comparador del ceros		  
U4: comp_16
	Port map ( P => duracionAuto,
				  Q => UMBRAL0, -- comparador de ceros
				  P_GT_Q => s_C0);
				  
-- Comparador de unos
U5: comp_16
	Port map ( P => duracionAuto,
				  Q => UMBRAL1,
				  P_GT_Q => s_C1);

U6: aut_control
	Port map ( CLK_1ms => reloj_1ms,
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
				  SEG7 => SEG7,
				  AN => AN);

end a_receptor;

