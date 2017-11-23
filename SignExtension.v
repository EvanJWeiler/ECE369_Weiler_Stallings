`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output [31:0] out;
    
    /* Fill in the implementation here ... */
	reg [31:0] out;

    always@(*)
    begin
        out <= 32'h00000000;
        if(in[15] == 1'b0) //if input is positive, then we simply do an OR statement against a 32 bit number 0
            out <= in | 32'h00000000;
        else if(in[15] == 1'b1)//if input is negative, then do an OR statement against a 32 bit number of 1’s for first 16, then all 0’s
            out <= in | 32'hffff0000;
    end
		
endmodule
