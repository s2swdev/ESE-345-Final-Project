-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:    control
-- Description:	 Main MMX-Lite Control unit.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity control is
    Port ( OpCode 	: in std_logic_vector(3 downto 0);
           ASrc 	: out std_logic;
           WB 		: out std_logic );
end control;

architecture dataflow of control is

begin

	ASrc <= not OpCode(3) and not OpCode(2) and not OpCode(1) and OpCode(0);
	WB <= OpCode(3) or OpCode(2) or OpCode(1) or OpCode(0);

end dataflow;
