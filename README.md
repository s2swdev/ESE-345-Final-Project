# ESE-345-Final-Project
Hierarchical gate-level and dataflow/RTL design of the pipelined multimedia Cell-Lite unit with the VHDL.


### Objective:
The objective of the project is to learn the use of VHDL/Verilog hardware description language and modern CAD tools for the hierarchical gate-level and dataflow/RTL design of the dual-stage pipelined multimedia Cell-Lite unit with a reduced set of multimedia instructions similar to those in the Sony Cell SPU Architecture.
The ALU had to be implemented in a hierarchical way with two major sub-blocks, the arithmetic module and the logic/shift module. The arithmetic unit is to be implemented as a gate-level design. Multiple level carry look-ahead circuit had to be used in the add/subtract circuit for each 16/32 bit word. The logic/shift module an ALU circuit had to be implemented as dataflow modules. 
	The register file has sixteen 64-bit registers. On any cycle, there could be two reads and one write. Two 64-bit register values should be read in each cycle and one 64-bit value could be written if needed. A bypass should enable a write and read to the same register return the new value for the read. The register models had to be implemented as a dataflow model.  The pipeline had to be implemented as a dataflow model. 
The expected result was to show the status of the pipeline with op-codes, input operands and results of execution of instructions in the pipeline for each cycle. 

### Basic principle:
Briefly, Cell-Lite Technology of Sony refers to a new set of instructions that speed up repeated operations on small data type such as bytes and words, which are the types of operations that dominate many multimedia operations. Sony Cell Lite technology utilizes parallel processing to speed up certain operations. The idea is simple: When it becomes hard to execute simple operations faster, do more things one at a time.
15 instructions are to be implemented in the pipelined Cell-Lite Unit design. Some instructions support “saturation”. This is a very cool new thing in cell-lite that stops wraparound (overflows) from happening when you exceed the data range limits. 
 Pipelined Cell-Lite Unit design implements 2 stages for each instruction, i.e. every instruction will execute consecutively 2 stages. Stage 1 is called Decode & Read Operand and stage 2 is called Execution and Write-back. The unit allows the parallel execution of the instruction and therefore improves throughput of instruction which is what we count. Some data dependency can be solved by using forwarding hardware. 
Decode & Read Operand:
 Every instruction will start from fetching instruction from input stimulus of the top-level test bench. During this stage, two data operands (if necessary) are read from the register file and placed with other control and data signals on the pipelined edge-sensitive register separating the stage from the next, execution & write-back stage. During this stage, the LV instruction loads data in to the register instead of the second data operand from the register file. Instruction format is given as follows:

### Execution & Write-back Stage:
 In the second stage the Multimedia ALU calculated the results of the 64-bit registers (operands) based on the opcode of the instruction and the result of the ALU is written back to the register file.
Procedure:
Step-by-step procedure was followed in order to successfully complete the design. First to start out with, some research were done on the topic, MMX Technology Architecture, to get a clear understanding of the design to be implemented. Various materials were read and analyzed including the ones that were provided, MMX Technology Architecture Overview. 
There were two choices given for this project. They were either VHDL or Verilog. We chose to use VHDL in our project. VHDL programming was reviewed and some already developed programs were studied in order to thoroughly understand the use of VHDL in HDL design of digital circuits. 

Then a detailed block diagram of the dual-stage multimedia Cell-Lite unit and its modules was developed. This block diagram was used as the prime designed to develop the code in VHDL. Each module was implemented as separate entity and was tested separately to verify its operation before it was used in the overall design. The control unit performs a major role in the operation of the circuit. The control unit decides which instruction to perform based on the opcode provided using the input in the testbench. The control unit takes a 4-bit input and decodes the appropriate logic for alu control. Since there are 4 types (add, subtract, shift, and logical) of instruction in the design, 4 control signals are needed.
The testbench for the top-level Cell-Lite Unit is written to test the results. The testbench is to be written in the behavioral model. So the testbench modules would supply an instruction to the Cell-Lite Unit. When the instruction supply is done Cell-Lite unit checks for the content of the register file and performs the necessary operations based on the instruction format.

### Conclusion:
The final design was tested and verified for various input data and different op-codes using different inputs in the testbench. All the 16 instructions functions as expected and the results generated match the theoretical results. So it was determined that the final design is a success.
