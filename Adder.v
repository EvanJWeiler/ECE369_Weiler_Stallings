`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  
// Module - Adder.v
// Description - 32-Bit program counter (PC) adder.
// 
// INPUTS:-
// Address: 32-Bit input port.
// ShiftedValue: 32-bit input port
// 
// OUTPUTS:-
// AddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor (or a hard-wired ADD ALU whose first input is from the 
// PC, and whose second input is a hard-wired 4) that computes the current 
// PC + 4. The result should always be an increment of the signal 'PCResult' by 
// 4 (i.e., PCAddResult = PCResult + 4).
////////////////////////////////////////////////////////////////////////////////

module Adder(Address, ShiftedValue, AddResult);

    input [31:0]Address;
    input [31:0]ShiftedValue;

    output reg [31:0]AddResult;

    /* Please fill in the implementation here... */
    
    always@(*) begin
	   AddResult <= Address + ShiftedValue;
	end
    
endmodule

