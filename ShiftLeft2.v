`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  
// Module - ShiftLeft2.v
// Description - 32-bit shift left 2 component
// 
// INPUTS:-
// ValueToShift: 32-bit input port
// 
// OUTPUTS:-
// ShiftedValue: 32-Bit output port.
//
// FUNCTIONALITY:-
// Design an incrementor (or a hard-wired ADD ALU whose first input is from the 
// PC, and whose second input is a hard-wired 4) that computes the current 
// PC + 4. The result should always be an increment of the signal 'PCResult' by 
// 4 (i.e., PCAddResult = PCResult + 4).
////////////////////////////////////////////////////////////////////////////////

module ShiftLeft2(ValueToShift, ShiftedValue);

    input [31:0]ValueToShift;

    output reg [31:0]ShiftedValue;

    /* Please fill in the implementation here... */
    
    always@(*) begin
	   ShiftedValue <= ValueToShift << 2;
	end
    
endmodule

