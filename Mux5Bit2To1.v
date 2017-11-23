`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux5Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always@(*)
    begin
    out <= 5'b00000;
        if(sel == 0)//output is the first input
            out <= inA;
        else if(sel == 1)//output is the second input
            out <= inB;
    end
		
endmodule
