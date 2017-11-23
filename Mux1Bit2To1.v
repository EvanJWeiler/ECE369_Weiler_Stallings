`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux1Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux1Bit2To1(out, inA, inB, sel);

    output reg out;
    
    input inA;
    input inB;
    input sel;

    /* Fill in the implementation here ... */ 
    always@(*)
    begin
        if(sel == 0)//output is the first input
            out <= inA;
        else//output is the second input
            out <= inB;
    end
		
endmodule
