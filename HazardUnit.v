`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 12:36:24 PM
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(Instruction, ID_EX_RTreg, ID_EX_MemRead, EX_MEM_MemRead, ID_EX_Jump, EX_MEM_Jump, ID_EX_Jr, EX_MEM_Jr, ID_EX_Branch, ID_EX_Zero, PCAdd_Mux_AddOrBranch, PCWrite, IF_ID_Write, IF_ID_Flush, ID_EX_Flush, CheckSignal);

    input[31:0] Instruction;
    input[4:0] ID_EX_RTreg;
    input ID_EX_MemRead, EX_MEM_MemRead, ID_EX_Jump, EX_MEM_Jump, ID_EX_Jr, EX_MEM_Jr, ID_EX_Branch, ID_EX_Zero, PCAdd_Mux_AddOrBranch;
    output reg PCWrite, IF_ID_Write, IF_ID_Flush, ID_EX_Flush, CheckSignal;
    
    initial begin
    CheckSignal <= 1'b0;
    IF_ID_Write <= 1'b1;
    PCWrite <= 1'b1;
    IF_ID_Flush <= 1'b0;
    ID_EX_Flush <= 1'b0;
    end
    
    always@(*)
    begin
    
        CheckSignal <= 1'b0;
        IF_ID_Write <= 1'b1;
        PCWrite <= 1'b1;
        IF_ID_Flush <= 1'b0;
        ID_EX_Flush <= 1'b0;
        
        if(Instruction[20:16] == ID_EX_RTreg && ID_EX_MemRead == 1'b1)// stall example is lw $s3, 4($s3) then add $s1, $s2, $s3
        begin
            CheckSignal <= 1'b1;
            IF_ID_Write <= 1'b0;
            PCWrite <= 1'b0;
        end
        if(Instruction[25:21] == ID_EX_RTreg && ID_EX_MemRead == 1'b1)
        begin
            CheckSignal <= 1'b1;
            IF_ID_Write <= 1'b0;
            PCWrite <= 1'b0;
        end
        if(Instruction[31:26] == 6'b101011 && (ID_EX_MemRead == 1'b1 || EX_MEM_MemRead == 1'b1))
        begin
            CheckSignal <= 1'b1;
            IF_ID_Write <= 1'b0;
            PCWrite <= 1'b0;
        end
        /*if(PCAdd_Mux_AddOrBranch == 1'b1)
        begin
            IF_ID_Flush <= 1'b1;
            ID_EX_Flush <= 1'b1;
        end
        
        if(ID_EX_Jump == 1'b1)//second stall for jump
        begin
            CheckSignal <= 1'b1;
            IF_ID_Write <= 1'b0;
            PCWrite <= 1'b0;
            IF_ID_Flush <= 1'b1;
            ID_EX_Flush <= 1'b1;
        end*/      //j                                   jal                                                      jr
        if(Instruction[31:26] == 6'b000010 || Instruction[31:26] == 6'b000011 || (Instruction[31:26] == 6'b000000 && Instruction[5:0] == 6'b001000) || ID_EX_Jump == 1'b1 || EX_MEM_Jump == 1'b1 || ID_EX_Jr == 1'b1 || EX_MEM_Jr == 1'b1)//unconditional jump will flush datapath 3 times
        begin
            IF_ID_Flush <= 1'b1;
        end
        if((ID_EX_Branch == 1'b1 && ID_EX_Zero) || (PCAdd_Mux_AddOrBranch == 1'b1))
        begin
            IF_ID_Flush <= 1'b1;
            ID_EX_Flush <= 1'b1;
        end
       /* if(EX_MEM_Jump == 1'b1)
        begin
            //CheckSignal <= 1'b1;
            //IF_ID_Write <= 1'b0;
            //PCWrite <= 1'b0;
           IF_ID_Flush <= 1'b1;
           ID_EX_Flush <= 1'b1;
        end*/
    end
    

endmodule
