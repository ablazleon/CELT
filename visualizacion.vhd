----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:04:57 10/18/2018 
-- Design Name: 
-- Module Name:    visualizacion - Behavioral 
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

entity visualizacion is
    Port ( E0 : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK_1ms : in  STD_LOGIC;
           SEG7 : out  STD_LOGIC;
           AN : out  STD_LOGIC);
end visualizacion;

architecture Behavioral of visualizacion is

componet MUX4x8
port ( E0: in STD_LOGIC_VECTOR (7 downto 0);
		 E1: in STD_LOGIC_VECTOR (7 downto 0);
		 E2: in STD_LOGIC_VECTOR (7 downto 0);
		 E3: in STD_LOGIC_VECTOR (7 downto 0);
		 S: in STD_LOGIC_VECTOR (1 downto 0);
		 Y: out STD_LOGIC_VECTOR (7 downto 0));
end component;

component decodmorsea7s
port ( SIMBOLO : in STD_LOGIC_VECTOR (7 downto 0);
		 SEGMENTOS : out STD_LOGIC_VECTOR (0 to 6));
end component

component refresco
port ( CLK_1ms : in STD_LOGIC;
		 S : out STD_LOGIC_VECTOR (1 downto 0);
		 AN : out STD_LOGIC_VECTOR (3 downto 0));
end component

component rdesp_disp
port ( CLK_1ms : in STD_LOGIC;
		 EN : in STD_LOGIC;
		 E : in STD_LOGIC_VECTOR (7 downto 0);
		 Q0 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q1 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q2 : out STD_LOGIC_VECTOR (7 downto 0);
		 Q3 : out STD_LOGIC_VECTOR (7 downto 0));
end component

component div_reloj
port ( CLK : in STD_LOGIC;
		 CLK_1ms : out STD_LOGIC);
end component

-- Señales para las salidas del registro de desplazamiento
signal Reg_Q0 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q1 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q2 : STD_LOGIC_VECTOR (7 downto 0);
signal Reg_Q3 : STD_LOGIC_VECTOR (7 downto 0);

-- señal para la salida del multiplexor
signal Mux_Q : STD_LOGIC_VECTOR (7 downto 0);

-- señal para la salida del refresco
signal Ref_controlador : STD_LOGIC_VECTOR (1 downto 0);
signal Ref_salida : STD_LOGIC_Vector (3 downto 0);

-- señal para la salida del decodificador
signal Dec_Q : STD_LOGIC_VECTOR (6 downto 0);

-- señal para la salida del divisor
signal Div_clk : STD_LOGIC;
signal Div_clk1ms : STD_LOGIC;

begin
U1: decodmorsea7s
		port map (
						SIMBOLO => Mux_Q,
						SEGMENTOS => Dec_Q
						);
					
U2: MUX4x8
		port map (
						E0 => Reg_Q0,
						E1 => Reg_Q1,
						E2 => Reg_Q2,
						E3 => Reg_Q3,
						S => Mux_Q,
						Y => Ref_controlador
						);
						
U3: rdesp_disp
		port map (
						Q0 => Reg_Q0,
						Q1 => Reg_Q1,
						Q2 => Reg_Q2,
						Q3 => Reg_Q3,
						CLK_1ms => Div_clk1ms
						);
						
U4: refresco
		port map (
						CLK_1ms => Div_clk1ms,
						S => Ref_controlador,
						AN => Ref_salida
						);
U5: div_reloj
		port map (
						CLK => Div_clk,
						CLK_1ms => Div_clk1ms
						);

end Behavioral;
