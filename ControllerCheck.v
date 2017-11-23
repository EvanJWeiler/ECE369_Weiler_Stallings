`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 12:26:31 PM
// Design Name: 
// Module Name: ControllerCheck
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


module ControllerCheck(Check, ALUOpIn, ALUSrcIn, RegDstIn, BranchIn, MemWriteIn, MemReadIn, Mem2RegIn, RegWriteIn, DataMemChoiceIn, RegisterLoadChoiceIn, JumpIn, JalIn, JrIn, ALUOpOut, ALUSrcOut, RegDstOut, BranchOut, MemWriteOut, MemReadOut, Mem2RegOut, RegWriteOut, DataMemChoiceOut, RegisterLoadChoiceOut, JumpOut, JalOut, JrOut);
    input Check;
    input ALUSrcIn, RegDstIn, BranchIn, MemWriteIn, MemReadIn, Mem2RegIn, RegWriteIn, JumpIn, JalIn, JrIn;
    input [1:0] DataMemChoiceIn, RegisterLoadChoiceIn;
    input [10:0] ALUOpIn;
    
    output reg ALUSrcOut, RegDstOut, BranchOut, MemWriteOut, MemReadOut, Mem2RegOut, RegWriteOut, JumpOut, JalOut, JrOut;
    output reg [1:0] DataMemChoiceOut, RegisterLoadChoiceOut;
    output reg [10:0] ALUOpOut;
    
    always@(*)
    begin
        if(Check == 1'b0)
        begin
            ALUSrcOut <= ALUSrcIn;
            RegDstOut <= RegDstIn;
            BranchOut <= BranchIn;
            MemWriteOut <= MemWriteIn;
            MemReadOut <= MemReadIn;
            Mem2RegOut <= Mem2RegIn;
            RegWriteOut <= RegWriteIn;
            JumpOut <= JumpIn;
            JalOut <= JalIn;
            JrOut <= JrIn;
            DataMemChoiceOut <= DataMemChoiceIn;
            RegisterLoadChoiceOut <= RegisterLoadChoiceIn;
            ALUOpOut <= ALUOpIn;
        end
        else
        begin
            ALUSrcOut <= 1'b0;
            RegDstOut <= 1'b0;
            BranchOut <= 1'b0;
            MemWriteOut <= 1'b0;
            MemReadOut <= 1'b0;
            Mem2RegOut <= 1'b0;
            RegWriteOut <= 1'b0;
            JumpOut <= 1'b0;
            JalOut <= 1'b0;
            JrOut <= 1'b0;
            DataMemChoiceOut <= 2'b00;
            RegisterLoadChoiceOut <= 2'b00;
            ALUOpOut <= 11'b00000000000;
        end
    end
endmodule
