----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:13:27 11/22/2018 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
	Port ( CLK : in STD_LOGIC;
			 BTN_START : in STD_LOGIC;
			 BTN_STOP : in STD_LOGIC;
			 SPI_CLK : out STD_LOGIC;
			 SPI_DIN : out STD_LOGIC;
			 SPI_CS1 : out STD_LOGIC;
			 LIN : in STD_LOGIC;
			 AN : out STD_LOGIC_VECTOR (3 downto 0);
			 SEG7 : out STD_LOGIC_VECTOR (0 to 6));
end main;

architecture a_main of main is

component gen_senal
	Port ( CLK	: in STD_LOGIC;
			 BTN_START : in STD_LOGIC;
			 BTN_STOP : in STD_LOGIC;
			 SPI_CLK : out STD_LOGIC;
			 SPI_DIN : out STD_LOGIC;
			 SPI_CS1 : out STD_LOGIC);
end component;

component receptor
	Port ( CLK : in STD_LOGIC;
			 LIN : in STD_LOGIC;
			 AN : out STD_LOGIC_VECTOR (3 downto 0);
			 SEG7 : out STD_LOGIC_VECTOR (0 to 6));
end component;

begin

U1: gen_senal
	Port map ( CLK => CLK,
				  BTN_START => BTN_START,
				  BTN_STOP => BTN_STOP,
				  SPI_CLK => SPI_CLK,
				  SPI_DIN => SPI_DIN,
				  SPI_CS1 => SPI_CS1);
	
U2: receptor
	Port map ( CLK => CLK,
				  LIN => LIN,
				  AN => AN,
				  SEG7 => SEG7);

end a_main;

