--------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:    PipeReg_IDEX
-- Description:	 Pipeling register.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity PipeReg_IDEX is
    Port ( 	ID_ALUOp 	: in std_logic_vector(3 downto 0);
           	ID_A 		: in std_logic_vector(63 downto 0);
           	ID_B 		: in std_logic_vector(63 downto 0);
           	ID_WB_Reg 	: in std_logic_vector(3 downto 0);
			ID_WB 		: in std_logic;
			ID_RD_Reg2 	: in std_logic_vector(3 downto 0);
           	EX_ALUOp 	: out std_logic_vector(3 downto 0);
           	EX_A 		: out std_logic_vector(63 downto 0);
           	EX_B 		: out std_logic_vector(63 downto 0);
           	EX_WB_Reg 	: out std_logic_vector(3 downto 0);
			EX_WB 		: out std_logic;
			EX_RD_Reg2 	: out std_logic_vector(3 downto 0);
			clk 		: in std_logic );
end PipeReg_IDEX;

architecture dataflow of PipeReg_IDEX is
	signal ALUOp : std_logic_vector(3 downto 0);
	signal A, B : std_logic_vector(63 downto 0);
	signal WB_Reg, RD_Reg2 : std_logic_vector(3 downto 0);
	signal WB : std_logic;

begin
	write: process(clk)
	begin
		if rising_edge(clk) then
			ALUOp <= ID_ALUOp;
			A <= ID_A;
			B <= ID_B;
			WB_Reg <= ID_WB_Reg;
			WB <= ID_WB;
			RD_Reg2 <= ID_RD_Reg2;	
		end if;
	end process;

	EX_ALUOp <= ALUOp;
	EX_A <= A;
	EX_B <= B;
	EX_WB_Reg <= WB_Reg;
	EX_WB <= WB;
	EX_RD_Reg2 <= RD_Reg2;
end dataflow;