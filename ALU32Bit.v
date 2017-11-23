`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, HIreg_read, LOreg_read, HIreg_write, LOreg_write, returnAddress);

	input [10:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B, HIreg_read, LOreg_read, returnAddress;	    // inputs

	output reg[31:0] ALUResult;
	output reg[31:0] HIreg_write;
	output reg[31:0] LOreg_write;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	reg[63:0] tempResult;
	reg[63:0] tempResult2;
	
	initial begin
	
        ALUResult <= 32'd0;
        Zero <= 1'b0;
        HIreg_write <= 32'd0;
        LOreg_write <= 32'd0;
        tempResult <= 64'd0;
        tempResult2 <= 64'd0;
        
    end
	
	always@(*)
	begin
	
		case(ALUControl[5:0])
			
			6'b000000: //add CHECKED
			begin
				ALUResult = A + B;
				Zero = 1'b0;

				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b000001: //addu CHECKED
			begin
				ALUResult = $unsigned(A) + $unsigned(B);
			    
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b000010: //and CHECKED
			begin
				ALUResult = A & B;

				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b000011: //sub CHECKED
			begin
				ALUResult = A - B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			
			6'b000100: //mult CHECKED
			begin
				tempResult = $signed(A) * $signed(B);
				HIreg_write = tempResult[63:32];
				LOreg_write = tempResult[31:0];
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
				tempResult2 <= 64'd0;
			end
			
			6'b000101: //multu CHECKED
			begin
				tempResult = $unsigned(A) * $unsigned(B);
				HIreg_write = tempResult[63:32];
				LOreg_write = tempResult[31:0];
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
				tempResult2 <= 64'd0;
			end
			
			6'b000110: //mthi CHECKED
			begin
				HIreg_write = $signed(A);
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b000111: //mtlo CHECKED
			begin
				LOreg_write = A;
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001000: //mfhi CHECKED
			begin
				ALUResult = HIreg_read;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001001: //mflo CHECKED
			begin
				ALUResult = LOreg_read;

				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001010: //jr
			begin
				ALUResult <= A;
				Zero <= 1'b1;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001011: //or CHECKED
			begin
				ALUResult = A | B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001100: //nor CHECKED
			begin
				ALUResult = ~(A | B);
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001101: //xor CHECKED
			begin
				ALUResult = A ^ B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001110: //sll CHECKED
			begin
				ALUResult = B << ALUControl[10:6];
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b001111: //slt CHECKED
			begin
				if(A < B)
				begin
					ALUResult = 32'd1;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = 32'd0;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			6'b010000: //sltu CHECKED
			begin
				if($unsigned(A) < $unsigned(B))
				begin
					ALUResult = 32'd1;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = 32'd0;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
					
				end
			end
			
			6'b010001: //sra CHECKED
			begin
				ALUResult = $signed(B) >> ALUControl[10:6];
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b010010: //srav CHECKED
			begin
				ALUResult = $signed(B) >> A;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b010011: //srl CHECKED
			begin
				ALUResult = B >> ALUControl[10:6];
			
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b010100: //srlv CHECKED
			begin
				ALUResult = B >> A;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b010101: //sllv CHECKED
			begin
				ALUResult = B << A;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b010110: //movn CHECKED
			begin
				if(B != 1'b0)
				begin
					ALUResult = A;
					Zero = 1'b0;
					
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
				    Zero = 1'b1;
					
					ALUResult <= 32'd0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			6'b010111: //movz CHECKED
			begin
				if(B == 1'b0)
				begin
					ALUResult = A;
					Zero = 1'b0;
					
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
				    Zero = 1'b1;
					
					ALUResult <= 32'd0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			6'b011000: //rotrv B is rotated right by A times CHECKED
			begin
				tempResult[31:0] = B;
				tempResult2[31:0] = B;
				tempResult = tempResult >> A;
				tempResult2 = tempResult2 << (32 - A);
				ALUResult = tempResult[31:0] | tempResult2[31:0];
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_write;
				
			end
			
			6'b011001: //rotr B is rotated right by sa times CHECKED
			begin
				tempResult[31:0] = B;
				tempResult2[31:0] = B;
				tempResult = tempResult >> ALUControl[10:6];
				tempResult2 = tempResult2 << (32 - ALUControl[10:6]);
				ALUResult = tempResult[31:0] | tempResult2[31:0];
				
                Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
			end
			
			6'b011010: //addi CHECKED
			begin
				tempResult = {16'd0, A[15:0]};
				if(tempResult + B == 32'd65536)
				begin
				    ALUResult = 32'd0;
				end
				else
				begin
				    ALUResult = tempResult + B;
				end
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b011011: //addiu CHECKED
			begin
				tempResult = {16'd0, A[15:0]};
				ALUResult = tempResult + B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b011100: //andi CHECKED
			begin
				tempResult = {16'd0, A[15:0]};
				ALUResult = tempResult & B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b011101: //beq
			begin
			
			    if(A == B)
			    begin
			        Zero <= 1'b1;
			    end
			    else
			    begin
			        Zero <= 1'b0;
			    end
			    
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b011110: //mul CHECKED
			begin
				tempResult = A * B;
				ALUResult = tempResult[31:0];
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b011111: //madd CHECKED 1168 
			begin
				tempResult = $signed(A) * $signed(B);
				tempResult2[63:32] = HIreg_read;
				tempResult2[31:0] = LOreg_read;
				tempResult2 = $signed(tempResult2) + $signed(tempResult);
				HIreg_write = tempResult2[63:32];
				LOreg_write = tempResult2[31:0];
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
			end
			
			6'b100000: //msub CHECKED 1360
			begin
				tempResult = $signed(A) * $signed(B);
				tempResult2[63:32] = HIreg_read;
				tempResult2[31:0] = LOreg_read;
				tempResult2 = $signed(tempResult2) - $signed(tempResult);
				HIreg_write = tempResult2[63:32];
				LOreg_write = tempResult2[31:0];
				
				ALUResult <= 32'd0;
				Zero <= 1'b0;
			end
			
			6'b100001: //lw
			begin
				ALUResult <= $signed(A) + $signed(B);
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100010: //sw
			begin
				ALUResult <= $signed(A) + $signed(B);
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100011: //sb
			begin
				ALUResult <= $signed(A) + $signed(B);
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100100: //lb
			begin
				ALUResult <= $signed(A) + $signed(B);
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100101: //lh
			begin
				ALUResult <= $signed(A) + $signed(B);
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100110: //sh
			begin
				ALUResult <= $signed(A) + $signed(B);
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b100111: //lui
			begin
			    ALUResult <= {B, 16'd0};
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101000: //bgez
			begin
			    if(A[31] == 1'b0)
			    begin
			         Zero <= 1'b1;
			    end
			    else
			    begin
			         Zero <= 1'b0;
			    end
			
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101001: //bltz
			begin
			    if(A[31] == 1)
			    begin
			        Zero <= 1'b1;
			    end
			    else
			    begin
			        Zero <= 1'b0;
			    end
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101010: //bne
			begin
			
			    if(A != B)
			    begin
			        Zero <= 1'b1;
			    end
			    else
			    begin
			        Zero <= 1'b0;
			    end
			    
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101011: //bgtz
			begin
			    if(A[31] == 1)
			    begin
			        Zero <= 1'b0;
			    end
			    else if(A == 32'd0)
			    begin
			        Zero <= 1'b0;
			    end
			    else
			    begin
			        Zero <= 1'b1;
			    end
			    
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101100: //blez
			begin
			    if(A[31] == 1'b1)
			    begin
			        Zero <= 1'b1;
			    end
			    else if(A == 32'd0)
			    begin
			        Zero <= 1'b1;
			    end
			    else
			    begin
			        Zero <= 1'b0;
			    end
				ALUResult <= 32'd0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101101: //j
			begin
				ALUResult <= 32'd0;
				Zero <= 1'b1;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101110: //jal
			begin
				ALUResult <= returnAddress;
				Zero <= 1'b1;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult <= 64'd0;
				tempResult2 <= 64'd0;
			end
			
			6'b101111: //ori CHECKED
			begin
				tempResult = {16'd0, A[15:0]};
				ALUResult <= tempResult | B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b110000: //xori CHECKED
			begin 
				tempResult = {16'd0, A[15:0]};
				ALUResult = tempResult ^ B;
				
				Zero <= 1'b0;
				HIreg_write <= HIreg_read;
				LOreg_write <= LOreg_read;
				tempResult2 <= 64'd0;
			end
			
			6'b110001: //seh CHECKED
			begin
				if(B[15] == 1)
				begin
					ALUResult = B | 32'hffff0000;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = B & 32'h0000ffff;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
			    end
			end
			
			6'b110010: //seb CHECKED
			begin
				if(B[7] == 1)
				begin
					ALUResult = B | 32'hffffff00;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = B & 32'h000000ff;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			6'b110011: //slti CHECKED
			begin
				if(A < B)
				begin
					ALUResult = 32'd1;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = 32'd0;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			6'b110100: //sltiu CHECKED
			begin
				if($unsigned(A) < $unsigned(B))
				begin
					ALUResult = 32'd1;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
				else
				begin
					ALUResult = 32'd0;
					
					Zero <= 1'b0;
					HIreg_write <= HIreg_read;
					LOreg_write <= LOreg_read;
					tempResult <= 64'd0;
					tempResult2 <= 64'd0;
				end
			end
			
			default:
			begin	
				ALUResult = 32'd0;
                HIreg_write = HIreg_read;
                LOreg_write = LOreg_read;
                Zero = 1'd0;
                tempResult = 64'd0;
                tempResult2 = 64'd0;
            end
		endcase	
		
		/*if(ALUResult == 32'd0)
		  Zero <= 1'b1;*/
	end
endmodule



// //////////////////////////

// control code thing

  // add: 000000 100000
 // addi: 001000 
// addiu: 001001
 // addu: 000000 100001
  // and: 000000 100100
 // andi: 001100
  // beq: 000100
  // sub: 000000 100010
  // 
  
  
  
  
  
  
  
//  : 011100 000010
 // mult: 000000 011000
// multu: 000000 011001
 // madd: 011100 000000
 // msub: 011100 000100
   // lw: 100011
   // sw: 101011
   // sb: 101000
   // lb: 100000
   // lh: 100001
   // sh: 101001
 // mthi: 000000 010001
 // mtlo: 000000 010011
 // mfhi: 000000 010000
 // mflo: 000000 010010
  // lui: 001111 
 // bgez: 000001
  // bne: 000101
 // bgtz: 000111
 // blez: 000110
 // bltz: 000001
    // j: 000010
   // jr: 000000 001000
  // jal: 000011
   // or: 000000 100101
  // nor: 000000 100111
  // xor: 000000 100110
  // ori: 001101
 // xori: 001110
  // seh: 011111 100000
  // sll: 000000 000000
  // slt: 000000 101010
 // slti: 001010
// sltiu: 001011
 // sltu: 000000 101011
  // sra: 000000 000011
 // srav: 000000 000111
  // srl: 000000 000010
 // srlv: 000000 000110
 // sllv: 000000 000100
 // movn: 000000 001011
 // movz: 000000 001010
// rotrv: 000000 000110
 // rotr: 000000 000010
  // seb: 011111 100000

//groups of instructions:

// 000000: add, addu, and, sub, mult, multu, mthi, mtlo, mfhi, mflo, jr, or, nor, xor, sll, slt, sltu, sra, srav, srl, srlv, sllv, movn, movz, rotrv, rotr
// 001000: addi
// 001001: addiu
// 001100: andi
// 000100: beq
// 011100: mul, madd, msub
// 100011: lw
// 101011: sw
// 101000: sb
// 100000: lb
// 100001: lh
// 101001: sh
// 001111: lui
// 000001: bgez, bltz
// 000101: bne
// 000111: bgtz
// 000110: blez
// 000010: j
// 000011: jal
// 001101: ori
// 001110: xori
// 011111: seh, seb
// 001010: slti
// 001011: sltiu


////////////////////////////