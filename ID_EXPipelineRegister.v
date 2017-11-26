`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ID/EXPipelineRegister.v
// Description - 128-Bit wide IF/ID Pipeline Register unit.
//
// INPUTS:-
// RegWriteIn: 1-bit control, heading to write back cycle.
// MemtoRegIn: 1-bit control, heading to write back cycle
// BranchIn: 1-bit control, heading to memory cycle
// MemReadIn: 1-bit control, heading to memory cycle
// MemWriteIn: 1-bit control, heading to memory cycle
// RegDstIn: 1-bit control, heading to execute cycle
// ALUOpIn: 6-bit control used to indicate which instruction the ALU should perform
// ALUSrcIn: 1-bit control, heading to execute cycle
// AddressIn: 32-Bit input control bits to keep track of the next address.
// SignExtendImmediateIn: 32-bit sign extended value from instruction
// ReadData1In: ?-bit value read from rs register
// ReadData2In: ?-bit value read from rt register
// rtIn: 5-bit value giving the address of the rt register
// rdIn: 5-bit value giving the address of the rd register
// Clk
//
// OUTPUTS:-
// RegWriteOut: 1-bit control, heading to write back cycle.
// MemtoRegOut: 1-bit control, heading to write back cycle
// BranchOut: 1-bit control, heading to memory cycle
// MemReadOut: 1-bit control, heading to memory cycle
// MemWriteOut: 1-bit control, heading to memory cycle
// RegDstOut: 1-bit control, heading to execute cycle
// ALUOpOut: 6-bit control used to indicate which instruction the ALU should perform
// ALUSrcOut: 1-bit control, heading to execute cycle
// AddressOut: 32-Bit input control bits to keep track of the next address.
// SignExtendImmediateOut: 32-bit sign extended value from instruction
// ReadData1Out: 32-bit value read from rs register
// ReadData2Out: 32-bit value read from rt register
// rtOut: 5-bit value giving the address of the rt register
// rdOut: 5-bit value giving the address of the rd register
//
//
////////////////////////////////////////////////////////////////////////////////

module ID_EXPipelineRegister(RegWriteIn, MemtoRegIn, BranchIn, MemReadIn, MemWriteIn, RegDstIn, ALUOpIn, ALUSrcIn, DataMemChoiceIn, RegisterLoadChoiceIn, JumpIn, JalIn, JrIn, AddressIn, SignExtendImmediateIn, ReadData1In, ReadData2In, JumpTargetAddressIn, rsIn, rtIn, rdIn, Clk, RegWriteOut, MemtoRegOut, BranchOut, MemReadOut, MemWriteOut, RegDstOut, ALUOpOut, ALUSrcOut, DataMemChoiceOut, RegisterLoadChoiceOut, JumpOut, JalOut, JrOut, AddressOut, SignExtendImmediateOut, ReadData1Out, ReadData2Out, JumpTargetAddressOut, rsOut, rtOut, rdOut);

	input RegWriteIn, MemtoRegIn, BranchIn, MemReadIn, MemWriteIn, RegDstIn, ALUSrcIn, JumpIn, JalIn, JrIn; //all 1-bit control values
	input [10:0] ALUOpIn;
	input [4:0] rtIn, rdIn, rsIn;
	input [31:0] SignExtendImmediateIn, AddressIn, ReadData1In, ReadData2In;
	input [1:0] DataMemChoiceIn, RegisterLoadChoiceIn;
	input [25:0] JumpTargetAddressIn;
	input Clk;
	
	(* dont_touch = "true" *) reg CurrentRegWrite, CurrentMemtoReg, CurrentBranch, CurrentMemRead, CurrentMemWrite, CurrentRegDst, CurrentALUSrc, CurrentJump, CurrentJal, CurrentJr;//temps
	(* dont_touch = "true" *) reg [10:0] CurrentALUOp;
	(* dont_touch = "true" *) reg [4:0] CurrentRt, CurrentRd, CurrentRs;
	(* dont_touch = "true" *) reg [31:0] CurrentSignExtendImmediate, CurrentReadData1, CurrentReadData2, CurrentAddress;
    (* dont_touch = "true" *) reg [1:0] CurrentDataMemChoice, CurrentRegisterLoadChoice;
    (* dont_touch = "true" *) reg [25:0] CurrentJumpTargetAddress;

	output reg RegWriteOut, MemtoRegOut, BranchOut, MemReadOut, MemWriteOut, RegDstOut, ALUSrcOut, JumpOut, JalOut, JrOut; //all 1-bit control values
	output reg[10:0] ALUOpOut;
	output reg[4:0] rtOut, rdOut, rsOut;
	output reg[31:0] SignExtendImmediateOut, AddressOut, ReadData1Out, ReadData2Out;
	output reg[1:0] DataMemChoiceOut, RegisterLoadChoiceOut;
	output reg[25:0] JumpTargetAddressOut;


    /* Please fill in the implementation here... */
	always@(negedge Clk)
	begin
		CurrentRegWrite <= RegWriteIn;
		CurrentMemtoReg <= MemtoRegIn;
		CurrentBranch <= BranchIn;
		CurrentMemRead <= MemReadIn;
		CurrentMemWrite <= MemWriteIn;
		CurrentRegDst <= RegDstIn;
		CurrentALUSrc <= ALUSrcIn;
		CurrentDataMemChoice <= DataMemChoiceIn;
		CurrentRegisterLoadChoice <= RegisterLoadChoiceIn;
		CurrentALUOp <= ALUOpIn;
		CurrentRt <= rtIn;
		CurrentRd <= rdIn;
		CurrentRs <= rsIn;
		CurrentSignExtendImmediate <= SignExtendImmediateIn;
		CurrentAddress <= AddressIn;
		CurrentReadData1 <= ReadData1In;
		CurrentReadData2 <= ReadData2In;
		CurrentJumpTargetAddress <= JumpTargetAddressIn;
		CurrentJump <= JumpIn;
		CurrentJal <= JalIn;
		CurrentJr <= JrIn;
	
	end

	always@(posedge Clk)
	begin
		RegWriteOut <= CurrentRegWrite;
		MemtoRegOut <= CurrentMemtoReg;
		BranchOut <= CurrentBranch;
		MemReadOut <= CurrentMemRead;
		MemWriteOut <= CurrentMemWrite;
		RegDstOut <= CurrentRegDst;
		ALUSrcOut <= CurrentALUSrc;
		DataMemChoiceOut <= CurrentDataMemChoice;
		RegisterLoadChoiceOut <= CurrentRegisterLoadChoice;
		ALUOpOut <= CurrentALUOp;
		rtOut <= CurrentRt;
		rdOut <= CurrentRd;
		rsOut <= CurrentRs;
		SignExtendImmediateOut <= CurrentSignExtendImmediate;
		AddressOut <= CurrentAddress;
		ReadData1Out <= CurrentReadData1;
		ReadData2Out <= CurrentReadData2;
		JumpTargetAddressOut <= CurrentJumpTargetAddress;
		JumpOut <= CurrentJump;
		JalOut <= CurrentJal;
		JrOut <= CurrentJr;
	end
	
endmodule
