-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture				
--
-- Module Name:    misc
-- Description:	 Misc. basic entities used throughout the system.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity mux64_2x1 is
	port( 	in1 : in std_logic_vector(63 downto 0);
			in0 : in std_logic_vector(63 downto 0);
			sel : in std_logic;
			y 	: out std_logic_vector(63 downto 0) );
end mux64_2x1;

architecture structure of mux64_2x1 is

begin
		y <= in1 when sel = '1' else
		     in0 when sel = '0' else
			  x"0000000000000000";
end structure;

--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity mux64_2x1_2 is
	port( 	in1 : in std_logic_vector(63 downto 0);
			in0 : in std_logic_vector(63 downto 0);
			sel : in std_logic_vector (3 downto 0);
			y 	: out std_logic_vector(63 downto 0) );
end mux64_2x1_2;

architecture structure of mux64_2x1_2 is

begin
		y <= 	in0 when sel(3) = '0' and sel(2)= '0' else 		-- 00XX
				in0 when sel(3) = '0' and sel(2)= '1' and sel(1)= '0' else	--010X	
				in0 when sel(3) = '1' and sel(2)= '1' and sel(1)= '1' and sel(0)='1' else --1111
				in1 when sel(3) = '1' or sel(2)= '1' or sel(1)= '1' or sel(0)='1' else
			  	x"0000000000000000";
end structure;

--------------------------------------------------------	   


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1_2x1 is
	port( in1 : in std_logic;
			in0 : in std_logic;
			sel : in std_logic;
			y : out std_logic );
end mux1_2x1;

architecture structure of mux1_2x1 is

begin
		y <= 	in1 when sel = '1' else
				in0 when sel = '0' else
				'0';
end structure;			   

-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_64 is
	port( 	a : in std_logic_vector(63 downto 0);
			b : in std_logic;
			y : out std_logic_vector(63 downto 0));
end xor_64;

architecture structure of xor_64 is

	signal b_extnd : std_logic_vector(63 downto 0);

begin
		b_extnd <= (others => b);
		y <= a xor b_extnd;
end structure;