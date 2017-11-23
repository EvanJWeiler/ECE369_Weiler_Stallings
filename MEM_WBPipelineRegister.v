`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - MEM/WBPipelineRegister.v
// Description - 128-Bit wide IF/ID Pipeline Register unit.
//
// INPUTS:-
// RegWriteIn: 1-bit control, heading to write back cycle.
// MemtoRegIn: 1-bit control, heading to write back cycle
// ReadDataMemoryIn
// ALUResultIn
// DestinationRegisterIn
// Clk
//
// OUTPUTS:-
// RegWriteOut: 1-bit control, heading to write back cycle.
// MemtoRegOut: 1-bit control, heading to write back cycle
// ReadDataMemoryOut
// ALUResultOut
// DestinationRegisterOut
//
//
////////////////////////////////////////////////////////////////////////////////

module MEM_WBPipelineRegister(RegWriteIn, MemtoRegIn, ReadDataMemoryIn, ALUResultIn, DestinationRegisterIn, Clk, RegWriteOut, MemtoRegOut, ReadDataMemoryOut, ALUResultOut, DestinationRegisterOut);

	input RegWriteIn, MemtoRegIn;
	input [31:0] ALUResultIn, ReadDataMemoryIn;
	input [4:0] DestinationRegisterIn;
	input Clk;
	
	(* dont_touch = "true" *) reg CurrentRegWrite, CurrentMemtoReg;
	(* dont_touch = "true" *) reg [31:0] CurrentALUResult, CurrentReadDataMemory;
	(* dont_touch = "true" *) reg [4:0] CurrentDestinationRegister;

	output reg RegWriteOut, MemtoRegOut;
	output reg[31:0] ALUResultOut, ReadDataMemoryOut;
	output reg[4:0] DestinationRegisterOut;


    /* Please fill in the implementation here... */
	always@(negedge Clk)
	begin
		CurrentRegWrite <= RegWriteIn;
		CurrentMemtoReg <= MemtoRegIn;
		CurrentReadDataMemory <= ReadDataMemoryIn;
		CurrentALUResult <= ALUResultIn;
		CurrentDestinationRegister <= DestinationRegisterIn;
	end
		
	always@(posedge Clk)
	begin
		RegWriteOut <= CurrentRegWrite;
		MemtoRegOut <= CurrentMemtoReg;
		ReadDataMemoryOut <= CurrentReadDataMemory;
		ALUResultOut <= CurrentALUResult;
		DestinationRegisterOut <= CurrentDestinationRegister;
    end
    
endmodule