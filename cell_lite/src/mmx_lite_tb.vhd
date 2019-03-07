-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture				 
--
-- Module Name:    MMX_Lite_TB
-- Description:	Test bench for top level MMX-Lite
--
--------------------------------------------------------------------------------	

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE STD.textio.all;
USE ieee.std_logic_textio.all;

ENTITY MMX_Lite_MMX_Lite_sch_tb IS
END MMX_Lite_MMX_Lite_sch_tb;

ARCHITECTURE behavioral OF MMX_Lite_MMX_Lite_sch_tb IS 

   COMPONENT MMX_Lite
   PORT( Data_In	:	IN	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          ASource	:	OUT	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          ID_WB		:	OUT	STD_LOGIC; 
          RD_Data2	:	OUT	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          WB_Reg	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          ALUOut	:	OUT	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          RD_Reg2	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          RegWrite	:	OUT	STD_LOGIC; 
          EX_A		:	OUT	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          EX_B		:	OUT	STD_LOGIC_VECTOR (63 DOWNTO 0); 
          EX_ALUOp	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          clk		:	IN	STD_LOGIC; 
          WR_Reg	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          OpCode	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          Instr		:	IN	STD_LOGIC_VECTOR (15 DOWNTO 0));
   END COMPONENT;

   SIGNAL Data_In	:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL ID_A		:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL ID_Write	:	STD_LOGIC;
   SIGNAL ID_B		:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL EX_Rd		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL EX_ALUOut	:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL ID_Rs2	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL EX_Write	:	STD_LOGIC;
   SIGNAL EX_A		:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL EX_B		:	STD_LOGIC_VECTOR (63 DOWNTO 0);
   SIGNAL EX_Op		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL clk		:	STD_LOGIC;
   SIGNAL ID_RD		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL ID_OP		:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL Instr		:	STD_LOGIC_VECTOR (15 DOWNTO 0);


	type test_vector is record
		Data_In : std_logic_vector(63 downto 0);
		Instr : std_logic_vector(15 downto 0);
	end record;

	type test_vector_array is array (natural range <>) of test_vector;

	constant test_vectors : test_vector_array := (	   
	--		old input    				   rd		  rs1		rs2
	--		Input Data			op		   rs2		  rs1	    rd				  
	
		(x"0000000000000000", b"0000" & b"0000" & b"0000" & b"0000"), 	-- NOP
	
		(x"FFFFC00033331122", b"0001" & b"0000" & b"0000" & b"0000"),	-- LV r00, x"FFFFC000 33331122" 
		(x"CBFA156055555555", b"0001" & b"0000" & b"0000" & b"0001"),	-- LV r01, x"CBFA1560 55555555"
		(x"FFFF300055555555", b"0001" & b"0000" & b"0000" & b"0010"),	-- LV r02, x"FFFF3000 55555555"
		(x"223F3EE790055111", b"0001" & b"0000" & b"0000" & b"0111"),	-- LV r07, x"223F3EE7 90055111"
		
		(x"0000000FC0B20010", b"1000" & b"0010" & b"0000" & b"0100"),	-- PADDU32=a r04, r00, r01 
		(x"00FFC56700009002", b"1001" & b"0010" & b"0000" & b"0100"), 	-- PSUBU32=sfw r04, r00, r02
		
		(x"F056DA00000534EC", b"1010" & b"0010" & b"0000" & b"0100"),	-- PADDUW=ah r04, r00, r01 
		(x"45900235000CBA0D", b"1011" & b"0010" & b"0000" & b"0100"), 	-- PSUBUW=sfh r04, r00, r01
		
		--instead of padd32 try to do ahs and sfhs which is eq. to PADDUSW and PSUBUSW
		--(x"F056DA00000534EC", b"1000" & b"0100" & b"0000" & b"0111"),	-- PADD32 r04, r00, r01 
		--(x"F056DA00000534EC", b"1001" & b"0010" & b"0000" & b"0100"), 	-- PSUB32 r04, r00, r01	   

		--(x"F056DA00000534EC", b"1110" & b"0001" & b"0000" & b"0100"),	-- PCMPEQ32 r04, r00, r01 
		--(x"F056DA00000534EC", b"1110" & b"0100" & b"0001" & b"0010"), 	-- PCMPEQ32 r04, r01, r02    
		-- 2800ns
		(x"F056DA00000534EC", b"0110" & b"0001" & b"0000" & b"0100"),	-- PAND = and r04, r00, r01  
		(x"F056DA00000534EC", b"0011" & b"0001" & b"0000" & b"0100"),	-- POR = or r04, r00, r01
		
		(x"0000000000000000", b"1001" & b"0001" & b"0000" & b"0100"),	-- PADDUSW =ahs r04, r00, r01
		(x"0000000000000000", b"1101" & b"0001" & b"0000" & b"0101"),	-- PSUBUSW =sfhs r04, r00, r01	
		
		(x"F056DA00000534EC", b"0011" & b"0000" & b"0000" & b"0000"), 	-- NOP
		(x"F056DA00000534EC", b"0101" & b"0000" & b"0000" & b"0011"),	-- LV r03, x"00000000 00000003" 
		(x"F056DA00000534EC", b"0111" & b"0011" & b"0000" & b"0100"));	-- PSLLW = slhlhi r04, r00, 3 
		--(x"0000000000000000", b"0100" & b"0011" & b"0100" & b"0100"),	-- PSRLW r04, r04, 3 
		--(x"0000000000000000", b"0101" & b"0011" & b"0000" & b"0100"),	-- PSRAW r04, r00, 3   
		-- 3800ns
		--(x"0000000000000002", b"1111" & b"0011" & b"0000" & b"0000"),	-- LV r03, x"00000000 00000001" 
--		(x"0000000000000000", b"0011" & b"0100" & b"0000" & b"0011"),	-- PSLLW r04, r00, 1 
--		(x"0000000000000000", b"0100" & b"0100" & b"0000" & b"0011"),	-- PSRLW r04, r00, 1 
--		(x"0000000000000000", b"0101" & b"0100" & b"0000" & b"0011"),	-- PSRAW r04, r00, 1 
--		
--		
--		(x"0000000000000000", b"0111" & b"0110" & b"0001" & b"0000"),	
--		(x"0000000000000000", b"0111" & b"0110" & b"0000" & b"0001"),	
--		(x"0000000000000000", b"1010" & b"0111" & b"0001" & b"0000"),		
--		(x"0000000000000000", b"0000" & b"0000" & b"0000" & b"0000"),	   		
--		(x"FF56198505231785", b"1111" & b"1000" & b"0000" & b"0000"),
--		(x"0000FFFF0000FFFF", b"1111" & b"1001" & b"0000" & b"0000"),
--		(x"0000000000000000", b"0001" & b"1010" & b"1000" & b"1001"),
--		(x"0000000000000000", b"0000" & b"0000" & b"0000" & b"0000"),		
--		(x"0000000000008056", b"0000" & b"0000" & b"0000" & b"0000"),
--		(x"0000000000000000", b"0000" & b"0000" & b"0000" & b"0000"),
--		(x"0000000000000000", b"0000" & b"0000" & b"0000" & b"0000"));
BEGIN

   UUT: MMX_Lite PORT MAP(
		Data_In => Data_In, 
		ASource => ID_A, 
		ID_WB => ID_Write, 
		RD_Data2 => ID_B, 
		WB_Reg => EX_Rd, 
		ALUOut => EX_ALUOut, 
		RD_Reg2 => ID_Rs2, 
		
		RegWrite => EX_Write, 
		EX_A => EX_A, 
		EX_B => EX_B, 
		EX_ALUOp => EX_Op, 
		clk => clk, 
		WR_Reg => ID_RD, 
		OpCode => ID_OP, 
		Instr => Instr
   	);

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
		variable output_line : line;
   BEGIN
		for i in test_vectors'range loop
			--Check registers.
			--assert signal's.
			clk <= '0';
			Data_In <= test_vectors(i).Data_in;
			Instr <= test_vectors(i).Instr;
			wait for 50 ns;
			
			-- First Level --
			write(output_line, i);
			write(output_line, string'(" Cell-Lite"));
			writeline(output, output_line);
			write(output_line, string'("      ID&Rd     op:"));
			case ID_OP is
				when "0000" =>
					write(output_line, string'("NOP     "));
				when "0001" =>
					write(output_line, string'("lv   "));
				when "0010" =>
					write(output_line, string'("and   "));
				when "0011" =>
					write(output_line, string'("or    "));
				when "0100" =>
					write(output_line, string'("xor    "));
				when "0101" =>
					write(output_line, string'("roti   "));
				when "0110" =>
					write(output_line, string'("rothi "));
				when "0111" =>
					write(output_line, string'("slhlhi "));
				when "1000" =>
					write(output_line, string'("a  "));
				when "1001" =>
					write(output_line, string'("sfw  "));
				when "1010" =>
					write(output_line, string'("ah  "));
				when "1011" =>
					write(output_line, string'("sfh  "));
				when "1100" =>
					write(output_line, string'("ahs "));
				when "1101" =>
					write(output_line, string'("sfhs "));
				when "1110" =>
					write(output_line, string'("mpyu"));   
				when "1111" =>
					write(output_line, string'("absdb   "));
				when others =>		
			end case; 
			write(output_line, string'("    rd:"));
			write(output_line, ID_RD);		  
			
			write(output_line, string'("    data_op1:"));
			hwrite(output_line, ID_A);	
			
			write(output_line, string'("    rs2:"));
			write(output_line, ID_Rs2);

			write(output_line, string'("    data_op2:"));
			hwrite(output_line, ID_B);
			writeline(output, output_line);
			
			-- Second level	--
			write(output_line, string'("      EX&WB     op:"));
			case EX_OP is
				when "0000" =>
					write(output_line, string'("NOP     "));
				when "0001" =>
					write(output_line, string'("lv   "));
				when "0010" =>
					write(output_line, string'("and   "));
				when "0011" =>
					write(output_line, string'("or    "));
				when "0100" =>
					write(output_line, string'("xor    "));
				when "0101" =>
					write(output_line, string'("roti   "));
				when "0110" =>
					write(output_line, string'("rothi "));
				when "0111" =>
					write(output_line, string'("slhlhi "));
				when "1000" =>
					write(output_line, string'("a  "));
				when "1001" =>
					write(output_line, string'("sfw  "));
				when "1010" =>
					write(output_line, string'("ah  "));
				when "1011" =>
					write(output_line, string'("sfh  "));
				when "1100" =>
					write(output_line, string'("ahs "));
				when "1101" =>
					write(output_line, string'("sfhs "));
				when "1110" =>
					write(output_line, string'("mpyu"));   
				when "1111" =>
					write(output_line, string'("absdb   "));
				when others =>		
			end case; 	
			write(output_line, string'("    wreg:"));
			write(output_line, EX_RD);	
			write(output_line, string'("    wdata:"));
			hwrite(output_line, EX_ALUOut);
			write(output_line, string'("    data_op1:"));
			hwrite(output_line, EX_A);
			write(output_line, string'("    data_op2:"));
			hwrite(output_line, EX_B);	
			write(output_line, string'("    write:"));
			write(output_line, EX_Write);	
			writeline(output, output_line);
			writeline(output, output_line);
			wait for 50 ns;
						--complete clock cycle.
			clk <= '1';
			wait for 100 ns;
		end loop;

      WAIT; -- wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;