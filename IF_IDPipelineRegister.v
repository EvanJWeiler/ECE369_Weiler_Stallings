`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - IF/IDPipelineRegister.v
// Description - 64-Bit wide IF/ID Pipeline Register unit.
//
// INPUTS:-
// NewPCAddress: 32-Bit input control bits to keep track of the next address.
// Instruction: 32-Bit instruction.
// Clk: Clock cycle
//
// REG:
// currentAddress: 32-bit temp variable to hold NewPCAddress at the negative edge of the clk
// currentInstruction: 32-bit temp variable to hold Instruction at the negative edge of the clk
//
// OUTPUTS:-
// outputAddress: 32-Bit Address output.
// outputInstruction: 32-bit Instruction output. 
//
// FUNCTIONALITY:-
// Currently holds the current instruction and next address of the system.
//
////////////////////////////////////////////////////////////////////////////////

module IF_IDPipelineRegister(NewPCAddress, Instruction, Clk, outputAddress, outputInstruction, En, Flush);

	input [31:0] NewPCAddress;
	input [31:0] Instruction;
	input Clk, En, Flush;
	
	(* dont_touch = "true" *) reg [31:0] currentInstruction, currentAddress;

	output reg[31:0] outputAddress;
	(* dont_touch = "true" *) output reg[31:0] outputInstruction;

    /* Please fill in the implementation here... */
	/*always@(negedge Clk)
	begin
		currentAddress <= NewPCAddress;
		currentInstruction <= Instruction;
	end
	
	always@(posedge Clk)
	begin
		outputAddress <= currentAddress;
		outputInstruction <= currentInstruction;
	end*/
	
	always@(negedge Clk)
        begin
            
            currentAddress <= currentAddress;
            currentInstruction <= currentInstruction;
            if(En == 1'b1)
            begin
                currentAddress <= NewPCAddress;
                currentInstruction <= Instruction;
            end
            if(Flush == 1'b1)
            begin
                currentAddress <= 32'd0;
                currentInstruction <= 32'd0;
            end
            /*else
            begin
                currentAddress <= currentAddress;
                currentInstruction <= currentInstruction;
            end*/
        end
        
        always@(posedge Clk)
        begin
            outputAddress <= currentAddress;
            outputInstruction <= currentInstruction;
        
        end
	
	
endmodule
