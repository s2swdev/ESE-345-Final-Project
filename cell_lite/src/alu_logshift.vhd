-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			  
--
-- Module Name:    alu_logshift
-- Description:	 Logic and shift unit
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity alu_logshift is
    Port ( A : in std_logic_vector(63 downto 0);
           B : in std_logic_vector(63 downto 0);
			  shftamnt : in std_logic_vector(3 downto 0);
           logshift_op : in std_logic_vector(2 downto 0);
           R : out std_logic_vector(63 downto 0));
end alu_logshift;

architecture dataflow of alu_logshift is
begin

	process(A, B, shftamnt, logshift_op)
	begin
		case logshift_op is		  
			--when "111" =>		 -- absdb
				--R <= A;
			when "001" =>		 -- lv
				R <= A; 
			when "010" =>		 -- and
			R <= A and B;
			when "011" =>        -- or
			R <= A or B;
			when "100" =>       -- xor
			R <= A xor B;
			when "111" =>		 -- PSLLW 
				R(63 downto 48) <= To_StdLogicVector( To_bitvector( A(63 downto 48) ) sll to_integer(unsigned(shftamnt)));
				R(47 downto 32) <= To_StdLogicVector( To_bitvector( A(47 downto 32) ) sll to_integer(unsigned(shftamnt)));
				R(31 downto 16) <= To_StdLogicVector( To_bitvector( A(31 downto 16) ) sll to_integer(unsigned(shftamnt)));
				R(15 downto 0) <= To_StdLogicVector( To_bitvector( A(15 downto 0) ) sll to_integer(unsigned(shftamnt)));
				
			when "110" =>		 -- PSRLW
				R(63 downto 48) <= To_StdLogicVector( To_bitvector( A(63 downto 48) ) srl to_integer(unsigned(shftamnt)));
				R(47 downto 32) <= To_StdLogicVector( To_bitvector( A(47 downto 32) ) srl to_integer(unsigned(shftamnt)));
				R(31 downto 16) <= To_StdLogicVector( To_bitvector( A(31 downto 16) ) srl to_integer(unsigned(shftamnt)));
				R(15 downto 0) <= To_StdLogicVector( To_bitvector( A(15 downto 0) ) srl to_integer(unsigned(shftamnt)));
				
			when "101" =>		 -- PSRAW
				R(63 downto 48) <= To_StdLogicVector( To_bitvector( A(63 downto 48) ) sra to_integer(unsigned(shftamnt)));
				R(47 downto 32) <= To_StdLogicVector( To_bitvector( A(47 downto 32) ) sra to_integer(unsigned(shftamnt)));
				R(31 downto 16) <= To_StdLogicVector( To_bitvector( A(31 downto 16) ) sra to_integer(unsigned(shftamnt)));
				R(15 downto 0) <= To_StdLogicVector( To_bitvector( A(15 downto 0) ) sra to_integer(unsigned(shftamnt)));

			when others =>
				R <= x"0000000000000000";
		end case;
	end process;
end dataflow;
