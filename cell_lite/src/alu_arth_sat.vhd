-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--								 
-- Function: Detects if the instruction considers saturation.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu_arth_sat is
	port( 	c_out3 : in std_logic;
			c_out2 : in std_logic;
			c_out1 : in std_logic;
			c_out0 : in std_logic;
			sel16_32 : in std_logic;
			sat_en : in std_logic;
			sub : in std_logic;
			r_in : in std_logic_vector(63 downto 0);
			r_out : out std_logic_vector(63 downto 0));
end alu_arth_sat;

architecture dataflow of alu_arth_sat is

begin

	r_out(15 downto 0) <=  		  x"FFFF" when sat_en = '1' and sub = '0' and c_out0 = '1' and sel16_32 = '0' else
								  x"FFFF" when sat_en = '1' and sub = '0' and c_out1 = '1' and sel16_32 = '1' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(15) = '1' and sel16_32 = '0' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(31) = '1' and sel16_32 = '1' else
								  r_in(15 downto 0);

	r_out(31 downto 16) <= 		  x"FFFF" when sat_en = '1' and sub = '0' and c_out1 = '1' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(31) = '1' else
								  r_in(31 downto 16);

	r_out(47 downto 32) <= 		  x"FFFF" when sat_en = '1' and sub = '0' and c_out2 = '1' and sel16_32 = '0' else
								  x"FFFF" when sat_en = '1' and sub = '0' and c_out3 = '1' and sel16_32 = '1' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(47) = '1' and sel16_32 = '0' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(63) = '1' and sel16_32 = '1' else
								  r_in(47 downto 32);

	r_out(63 downto 48) <= 		  x"FFFF" when sat_en = '1' and sub = '0' and c_out3 = '1' else
								  x"0000" when sat_en = '1' and sub = '1' and r_in(31) = '1' else
								  r_in(63 downto 48);
end dataflow;
