-------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			 
--
-- Module Name:    alu_arth_TB
-- Description:	 Testbench for Arth unit.
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY alu_arth_tb_vhd IS
END alu_arth_tb_vhd;

ARCHITECTURE behavior OF alu_arth_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT alu_arth
	PORT(
		A : IN std_logic_vector(63 downto 0);
		B : IN std_logic_vector(63 downto 0);
		arth_op : IN std_logic_vector(3 downto 0);          
		R : OUT std_logic_vector(63 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL A :  std_logic_vector(63 downto 0) := (others=>'0');
	SIGNAL B :  std_logic_vector(63 downto 0) := (others=>'0');
	SIGNAL arth_op :  std_logic_vector(3 downto 0) := (others=>'0');

	--Outputs
	SIGNAL R :  std_logic_vector(63 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu_arth PORT MAP(
		A => A,
		B => B,
		arth_op => arth_op,
		R => R
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		wait; -- will wait forever
	END PROCESS;

END;
