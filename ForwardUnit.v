`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 07:58:26 PM
// Design Name: 
// Module Name: ForwardUnit
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

//rs is Instruction[25:21]
//rt is Instruction[20:16]
//regwrite comes in immediately after the EX_MEM pipeline register
//rd_EX_MEM comes in after the EX_MEM pipeline register
//rd_MEM_WB comes in after the MEM_WB pipeline register
//Mem2Reg comes in after the final mux
module ForwardUnit(rs, rt, RegWrite_EX_MEM, RegWrite_MEM_WB, rd_EX_MEM, rd_MEM_WB, ForwardA, ForwardB, Clk);

    input [4:0] rs, rt, rd_EX_MEM, rd_MEM_WB;
    input RegWrite_EX_MEM, RegWrite_MEM_WB, Clk;
    
    output reg[1:0] ForwardA, ForwardB;
 
    reg [4:0] Rs_ID_EX, Rs_EX_MEM, Rs_MEM_WB;
    
    always@(*)
    begin
        ForwardA <= 2'b00;
        ForwardB <= 2'b00;
        
       
        /*if((rs == rd_MEM_WB) && (rt == rd_EX_MEM))
        begin
            ForwardA <= 2'b01;
            ForwardB <= 2'b10;
        end
        else if(rs == rd_EX_MEM)
        begin
            ForwardA <= 2'b10;
            ForwardB <= 2'b00;
        end
        else if(rt == rd_EX_MEM)
        begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b10;
        end
        else if(rs == rd_MEM_WB)
        begin
            ForwardA <= 2'b01;
            ForwardB <= 2'b00;
        end
        else if(rt == rd_MEM_WB)
        begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b01;
        end
        else
        begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b00;
        end*/
        
        if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && (rd_EX_MEM == rs) && (rd_MEM_WB == rt))
        begin
            ForwardA <= 2'b10;
            ForwardB <= 2'b01;
        end
        
        else if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rs))
        begin
            ForwardA <= 2'b10;
            ForwardB <= 2'b00;
        end
        
        else if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rt))
        begin
            ForwardB <= 2'b10;
            ForwardA <= 2'b00;
        end
        
        else if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && !((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0)) && (rd_EX_MEM == rs) && (rd_MEM_WB == rs))
        begin
            ForwardA <= 2'b01;
            ForwardB <= 2'b00;
        end
        
         else if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && !((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0)) && (rd_EX_MEM == rt) && (rd_MEM_WB == rt))
         begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b01;
         end
         
         else
         begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b00;
         end
            
           
         
        
    end

endmodule
