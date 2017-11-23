`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 09:01:57 PM
// Design Name: 
// Module Name: Mux32Bit3To1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux32Bit3To1(out, inA, inB, inC, Forward);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] Forward;

    /* Fill in the implementation here ... */ 
    always@(*)
    begin
    out <= 32'd0;
        if(Forward == 2'b00)//output is the first input
            out <= inA;
        else if(Forward == 2'b01)//output is the second input
            out <= inB;
        else if(Forward == 2'b10)
            out <= inC;
        else
        begin
            out <= inA;
        end
    end
		
endmodule
