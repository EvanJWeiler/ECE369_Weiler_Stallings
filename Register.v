`timescale 1ns / 1ps

module Register(ReadData, WriteData, Clk);

	input Clk;
	input[31:0] WriteData;
	
	output reg[31:0] ReadData;
	
	initial begin
		ReadData <= 32'd0;
	end
	
	always@(posedge Clk)
	begin
		ReadData <= WriteData;	
	end
	
endmodule