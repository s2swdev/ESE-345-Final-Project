-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:    control
-- Description:
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu_arth_cntrl is
    Port ( alu_arth_op 	: in std_logic_vector(3 downto 0);
           sub 			: out std_logic;	 -- subtraction
           sat 			: out std_logic;	 -- saturation
           sel16_32 	: out std_logic;	 -- word or doubleWord ?
           as_cmp 		: out std_logic);	 -- compare
end alu_arth_cntrl;

architecture dataflow of alu_arth_cntrl is

begin
	 sub <= alu_arth_op(0);		-- xxx1
	 
	 -- x10x
	 sat <= alu_arth_op(2) and not alu_arth_op(1);
	 
	 -- 0 if its 16 and 1 if its 32
	 sel16_32 <= (alu_arth_op(2) and alu_arth_op(1)) or (not alu_arth_op(2) and not alu_arth_op(1));
	 
	 -- x11x
	 as_cmp <= alu_arth_op(3) and alu_arth_op(2) and alu_arth_op(1);
	 
end dataflow;
