-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture				
--
-- Module Name:    InstrInt
-- Description:	 This is just an instruction interface for the top level
--						 schematic.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity Instrint is
    Port ( Instr : in std_logic_vector(15 downto 0);
           OpCode : out std_logic_vector(3 downto 0);
           RD_Reg1 : out std_logic_vector(3 downto 0);
           RD_Reg2 : out std_logic_vector(3 downto 0);
           WR_Reg : out std_logic_vector(3 downto 0));
end Instrint;

architecture dataflow of Instrint is

begin
	
	Opcode <= Instr(15 downto 12);
    RD_Reg2 <= Instr(11 downto 8);
	RD_Reg1 <= Instr(7 downto 4);
	WR_Reg <= Instr(3 downto 0);

end	 dataflow;
