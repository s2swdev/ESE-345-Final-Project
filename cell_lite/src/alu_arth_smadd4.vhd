-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:    alu_arth_smadd4
-- Description:	 4bit add unit with first level carry lookahead
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu_arth_smadd4 is
    Port ( a : in std_logic_vector(3 downto 0);
           b : in std_logic_vector(3 downto 0);
			  c_in : in std_logic;
           r : out std_logic_vector(3 downto 0);
           P_out : out std_logic;
           G_out : out std_logic);
end alu_arth_smadd4;

architecture structure of alu_arth_smadd4 is

	signal p : std_logic_vector(3 downto 0);
	signal g : std_logic_vector(3 downto 0);
	signal c : std_logic_vector(3 downto 1);

begin

	p <= a or b;
	g <= a and b;
	c(1) <= g(0) or (p(0) and c_in);
	c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c_in);
	c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c_in);

	r(0) <= (a(0) xor b(0)) xor c_in;
	r(1) <= (a(1) xor b(1)) xor c(1);
	r(2) <= (a(2) xor b(2)) xor c(2);
	r(3) <= (a(3) xor b(3)) xor c(3);

	P_out <= p(0) and p(1) and p(2) and p(3);
	G_out <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0));

end structure;