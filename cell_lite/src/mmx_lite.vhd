--------------------------------------------------------------------------------
--
-- ESE 345 : Computer Architecture			   
--
-- Module Name:
-- Description:
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity MMX_Lite is
   port ( clk      : in    std_logic; 
          Data_In  : in    std_logic_vector (63 downto 0); 
          Instr    : in    std_logic_vector (15 downto 0); 
          ALUOut   : out   std_logic_vector (63 downto 0); 
          ASource  : out   std_logic_vector (63 downto 0); 
          EX_A     : out   std_logic_vector (63 downto 0); 
          EX_ALUOp : out   std_logic_vector (3 downto 0); 
          EX_B     : out   std_logic_vector (63 downto 0); 
          ID_WB    : out   std_logic; 
          OpCode   : out   std_logic_vector (3 downto 0); 
          RD_Data2 : out   std_logic_vector (63 downto 0); 
          RD_Reg2  : out   std_logic_vector (3 downto 0); 
          RegWrite : out   std_logic; 
          WB_Reg   : out   std_logic_vector (3 downto 0); 
          WR_Reg   : out   std_logic_vector (3 downto 0));
end MMX_Lite;

architecture BEHAVIORAL of MMX_Lite is
   signal ASrc           : std_logic;
   signal RD_Data1       : std_logic_vector (63 downto 0);
   signal RD_Reg1        : std_logic_vector (3 downto 0);
   signal ShftAmnt       : std_logic_vector (3 downto 0);
   signal ID_WB_DUMMY    : std_logic;
   signal WB_Reg_DUMMY   : std_logic_vector (3 downto 0);
   signal EX_A_DUMMY     : std_logic_vector (63 downto 0);
   signal EX_B_DUMMY     : std_logic_vector (63 downto 0);
   signal RegWrite_DUMMY : std_logic;
   signal OpCode_DUMMY   : std_logic_vector (3 downto 0);
   signal EX_ALUOp_DUMMY : std_logic_vector (3 downto 0);
   signal RD_Reg2_DUMMY  : std_logic_vector (3 downto 0);
   signal ALUOut_DUMMY   : std_logic_vector (63 downto 0);
   signal RD_Data2_DUMMY : std_logic_vector (63 downto 0);
   signal ASource_DUMMY  : std_logic_vector (63 downto 0);
   signal WR_Reg_DUMMY   : std_logic_vector (3 downto 0);		   
   
   component alu
      port ( A      : in    std_logic_vector (63 downto 0); 
             ALU_Op : in    std_logic_vector (3 downto 0); 
             Rs2    : in    std_logic_vector (3 downto 0); 
             ALUOut : out   std_logic_vector (63 downto 0); 
             B      : in    std_logic_vector (63 downto 0));
   end component;
   
   component control
      port ( OpCode : in    std_logic_vector (3 downto 0); 
             WB     : out   std_logic; 
             ASrc   : out   std_logic);
   end component;
   
   component mux64_2x1
      port ( sel : in    std_logic; 
             in1 : in    std_logic_vector (63 downto 0); 
             in0 : in    std_logic_vector (63 downto 0); 
             y   : out   std_logic_vector (63 downto 0));
   end component;
   
   component pipereg_idex
      port ( ID_WB      : in    std_logic; 
             ID_ALUOp   : in    std_logic_vector (3 downto 0); 
             ID_A       : in    std_logic_vector (63 downto 0); 
             ID_B       : in    std_logic_vector (63 downto 0); 
             ID_WB_Reg  : in    std_logic_vector (3 downto 0); 
             EX_WB      : out   std_logic; 
             EX_ALUOp   : out   std_logic_vector (3 downto 0); 
             EX_A       : out   std_logic_vector (63 downto 0); 
             EX_B       : out   std_logic_vector (63 downto 0); 
             ID_RD_Reg2 : in    std_logic_vector (3 downto 0); 
             EX_RD_Reg2 : out   std_logic_vector (3 downto 0); 
             EX_WB_Reg  : out   std_logic_vector (3 downto 0); 
             clk        : in    std_logic);
   end component;
   
   component registerfile
      port ( RegWrite : in    std_logic; 
             clk      : in    std_logic; 
             RD_Reg1  : in    std_logic_vector (3 downto 0); 
             RD_Reg2  : in    std_logic_vector (3 downto 0); 
             WR_Reg   : in    std_logic_vector (3 downto 0); 
             WR_Data  : in    std_logic_vector (63 downto 0); 
             RD_Data2 : out   std_logic_vector (63 downto 0); 
             RD_Data1 : out   std_logic_vector (63 downto 0));
   end component;
   
   component instrint
      port ( OpCode  : out   std_logic_vector (3 downto 0); 
             RD_Reg1 : out   std_logic_vector (3 downto 0); 
             RD_Reg2 : out   std_logic_vector (3 downto 0); 
             WR_Reg  : out   std_logic_vector (3 downto 0); 
             Instr   : in    std_logic_vector (15 downto 0));
   end component;
   
begin
   ALUOut(63 downto 0) <= ALUOut_DUMMY(63 downto 0);
   ASource(63 downto 0) <= ASource_DUMMY(63 downto 0);
   EX_A(63 downto 0) <= EX_A_DUMMY(63 downto 0);
   EX_ALUOp(3 downto 0) <= EX_ALUOp_DUMMY(3 downto 0);
   EX_B(63 downto 0) <= EX_B_DUMMY(63 downto 0);
   ID_WB <= ID_WB_DUMMY;
   OpCode(3 downto 0) <= OpCode_DUMMY(3 downto 0);
   RD_Data2(63 downto 0) <= RD_Data2_DUMMY(63 downto 0);
   RD_Reg2(3 downto 0) <= RD_Reg2_DUMMY(3 downto 0);
   RegWrite <= RegWrite_DUMMY;
   WB_Reg(3 downto 0) <= WB_Reg_DUMMY(3 downto 0);
   WR_Reg(3 downto 0) <= WR_Reg_DUMMY(3 downto 0);
   XLXI_1 : alu
      port map (A(63 downto 0)=>EX_A_DUMMY(63 downto 0),
                ALU_Op(3 downto 0)=>EX_ALUOp_DUMMY(3 downto 0),
                B(63 downto 0)=>EX_B_DUMMY(63 downto 0),
                Rs2(3 downto 0)=>ShftAmnt(3 downto 0),
                ALUOut(63 downto 0)=>ALUOut_DUMMY(63 downto 0));
   
   XLXI_2 : control
      port map (OpCode(3 downto 0)=>OpCode_DUMMY(3 downto 0),
                ASrc=>ASrc,
                WB=>ID_WB_DUMMY);
   
   XLXI_3 : mux64_2x1
      port map (in0(63 downto 0)=>RD_Data1(63 downto 0),
                in1(63 downto 0)=>Data_In(63 downto 0),
                sel=>ASrc,
                y(63 downto 0)=>ASource_DUMMY(63 downto 0));
   
   XLXI_4 : pipereg_idex
      port map (clk=>clk,
                ID_A(63 downto 0)=>ASource_DUMMY(63 downto 0),
                ID_ALUOp(3 downto 0)=>OpCode_DUMMY(3 downto 0),
                ID_B(63 downto 0)=>RD_Data2_DUMMY(63 downto 0),
                ID_RD_Reg2(3 downto 0)=>RD_Reg2_DUMMY(3 downto 0),
                ID_WB=>ID_WB_DUMMY,
                ID_WB_Reg(3 downto 0)=>WR_Reg_DUMMY(3 downto 0),
                EX_A(63 downto 0)=>EX_A_DUMMY(63 downto 0),
                EX_ALUOp(3 downto 0)=>EX_ALUOp_DUMMY(3 downto 0),
                EX_B(63 downto 0)=>EX_B_DUMMY(63 downto 0),
                EX_RD_Reg2(3 downto 0)=>ShftAmnt(3 downto 0),
                EX_WB=>RegWrite_DUMMY,
                EX_WB_Reg(3 downto 0)=>WB_Reg_DUMMY(3 downto 0));
   
   XLXI_5 : registerfile
      port map (clk=>clk,
                RD_Reg1(3 downto 0)=>RD_Reg1(3 downto 0),
                RD_Reg2(3 downto 0)=>RD_Reg2_DUMMY(3 downto 0),
                RegWrite=>RegWrite_DUMMY,
                WR_Data(63 downto 0)=>ALUOut_DUMMY(63 downto 0),
                WR_Reg(3 downto 0)=>WB_Reg_DUMMY(3 downto 0),
                RD_Data1(63 downto 0)=>RD_Data1(63 downto 0),
                RD_Data2(63 downto 0)=>RD_Data2_DUMMY(63 downto 0));
   
   XLXI_6 : instrint
      port map (Instr(15 downto 0)=>Instr(15 downto 0),
                OpCode(3 downto 0)=>OpCode_DUMMY(3 downto 0),
                RD_Reg1(3 downto 0)=>RD_Reg1(3 downto 0),
                RD_Reg2(3 downto 0)=>RD_Reg2_DUMMY(3 downto 0),
                WR_Reg(3 downto 0)=>WR_Reg_DUMMY(3 downto 0));
   
end BEHAVIORAL;


