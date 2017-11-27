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
module ForwardUnit(rs, rt, RegWrite_EX_MEM, RegWrite_MEM_WB, ALUSrc_ID_EX, rd_EX_MEM, rd_MEM_WB, ForwardA, ForwardB, Clk);

    input [4:0] rs, rt, rd_EX_MEM, rd_MEM_WB;
    input RegWrite_EX_MEM, RegWrite_MEM_WB, ALUSrc_ID_EX, Clk;
    
    output reg[1:0] ForwardA, ForwardB;
 
    reg [4:0] Rs_ID_EX, Rs_EX_MEM, Rs_MEM_WB;
    
    initial begin
        ForwardA <= 2'b00;
        ForwardB <= 2'b00;
    end
    
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
        
         if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && (rd_MEM_WB == rt)) // general case, rt is equal to rd from two instructions back
         begin
            ForwardB <= 2'b01;
            //ForwardA <= 2'b00;
         end
      
      if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && (rd_MEM_WB == rs)) // general case, rs is equal to rd from two instructions back
         begin
            ForwardA <= 2'b01;
         end
        
        if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rs)) // general case, rs is equal to the rd from one instruction back
        begin
            ForwardA <= 2'b10;
            //ForwardB <= 2'b00;
        end
        
        if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rt)) // general case, rt is equal to the rd from one instruction back
        begin
            ForwardB <= 2'b10;
            //ForwardA <= 2'b00;
        end
        
        if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && !((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0)) && (rd_EX_MEM == rs) && (rd_MEM_WB == rs)) //cause daddy Akoglu told us to
        begin
            ForwardA <= 2'b01;
            //ForwardB <= 2'b00;
        end
        
         if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && !((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0)) && (rd_EX_MEM == rt) && (rd_MEM_WB == rt)) //cause daddy Akoglu told us to
         begin
            //ForwardA <= 2'b00;
            ForwardB <= 2'b01;
         end
         
         if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB != 5'd0) && (rd_MEM_WB == rs) && ALUSrc_ID_EX == 1'b1)//this is specifically for a load word instruction that was stalled, that is then followed by an instruction requiring an immediate value
         begin
            ForwardB <= 2'b00;
         end
         
         if((RegWrite_MEM_WB == 1'd1) && (rd_MEM_WB!= 5'd0) && (RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rt) && (rd_MEM_WB == rs)) // case where rs is equal to rd from two instructions back and rt is equal to rd from one instruction back
         begin
            ForwardA <= 2'b01;
            ForwardB <= 2'b10;
         end
         
         if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rt) && (rd_EX_MEM == rs)) //case where rs and rt are both equal to rd from one instruction back
         begin
            ForwardA <= 2'b10;
            ForwardB <= 2'b00;
         end
            
         if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rt) && (rs == 5'd0))//sll line in case 3
         begin
            ForwardB <= 2'b10;
         end
         
         if(RegWrite_MEM_WB == 1'd1 && rd_MEM_WB != 5'd0 && rd_MEM_WB == rt && rd_MEM_WB == rs)//case if rd from writeback phase equals both rt and rs
         begin
            ForwardA <= 2'b01;
            ForwardB <= 2'b01;
         end
         
         if(RegWrite_EX_MEM == 1'd1 && rd_EX_MEM != 5'd0 && rd_EX_MEM == rt && rd_EX_MEM == rs)//case if rd from memory phase equals both rt and rs
         begin
            ForwardA <= 2'b10;
            ForwardB <= 2'b10;
         end
            //if((RegWrite_EX_MEM == 1'd1) && (rd_EX_MEM != 5'd0) && (rd_EX_MEM == rs))
              //begin
                //  ForwardA <= 2'b10;
                  //ForwardB <= 2'b00;
              //end
         
         /*else
         begin
            ForwardA <= 2'b00;
            ForwardB <= 2'b00;
         end*/
            
           
         
        
    end

endmodule
