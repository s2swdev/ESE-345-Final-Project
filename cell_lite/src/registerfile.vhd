--------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:    RegisterFile
-- Description:	 63x16 register file w/ bypass.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity RegisterFile is
    Port ( RD_Reg1 	: in std_logic_vector(3 downto 0);
           RD_Reg2 	: in std_logic_vector(3 downto 0);
           WR_Reg 	: in std_logic_vector(3 downto 0);
           WR_Data 	: in std_logic_vector(63 downto 0);
           RD_Data1 : out std_logic_vector(63 downto 0);
           RD_Data2 : out std_logic_vector(63 downto 0);
           RegWrite : in std_logic;
			clk 	: in std_logic);
end RegisterFile;

architecture dataflow of RegisterFile is
	type regf is array (0 to 15) of std_logic_vector(63 downto 0);
	signal regfile : regf;

begin

	read : process(RD_Reg1, RD_Reg2, WR_Reg, WR_Data)

	begin
		if (RD_Reg1 = WR_Reg and RegWrite = '1') then
		 	RD_Data1 <= WR_Data;
		else
			RD_Data1 <= regfile(to_integer(unsigned(RD_Reg1)));
		end if;

		if (RD_Reg2 = WR_Reg and RegWrite = '1') then
			RD_Data2 <= WR_Data;
		else
			RD_Data2 <= regfile(to_integer(unsigned(RD_Reg2)));
		end if;	
	end process;

	write: process(clk)

	begin
		if rising_edge(clk) then
			if (RegWrite = '1') then
				regfile(to_integer(unsigned(WR_Reg))) <= WR_Data;
			end if;
		end if;
	end process;

end dataflow;