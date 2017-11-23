`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module JumpExtension(in, out);

    /* A 16-Bit input word */
    input [25:0] in;
    
    /* A 32-Bit output word */
    output [31:0] out;
    
    /* Fill in the implementation here ... */
	reg [31:0] out;
	reg [27:0] temp;

    always@(*)
    begin
       temp <= {in, 2'b00};//in is essentially shifted left twice without losing any of its bits
	   if(temp[27] == 1'b0)
	   begin
	       out <= {4'h0, temp};
	   end
	   else
	   begin
		   out <= {4'hf, temp};
	   end
    end
		
endmodule
