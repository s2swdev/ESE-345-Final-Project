-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			  
--
-- Module Name:    ALU
-- Description:	 Top level strutural design of ALU
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu is
    Port ( A 			: in std_logic_vector(63 downto 0);
           B 			: in std_logic_vector(63 downto 0);
           ALU_Op 		: in std_logic_vector(3 downto 0);
           Rs2 			: in std_logic_vector(3 downto 0);
           ALUOut	 	: out std_logic_vector(63 downto 0));
end alu;

architecture Structure of alu is

	component alu_logshift is
	    Port ( A 			: in std_logic_vector(63 downto 0);
	           B 			: in std_logic_vector(63 downto 0);
			   shftamnt 	: in std_logic_vector(3 downto 0);
	           logshift_op 	: in std_logic_vector(2 downto 0);
	           R		 	: out std_logic_vector(63 downto 0));
	end component;

	component alu_arth is
	    Port ( A 		: in std_logic_vector(63 downto 0);
	           B		: in std_logic_vector(63 downto 0);
	           arth_op 	: in std_logic_vector(3 downto 0);
	           R 		: out std_logic_vector(63 downto 0));
	end component;

	component mux64_2x1_2 is
		port( 	in1 : in std_logic_vector(63 downto 0);
				in0 : in std_logic_vector(63 downto 0);
				sel : in std_logic_vector (3 downto 0);
				y	: out std_logic_vector(63 downto 0) );
	end component;

	signal Arth_Out, LogShift_Out : std_logic_vector(63 downto 0);

begin

u1: alu_logshift port map(			A => A, 
									B => B,
									shftamnt => B(3 downto 0),
									logshift_op => ALU_Op(2 downto 0),
									R => LogShift_Out );

	u2: alu_arth port map(			A => A,
									B => B,
									arth_op => ALU_Op,
									R => Arth_out );

	u3: mux64_2x1_2 port map( 		in1 => Arth_out,
									in0 => Logshift_Out,
									sel => ALU_Op(3 downto 0),
									y => ALUOut );
end Structure;
