-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture				
--
-- Module Name:    alu_arth_smadd16
-- Description:	 16bit add unit with second level carry look ahead.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;


entity alu_arth_smadd16 is
    Port ( 	a : in std_logic_vector(15 downto 0);
           	b : in std_logic_vector(15 downto 0);
			c_in : in std_logic;
           	r : out std_logic_vector(15 downto 0);
			c_out : out std_logic);
end alu_arth_smadd16;

architecture mixed of alu_arth_smadd16 is

	component alu_arth_smadd4
    Port ( a : in std_logic_vector(3 downto 0);
           b : in std_logic_vector(3 downto 0);
			  c_in : in std_logic;
           r : out std_logic_vector(3 downto 0);
           P_out : out std_logic;
           G_out : out std_logic);
	end component;

	signal P : std_logic_vector(3 downto 0);
	signal G : std_logic_vector(3 downto 0);
	signal C : std_logic_vector(3 downto 1);


begin

	add_0 : alu_arth_smadd4 port map (a => a(3 downto 0), b => b(3 downto 0), c_in => c_in, r => r(3 downto 0), p_out => P(0), G_out => G(0));

	add_1 : alu_arth_smadd4 port map (a => a(7 downto 4), b => b(7 downto 4), c_in => C(1), r => r(7 downto 4), p_out => P(1), G_out => G(1));

	add_2 : alu_arth_smadd4 port map (a => a(11 downto 8), b => b(11 downto 8), c_in => C(2), r => r(11 downto 8), p_out => P(2), G_out => G(2));

	add_3 : alu_arth_smadd4 port map (a => a(15 downto 12), b => b(15 downto 12), c_in => C(3), r => r(15 downto 12), p_out => P(3), G_out => G(3));

	C(1) <= G(0) or (P(0) and c_in);
	C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and c_in);
	C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and c_in);
	c_out <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and c_in);

end mixed;