----------------------------------------------------------------------------------
-- VISUALIZACION
-- Es necesario cablear todos los elementos anteriores en un solo módulo. Para ello 
-- realizaremos un código VHDL con una descripción arquitectural de interconexión. 
-- Deberán declararse todos los módulos anteriores como component y realizar 
-- el cableado entre ellos.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity visualizacion is
    Port ( E0 : in  STD_LOGIC_VECTOR (7 downto 0);	-- 
           EN : in  STD_LOGIC;				-- Enable del modulo
           CLK_1ms : in  STD_LOGIC;			-- Reloj de 1 khz
           SEG7 : out  STD_LOGIC_VECTOR (0 to 6);	-- Salida de los 7 segmentos
           AN : out  STD_LOGIC_VECTOR (3 downto 0));    -- Salida que selecciona que display usar
end visualizacion;

architecture Behavioral of visualizacion is

component MUX4x8					-- Multiplexor de 4 entradas de 8 bits
port ( E0: in STD_LOGIC_VECTOR (7 downto 0);
		 E1: in STD_LOGIC_VECTOR (7 downto 0);
		 E2: in STD_LOGIC_VECTOR (7 downto 0);
		 E3: in STD_LOGIC_VECTOR (7 downto 0);
		 S: in STD_LOGIC_VECTOR (1 downto 0);
		 Y: out STD_LOGIC_VECTOR (7 downto 0));
end component;

component decodmorsea7s						-- Decodificador de 7 segmentos
port ( SIMBOLO : in STD_LOGIC_VECTOR (7 downto 0);
		 SEGMENTOS : out STD_LOGIC_VECTOR (0 to 6));
end component;

component refresco						-- Modulo Refresco
port ( CLK_1ms : in STD_LOGIC;
		 S : out STD_LOGIC_VECTOR (1 downto 0);
		 AN : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component rdesp_disp						-- Registro de desplazamiento
port ( CLK_1ms : in STD_LOGIC;
		 EN : in STD_LOGIC;
		 E : in STD_LOGIC_VECTOR (7 downto 0);
		 Q0 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q1 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q2 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q3 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Senales para las salidas del registro de desplazamiento
signal Reg_Q0 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q1 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q2 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q3 : STD_LOGIC_VECTOR (7 downto 0);

-- senal para la salida del multiplexor
signal Mux_Q : STD_LOGIC_VECTOR (7 downto 0);

-- senal para la salida del refresco
signal Ref_controlador : STD_LOGIC_VECTOR (1 downto 0);

begin
	
-- Conexiones entre los componentes	
U1: decodmorsea7s
		port map (
						SIMBOLO => Mux_Q,
						SEGMENTOS => SEG7
						);
					
U2: MUX4x8
		port map (
						E0 => Reg_Q0,
						E1 => Reg_Q1,
						E2 => Reg_Q2,
						E3 => Reg_Q3,
						S => Ref_controlador,
						Y => Mux_Q
						);
						
U3: rdesp_disp
		port map (
						Q0 => Reg_Q0,
						Q1 => Reg_Q1,
						Q2 => Reg_Q2,
						Q3 => Reg_Q3,
						CLK_1ms => CLK_1ms,
						EN => EN,
						E => E0
						);
						
U4: refresco
		port map (
						CLK_1ms => CLK_1ms,
						S => Ref_controlador,
						AN => AN
						);

end Behavioral;
