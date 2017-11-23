`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Percent Effort: Evan Weiler: 50%, David Stallings: 50%
// 
// 
// Create Date: 10/16/2017 07:41:58 PM
// Design Name: 
// Module Name: topLevel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//TEST COMMENT
//Test Comment 2

module topLevel(Reset, Clk, PCResult, Mux_Mem2Reg_Out, HIreg_read, LOreg_read);

	input Reset, Clk;
	
	wire PCSrc;
	wire [31:0] Address_PCin, PCAddResult, JumpOrBranchAddress, JumpType;
	wire [31:0] Instruction_IM;
	output wire [31:0] PCResult;
	
	wire ALUSrc_cu, RegDst_cu, Branch_cu, MemWrite_cu, MemRead_cu, Mem2Reg_cu, RegWrite_cu, Jump_cu, Jal_cu, Jr_cu, ALUSrc_cc, RegDst_cc, Branch_cc, MemWrite_cc, MemRead_cc, Mem2Reg_cc, RegWrite_cc, Jump_cc, Jal_cc, Jr_cc, HU_PCWrite, CheckSignal, IF_ID_En;
	wire [1:0] DataMemChoice_cu, RegisterLoadChoice_cu, DataMemChoice_cc, RegisterLoadChoice_cc;
	wire [31:0] ReadData1_rf, ReadData2_rf, Instruction_IF_ID, OutputAddress_IF_ID, SE_1_Output;
	wire [10:0] ALUOp_cu, ALUOp_cc;
	
	wire RegWrite_ID_EX, Mem2Reg_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemWrite_ID_EX, RegDst_ID_EX, ALUSrc_ID_EX, Jump_ID_EX, RegWrite_MuxOut, Jal_ID_EX, Jr_ID_EX;
    wire [1:0] DataMemChoice_ID_EX, RegisterLoadChoice_ID_EX, ForwardA, ForwardB;
	wire [10:0] ALUOp_ID_EX;
	wire [31:0] OutputAddress_ID_EX, SE_1_ID_EX, ReadData1_ID_EX, ReadData2_ID_EX, ForwardAResult, ForwardBResult;
	wire [4:0] Instruction_20_16_ID_EX, Instruction_15_11_ID_EX, Instruction_25_21_ID_EX;
	wire [25:0] Instruction_25_0_ID_EX;

    wire [25:0] JumpTargetAddress;
	wire Zero_aluout;
	wire [4:0] MUX1_regdst, MUX2_regdst;
	wire [31:0] MUX2_ALUB, SL2_SHIFTED, AdderResult_out, ALU_RESULT_aluout, HIreg_write, LOreg_write;
	output wire [31:0] HIreg_read, LOreg_read;
	
	wire [31:0] ReadData_dm_out;
	
	wire [31:0] ReadData_dm_MEM_WB, ALU_RESULT_MEM_WB;
	wire RegWrite_MEM_WB, Mem2Reg_MEM_WB;
	wire [4:0] MUX2_regdst_MEM_WB;
	
	wire RegWrite_EX_MEM, Mem2Reg_EX_MEM, Branch_EX_MEM, MemRead_EX_MEM, MemWrite_EX_MEM, Zero_EX_MEM, Jump_EX_MEM, Jr_EX_MEM;
	wire [1:0] DataMemChoice_EX_MEM, RegisterLoadChoice_EX_MEM;
	wire [31:0] ReadData2_EX_MEM, AdderResult_EX_MEM, ALU_RESULT_EX_MEM, JumpTargetAddress_EX_MEM;
	wire [4:0] MUX2_regdst_EX_MEM;
	output wire [31:0] Mux_Mem2Reg_Out;
	
	Mux32Bit2To1 MUX_JumpType(JumpType, JumpTargetAddress_EX_MEM, ALU_RESULT_EX_MEM, Jr_EX_MEM);
	Mux32Bit2To1 MUX_JumpBranch(JumpOrBranchAddress, AdderResult_EX_MEM, JumpType, Jump_EX_MEM);
	Mux32Bit2To1 MUX_PCADD(Address_PCin, PCAddResult, JumpOrBranchAddress, PCSrc);
	//ProgramCounter PC_1(Address_PCin, PCResult, Reset, Clk);
	ProgramCounter PC_1(Address_PCin, PCResult, Reset, Clk, HU_PCWrite);
	InstructionMemory IM_1(PCResult, Instruction_IM);
	PCAdder PCA_1(PCResult, PCAddResult);
	
	// IF/ID PIPELINE REGISTER
	//IF_IDPipelineRegister IF_ID_1(PCAddResult, Instruction_IM, Clk, OutputAddress_IF_ID, Instruction_IF_ID);
    IF_IDPipelineRegister IF_ID_1(PCAddResult, Instruction_IM, Clk, OutputAddress_IF_ID, Instruction_IF_ID, IF_ID_En);
	// IF/ID PIPELINE REGISTER
	
	HazardUnit HU_1(Instruction_IF_ID, Instruction_20_16_ID_EX, MemRead_ID_EX, HU_PCWrite, IF_ID_En, CheckSignal);
	Mux1Bit2To1 MUX_RF(RegWrite_MuxOut, RegWrite_MEM_WB, 1'b0, PCSrc);
	RegisterFile RF_1(Instruction_IF_ID[25:21], Instruction_IF_ID[20:16], MUX2_regdst_MEM_WB, Mux_Mem2Reg_Out, RegWrite_MuxOut, Clk, ReadData1_rf, ReadData2_rf);
	SignExtension SE_1(Instruction_IF_ID[15:0], SE_1_Output);
	ControlUnit CU_1(Instruction_IF_ID, ALUOp_cu, ALUSrc_cu, RegDst_cu, Branch_cu, MemWrite_cu, MemRead_cu, Mem2Reg_cu, RegWrite_cu, DataMemChoice_cu, RegisterLoadChoice_cu, Jump_cu, Jal_cu, Jr_cu);
	ControllerCheck CC_1(CheckSignal, ALUOp_cu, ALUSrc_cu, RegDst_cu, Branch_cu, MemWrite_cu, MemRead_cu, Mem2Reg_cu, RegWrite_cu, DataMemChoice_cu, RegisterLoadChoice_cu, Jump_cu, Jal_cu, Jr_cu, ALUOp_cc, ALUSrc_cc, RegDst_cc, Branch_cc, MemWrite_cc, MemRead_cc, Mem2Reg_cc, RegWrite_cc, DataMemChoice_cc, RegisterLoadChoice_cc, Jump_cc, Jal_cc, Jr_cc);
	
	// ID/EX PIPELINE REGISTER
	//ID_EXPipelineRegister ID_EX_1(RegWrite_cu, Mem2Reg_cu, Branch_cu, MemRead_cu, MemWrite_cu, RegDst_cu, ALUOp_cu, ALUSrc_cu, DataMemChoice_cu, RegisterLoadChoice_cu, Jump_cu, Jal_cu, Jr_cu, OutputAddress_IF_ID, SE_1_Output, ReadData1_rf, ReadData2_rf, Instruction_IF_ID[25:0], Instruction_IF_ID[25:21], Instruction_IF_ID[20:16], Instruction_IF_ID[15:11], Clk, RegWrite_ID_EX, Mem2Reg_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemWrite_ID_EX, RegDst_ID_EX, ALUOp_ID_EX, ALUSrc_ID_EX, DataMemChoice_ID_EX, RegisterLoadChoice_ID_EX, Jump_ID_EX, Jal_ID_EX, Jr_ID_EX, OutputAddress_ID_EX, SE_1_ID_EX, ReadData1_ID_EX, ReadData2_ID_EX, Instruction_25_0_ID_EX, Instruction_25_21_ID_EX, Instruction_20_16_ID_EX, Instruction_15_11_ID_EX);
	ID_EXPipelineRegister ID_EX_1(RegWrite_cc, Mem2Reg_cc, Branch_cc, MemRead_cc, MemWrite_cc, RegDst_cc, ALUOp_cc, ALUSrc_cc, DataMemChoice_cc, RegisterLoadChoice_cc, Jump_cc, Jal_cc, Jr_cc, OutputAddress_IF_ID, SE_1_Output, ReadData1_rf, ReadData2_rf, Instruction_IF_ID[25:0], Instruction_IF_ID[25:21], Instruction_IF_ID[20:16], Instruction_IF_ID[15:11], Clk, RegWrite_ID_EX, Mem2Reg_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemWrite_ID_EX, RegDst_ID_EX, ALUOp_ID_EX, ALUSrc_ID_EX, DataMemChoice_ID_EX, RegisterLoadChoice_ID_EX, Jump_ID_EX, Jal_ID_EX, Jr_ID_EX, OutputAddress_ID_EX, SE_1_ID_EX, ReadData1_ID_EX, ReadData2_ID_EX, Instruction_25_0_ID_EX, Instruction_25_21_ID_EX, Instruction_20_16_ID_EX, Instruction_15_11_ID_EX);
	// ID/EX PIPELINE REGISTER
	
	Mux32Bit3To1 FORWARDING_MUX_TOP(ForwardAResult, ReadData1_ID_EX, Mux_Mem2Reg_Out, ALU_RESULT_EX_MEM, ForwardA);
    Mux32Bit3To1 FORWARDING_MUX_BOTTOM(ForwardBResult, /*ReadData2_ID_EX,*/MUX2_ALUB, Mux_Mem2Reg_Out, ALU_RESULT_EX_MEM, ForwardB);
	
	Mux5Bit2To1 MUX_JALCHECK(MUX1_regdst, Instruction_15_11_ID_EX, 5'd31, Jal_ID_EX);
	JumpExtension JE_1(Instruction_25_0_ID_EX, JumpTargetAddress);
	Mux5Bit2To1 MUX_REGDST(MUX2_regdst, Instruction_20_16_ID_EX, MUX1_regdst, RegDst_ID_EX);
	Mux32Bit2To1 MUX_ALUSRC(MUX2_ALUB, /*ForwardBResult,*/ ReadData2_ID_EX, SE_1_ID_EX, ALUSrc_ID_EX);
	ShiftLeft2 SL_2(SE_1_ID_EX, SL2_SHIFTED);
	Adder AddBranch(OutputAddress_ID_EX, SL2_SHIFTED, AdderResult_out);
	ALU32Bit THEDREAM(ALUOp_ID_EX, ForwardAResult, /*MUX2_ALUB,*/ ForwardBResult, ALU_RESULT_aluout, Zero_aluout, HIreg_read, LOreg_read, HIreg_write, LOreg_write, OutputAddress_ID_EX);
	Register Hi_reg(HIreg_read, HIreg_write, Clk);
	Register Lo_reg(LOreg_read, LOreg_write, Clk);
	
	ForwardUnit FU(Instruction_25_21_ID_EX, Instruction_20_16_ID_EX, RegWrite_EX_MEM, RegWrite_MEM_WB, MUX2_regdst_EX_MEM, MUX2_regdst_MEM_WB, ForwardA, ForwardB, Clk);
    
	// EX/MEM PIPELINE REGISTER
	EX_MEMPipelineRegister EX_MEM_1(RegWrite_ID_EX, Mem2Reg_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemWrite_ID_EX, DataMemChoice_ID_EX, RegisterLoadChoice_ID_EX, Jump_ID_EX, Jr_ID_EX, ReadData2_ID_EX, JumpTargetAddress, AdderResult_out, Zero_aluout, ALU_RESULT_aluout, MUX2_regdst, Clk, RegWrite_EX_MEM, Mem2Reg_EX_MEM, Branch_EX_MEM, MemRead_EX_MEM, MemWrite_EX_MEM, DataMemChoice_EX_MEM, RegisterLoadChoice_EX_MEM, Jump_EX_MEM, Jr_EX_MEM, ReadData2_EX_MEM, JumpTargetAddress_EX_MEM, AdderResult_EX_MEM, Zero_EX_MEM, ALU_RESULT_EX_MEM, MUX2_regdst_EX_MEM);
	// EX/MEM PIPELINE REGISTER
	
	AndGate AND_1(Branch_EX_MEM, Zero_EX_MEM, PCSrc);
	DataMemory DM_1(ALU_RESULT_EX_MEM, ReadData2_EX_MEM, Clk, MemWrite_EX_MEM, MemRead_EX_MEM, DataMemChoice_EX_MEM, RegisterLoadChoice_EX_MEM, ReadData_dm_out);
	
	// MEM/WB PIPELINE REGISTER
	MEM_WBPipelineRegister MEM_WB_1(RegWrite_EX_MEM, Mem2Reg_EX_MEM, ReadData_dm_out, ALU_RESULT_EX_MEM, MUX2_regdst_EX_MEM, Clk, RegWrite_MEM_WB, Mem2Reg_MEM_WB, ReadData_dm_MEM_WB, ALU_RESULT_MEM_WB, MUX2_regdst_MEM_WB);
	// MEM/WB PIPELINE REGISTER
	
	Mux32Bit2To1 MUX_FINAL(Mux_Mem2Reg_Out, ReadData_dm_MEM_WB, ALU_RESULT_MEM_WB, Mem2Reg_MEM_WB);
	
	

endmodule
