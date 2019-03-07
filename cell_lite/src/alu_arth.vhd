-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			  
--
-- Module Name:    alu_arth
-- Description:	 ALU Arith unit.
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

entity alu_arth is
    Port ( A : in std_logic_vector(63 downto 0);
           B : in std_logic_vector(63 downto 0);
           arth_op : in std_logic_vector(3 downto 0);
           R : out std_logic_vector(63 downto 0));
end alu_arth;

architecture structure of alu_arth is

	component alu_arth_cntrl is
	    Port ( alu_arth_op : in std_logic_vector(3 downto 0);
	           sub : out std_logic;
	           sat : out std_logic;
	           sel16_32 : out std_logic;
	           as_cmp : out std_logic);
	end component;

	component alu_arth_cmpr is
	    Port ( A : in std_logic_vector(63 downto 0);
	           B : in std_logic_vector(63 downto 0);
	           sel16_32 : in std_logic;
	           R : out std_logic_vector(63 downto 0));
	end component;

	component alu_arth_sat is
		port( 	c_out3 : in std_logic;
				c_out2 : in std_logic;
				c_out1 : in std_logic;
				c_out0 : in std_logic;
				sel16_32 : in std_logic;
				sat_en : in std_logic;
				sub : in std_logic;
				r_in : in std_logic_vector(63 downto 0);
				r_out : out std_logic_vector(63 downto 0));
	end component;

	component alu_arth_smadd16 is
	    Port ( 	a 	: in std_logic_vector(15 downto 0);
	           	b 	: in std_logic_vector(15 downto 0);
				c_in: in std_logic;
	           	r 	: out std_logic_vector(15 downto 0);
				c_out: out std_logic);
	end component;

	component mux1_2x1 is
		port( 	in1 : in std_logic;
				in0 : in std_logic;
				sel : in std_logic;
				y 	: out std_logic );
	end component;

	component mux64_2x1 is
		port( 	in1 : in std_logic_vector(63 downto 0);
				in0 : in std_logic_vector(63 downto 0);
				sel : in std_logic;
				y 	: out std_logic_vector(63 downto 0) );
	end component;

	component xor_64 is
		port( 	a : in std_logic_vector(63 downto 0);
				b : in std_logic;
				y : out std_logic_vector(63 downto 0));
	end component;

	signal r_presat, r_postsat, r_postcmpr, b_postxor : std_logic_vector(63 downto 0);
	signal sub, sel16_32, sat, as_cmp : std_logic;
	signal c1in, c3in, c0out, c1out, c2out, c3out : std_logic;

begin

	u1: alu_arth_cntrl port map( 	alu_arth_op => arth_op,
	 								sub => sub,
									sat => sat,
									sel16_32 => sel16_32,
									as_cmp => as_cmp );

	u2: xor_64 port map(			a => b,
									b => sub,
									y => b_postxor );

	u3: alu_arth_cmpr port map(		A => a,
									B => b,
									sel16_32 => sel16_32,
									R => r_postcmpr );

	u4: alu_arth_smadd16 port map(	a => A(15 downto 0),
									b => b_postxor(15 downto 0),
									c_in => sub,
									c_out => c0out,
									r => r_presat(15 downto 0));

	u5: alu_arth_smadd16 port map(	a => A(31 downto 16),
									b => b_postxor(31 downto 16),
									c_in => c1in,
									c_out => c1out,
									r => r_presat(31 downto 16));

	u6: alu_arth_smadd16 port map(	a => A(47 downto 32),
									b => b_postxor(47 downto 32),
									c_in => sub,
									c_out => c2out,
									r => r_presat(47 downto 32));

	u7: alu_arth_smadd16 port map(	a => A(63 downto 48),
									b => b_postxor(63 downto 48),
									c_in => c3in,
									c_out => c3out,
									r => r_presat(63 downto 48));

	u8: mux1_2x1 port map(			in1 => c0out,
									in0 => sub,
									sel => sel16_32,
									y => c1in );

	u9: mux1_2x1 port map(			in1 => c2out,
									in0 => sub,
									sel => sel16_32,
									y => c3in );

	u10: alu_arth_sat port map( 	c_out3 => c3out,
									c_out2 => c2out,
									c_out1 => c1out,
									c_out0 => c0out,
									sel16_32 => sel16_32,
									sat_en => sat,
									sub => sub,
									r_in => r_presat,
									r_out => r_postsat );

	u11: mux64_2x1 port map(		in1 => r_postcmpr,
									in0 => r_postsat,
									sel => as_cmp,
									y => R );											 
end structure;