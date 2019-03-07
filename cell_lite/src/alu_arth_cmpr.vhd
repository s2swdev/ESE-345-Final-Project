-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			
--
-- Module Name:    alu_arth_cmpr
-- Description:	 Compare unit for ALU depending on if its a Word or a doubleWord.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu_arth_cmpr is
    Port ( A : in std_logic_vector(63 downto 0);
           B : in std_logic_vector(63 downto 0);
           sel16_32 : in std_logic;
           R : out std_logic_vector(63 downto 0));
end alu_arth_cmpr;

architecture Behavioral of alu_arth_cmpr is

begin

	process(A, B, sel16_32)
	begin
		if ( sel16_32 = '0' ) then
			if( A(63 downto 48) = B(63 downto 48) ) then
				r(63 downto 48) <= (others => '1');
			else
				r(63 downto 48) <= (others => '0');
			end if;

			if( A(47 downto 32) = B(47 downto 32) ) then
				r(47 downto 32) <= (others => '1');
			else
				r(47 downto 32) <= (others => '0');
			end if;

			if( A(31 downto 16) = B(31 downto 16) ) then
				r(31 downto 16) <= (others => '1');
			else
				r(31 downto 16) <= (others => '0');
			end if;

			if( A(15 downto 0) = B(15 downto 0) ) then
				r(15 downto 0) <= (others => '1');
			else
				r(15 downto 0) <= (others => '0');
			end if;
		else
			if( A(63 downto 31) = B(63 downto 31) ) then
				r(63 downto 31) <= (others => '1');
			else
				r(63 downto 31) <= (others => '0');
			end if;

			if( A(31 downto 0) = B(31 downto 0) ) then
				r(31 downto 0) <= (others => '1');
			else
				r(31 downto 0) <= (others => '0');
			end if;
		end if;
	end process;

end Behavioral;
