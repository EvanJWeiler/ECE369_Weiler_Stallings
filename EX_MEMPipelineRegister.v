`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - EX/MEMPipelineRegister.v
// Description - 128-Bit wide IF/ID Pipeline Register unit.
//
// INPUTS:-
// RegWriteIn: 1-bit control, heading to write back cycle.
// MemtoRegIn: 1-bit control, heading to write back cycle
// BranchIn: 1-bit control, heading to memory cycle
// MemReadIn: 1-bit control, heading to memory cycle
// MemWriteIn: 1-bit control, heading to memory cycle
// ReadData2In: 32-bit value read from rt register
// BranchTargetAddressIn
// ZeroIn
// ALUResultIn
// DestinationRegisterIn
// Clk
//
// OUTPUTS:-
// RegWriteOut: 1-bit control, heading to write back cycle.
// MemtoRegOut: 1-bit control, heading to write back cycle
// BranchOut: 1-bit control, heading to memory cycle
// MemReadOut: 1-bit control, heading to memory cycle
// MemWriteOut: 1-bit control, heading to memory cycle
// ReadData2Out: 32-bit value read from rt register
// BranchTargetAddressOut
// ZeroOut
// ALUResultOut
// DestinationRegisterOut
//
//
////////////////////////////////////////////////////////////////////////////////

module EX_MEMPipelineRegister(RegWriteIn, MemtoRegIn, BranchIn, MemReadIn, MemWriteIn, DataMemChoiceIn, RegisterLoadChoiceIn, JumpIn, JrIn, ReadData2In, JumpTargetAddressIn, BranchTargetAddressIn, ZeroIn, ALUResultIn, DestinationRegisterIn, Clk, RegWriteOut, MemtoRegOut, BranchOut, MemReadOut, MemWriteOut, DataMemChoiceOut, RegisterLoadChoiceOut, JumpOut, JrOut, ReadData2Out, JumpTargetAddressOut, BranchTargetAddressOut, ZeroOut, ALUResultOut, DestinationRegisterOut);

	input RegWriteIn, MemtoRegIn, BranchIn, MemReadIn, MemWriteIn, ZeroIn, JumpIn, JrIn;
	input [31:0]ReadData2In, BranchTargetAddressIn, ALUResultIn, JumpTargetAddressIn;
	input [4:0]DestinationRegisterIn;
	input [1:0]DataMemChoiceIn, RegisterLoadChoiceIn;
	input Clk;
	
	(* dont_touch = "true" *) reg CurrentRegWrite, CurrentMemtoReg, CurrentBranch, CurrentMemRead, CurrentMemWrite, CurrentZero, CurrentJump, CurrentJr;
	(* dont_touch = "true" *) reg [31:0] CurrentReadData2, CurrentBranchTargetAddress, CurrentALUResult, CurrentJumpTargetAddress;
	(* dont_touch = "true" *) reg [4:0] CurrentDestinationRegister;
	(* dont_touch = "true" *) reg [1:0] CurrentDataMemChoice, CurrentRegisterLoadChoice;

	output reg RegWriteOut, MemtoRegOut, BranchOut, MemReadOut, MemWriteOut, ZeroOut, JumpOut, JrOut;
	output reg[31:0] ReadData2Out, BranchTargetAddressOut, ALUResultOut, JumpTargetAddressOut;
	output reg[4:0] DestinationRegisterOut;
	output reg[1:0] DataMemChoiceOut, RegisterLoadChoiceOut;


    /* Please fill in the implementation here... */
	always@(negedge Clk)
	begin
		CurrentRegWrite <= RegWriteIn;
		CurrentMemtoReg <= MemtoRegIn;
		CurrentBranch <= BranchIn;
		CurrentMemRead <= MemReadIn;
		CurrentMemWrite <= MemWriteIn;
		CurrentDataMemChoice <= DataMemChoiceIn;
		CurrentRegisterLoadChoice <= RegisterLoadChoiceIn;
		CurrentZero <= ZeroIn;
		CurrentReadData2 <= ReadData2In;
		CurrentBranchTargetAddress <= BranchTargetAddressIn;
		CurrentALUResult <= ALUResultIn;
		CurrentDestinationRegister <= DestinationRegisterIn;
		CurrentJumpTargetAddress <= JumpTargetAddressIn;
		CurrentJump <= JumpIn;
		CurrentJr <= JrIn;
	end
		
	always@(posedge Clk)
	begin
		RegWriteOut <= CurrentRegWrite;
		MemtoRegOut <= CurrentMemtoReg;
		BranchOut <= CurrentBranch;
		MemReadOut <= CurrentMemRead;
		MemWriteOut <= CurrentMemWrite;
		DataMemChoiceOut <= CurrentDataMemChoice;
		RegisterLoadChoiceOut <= CurrentRegisterLoadChoice;
		ZeroOut <= CurrentZero;
		ReadData2Out <= CurrentReadData2;
		BranchTargetAddressOut <= CurrentBranchTargetAddress;
		ALUResultOut <= CurrentALUResult;
		DestinationRegisterOut <= CurrentDestinationRegister;
		JumpTargetAddressOut <= CurrentJumpTargetAddress;
		JumpOut <= CurrentJump;
		JrOut <= CurrentJr;
	end
	
endmodule