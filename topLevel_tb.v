`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Percent Effort: Evan Weiler: 50%, David Stallings: 50%
// 
// Create Date: 10/17/2017 07:02:04 PM
// Design Name: 
// Module Name: topLevel_tb
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


module topLevel_tb();

	reg Clk, Reset;
	wire [31:0] PCResult, Mux_Mem2Reg_Out, hi_out, lo_out;
	
	topLevel tl_0(
	       .Reset(Reset),
	       .Clk(Clk),
	       .PCResult(PCResult),
	       .Mux_Mem2Reg_Out(Mux_Mem2Reg_Out),
	       .HIreg_read(hi_out),
	       .LOreg_read(lo_out)
	);
	
	//Reset, Clk, PCResult, Mux_Mem2Reg_Out, hi_out, lo_out);
	
	initial begin
        
        Reset <= 1'b1;
        #150;
        Reset <= 1'b0;
        #10000;
        
    end

    initial begin
    
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
		
	end
    
endmodule
