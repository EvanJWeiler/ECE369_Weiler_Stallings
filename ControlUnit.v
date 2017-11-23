`timescale 1ns / 1ps

module ControlUnit(Instruction, ALUOp, ALUSrc, RegDst, Branch, MemWrite, MemRead, Mem2Reg, RegWrite, DataMemChoice, RegisterLoadChoice, Jump, Jal, Jr);

	input [31:0]Instruction;
	
	output reg ALUSrc, RegDst, Branch, MemWrite, MemRead, Mem2Reg, RegWrite, Jump, Jal, Jr;
	output reg [1:0] DataMemChoice, RegisterLoadChoice;//00 for entire word, 01 for halfword, 10 for lsb 8 bits, 11 means nothing
	output reg [10:0]ALUOp;
	
	always@(*)
	begin
	
	
	ALUOp = 11'd0;
	ALUSrc = 1'b0;
	RegDst = 1'b0;
	Branch = 1'b0;
	MemWrite = 1'b0;
	MemRead = 1'b0;
	Mem2Reg = 1'b0;
	RegWrite = 1'b0;
	DataMemChoice = 2'b00;
	RegisterLoadChoice = 2'b00;
	Jump = 1'b0;
	Jal = 1'b0;
	Jr = 1'b0;
	
		//rs = A, rt = B/immediate, rd = ALUResult
		case(Instruction[31:26])
			
			6'b000000: //add, addu, and, sub, mult, multu, mthi, mtlo, mfhi, mflo, jr, or, nor, xor, sll, slt, sltu, sra, srav, srl, srlv, sllv, movn, movz, rotrv, rotr
			begin
				//shift amount bits 10:6
				case(Instruction[5:0])
					
					6'b100000: //add rd = rs + rt
					begin
						ALUOp <= 11'b00000000000;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					
					end
					
					6'b100001: //addu
					begin
						ALUOp <= 11'b00000000001;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
                        
					end
					
					6'b100100: //and
					begin
						ALUOp <= 11'b00000000010;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b100010: //sub
					begin
						ALUOp <= 11'b00000000011;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b011000: //mult
					begin
						ALUOp <= 11'b00000000100;
						ALUSrc <= 1'b0;
						RegDst <= 1'b0;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b0;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b011001: //multu
					begin
						ALUOp <= 11'b00000000101;
						ALUSrc <= 1'b0;
						RegDst <= 1'b0;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b0;
						DataMemChoice <= 2'b00;
					    RegisterLoadChoice = 2'b00;
						
					end
					
					6'b010001: //mthi
					begin
						ALUOp <= 11'b00000000110;
						ALUSrc <= 1'b0;
						RegDst <= 1'b0;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b0;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b010011: //mtlo
					begin
						ALUOp <= 11'b00000000111;
						ALUSrc <= 1'b0;
						RegDst <= 1'b0;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b0;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b010000: //mfhi
					begin
						ALUOp <= 11'b00000001000;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b010010: //mflo
					begin
						ALUOp <= 11'b00000001001;  
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
					    RegisterLoadChoice = 2'b00;
					end
			
					6'b001000: //jr
					begin
						ALUOp <= 11'b00000001010; //NOPE
						ALUSrc <= 1'b1;
                        RegDst <= 1'b0;
                        Branch <= 1'b1;
                        MemWrite <= 1'b0;
                        MemRead <= 1'b0;
                        Mem2Reg <= 1'b0;
                        RegWrite <= 1'b0;
                        DataMemChoice <= 2'b00;
                        RegisterLoadChoice = 2'b00;
                        Jump <= 1'b1;
                        Jr <= 1'b1;
					end
					
					6'b100101: //or
					begin
						ALUOp <= 11'b00000001011;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
					    RegisterLoadChoice = 2'b00;
					end
					
					6'b100111: //nor
					begin
						ALUOp <= 11'b00000001100;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b100110: //xor
					begin
						ALUOp <= 11'b00000001101;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b000000: //sll
					begin
						ALUOp <= {Instruction[10:6],6'b001110};//11'b00000001110; //SHIFTAMOUNT
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b101010: //slt
					begin
						ALUOp <= 11'b00000001111;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b101011: //sltu
					begin
						ALUOp <= 11'b00000010000;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b000011: //sra
					begin
						ALUOp <= {Instruction[10:6],6'b010001};//11'b00000010001; //SHIFTAMOUNT
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
				        RegisterLoadChoice = 2'b00;
					end
					
					6'b000111: //srav
					begin
						ALUOp <= 11'b00000010010;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
					    RegisterLoadChoice = 2'b00;
					end
					
					6'b000010: //srl + rotr
					begin
						if(Instruction[21] == 1'b0) //srl
						begin
							ALUOp <= {Instruction[10:6],6'b010011};//11'b00000010011; //SHIFTAMOUNT
							ALUSrc <= 1'b0;
							RegDst <= 1'b1;
							Branch <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							Mem2Reg <= 1'b1;
							RegWrite <= 1'b1;
							DataMemChoice <= 2'b00;
							RegisterLoadChoice = 2'b00;
						end
						
						if(Instruction[21] == 1'b1) //rotr
						begin
							ALUOp <= {Instruction[10:6],6'b011001};//11'b00000011001; //SHIFTAMOUNT
							ALUSrc <= 1'b0;
							RegDst <= 1'b1;
							Branch <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							Mem2Reg <= 1'b1;
							RegWrite <= 1'b1;
							DataMemChoice <= 2'b00;
							RegisterLoadChoice = 2'b00;
						end
					end
					
					6'b000110: //srlv + rotrv
					begin
						if(Instruction[6] == 1'b0) //srlv
						begin
							ALUOp <= 11'b00000010100;
							ALUSrc <= 1'b0;
							RegDst <= 1'b1;
							Branch <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							Mem2Reg <= 1'b1;
							RegWrite <= 1'b1;
							DataMemChoice <= 2'b00;
							RegisterLoadChoice = 2'b00;
						end
						
						if(Instruction[6] == 1'b1) //rotrv
						begin
							ALUOp <= 11'b00000011000;
							ALUSrc <= 1'b0;
							RegDst <= 1'b1;
							Branch <= 1'b0;
							MemWrite <= 1'b0;
							MemRead <= 1'b0;
							Mem2Reg <= 1'b1;
							RegWrite <= 1'b1;
							DataMemChoice <= 2'b00;
							RegisterLoadChoice = 2'b00;
						end
					end
					
					6'b000100: //sllv
					begin
						ALUOp <= 11'b00000010101;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b0;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b001011: //movn
					begin
						ALUOp <= 11'b00000010110;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
					
					6'b001010: //movz
					begin
						ALUOp <= 11'b00000010111;
						ALUSrc <= 1'b0;
						RegDst <= 1'b1;
						Branch <= 1'b1;
						MemWrite <= 1'b0;
						MemRead <= 1'b0;
						Mem2Reg <= 1'b1;
						RegWrite <= 1'b1;
						DataMemChoice <= 2'b00;
						RegisterLoadChoice = 2'b00;
					end
				endcase
			end
				
			6'b001000: //addi
			begin
				ALUOp <= 11'b00000011010;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
			    RegisterLoadChoice = 2'b00;
			end
			
			6'b001001: //addiu
			begin
				ALUOp <= 11'b00000011011;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
			    RegisterLoadChoice = 2'b00;
			end
			
			6'b001100: //andi
			begin
				ALUOp <= 11'b00000011100;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
			    RegisterLoadChoice = 2'b00;
			end
			
			6'b000100: //beq
			begin
				ALUOp <= 11'b00000011101;
				ALUSrc <= 1'b0;
                RegDst <= 1'b0;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b011100: //mul (bits 5:0 are 000010), madd (bits 5:0 are 000000), msub (bits 5:0 are 000100)
			begin
				if(Instruction[5:0] == 6'b000010) //mul
				begin
					ALUOp <= 11'b00000011110;
					ALUSrc <= 1'b0;
					RegDst <= 1'b1;
					Branch <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					Mem2Reg <= 1'b1;
					RegWrite <= 1'b1;
					DataMemChoice <= 2'b00;
					RegisterLoadChoice = 2'b00;
				end
				
				if(Instruction[5:0] == 6'b000000) //madd
				begin
					ALUOp <= 11'b00000011111;
					ALUSrc <= 1'b0;
					RegDst <= 1'b0;
					Branch <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					Mem2Reg <= 1'b1;
					RegWrite <= 1'b0;
					DataMemChoice <= 2'b00;
					RegisterLoadChoice = 2'b00;
				end
				
				if(Instruction[5:0] == 6'b000100) //msub
				begin
					ALUOp <= 11'b00000100000;
					ALUSrc <= 1'b0;
					RegDst <= 1'b0;
					Branch <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					Mem2Reg <= 1'b1;
					RegWrite <= 1'b0;
					DataMemChoice <= 2'b00;
					RegisterLoadChoice = 2'b00;
				end
			end
			
			6'b100011: //lw
			begin
				ALUOp <= 11'b00000100001;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b1;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b1;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b101011: //sw
			begin
				ALUOp <= 11'b00000100010;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b1;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b101000: //sb
			begin
				ALUOp <= 11'b00000100011;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b1;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b10;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b100000: //lb
			begin
				ALUOp <= 11'b00000100100;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b1;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b1;
                DataMemChoice <= 2'b10;
                RegisterLoadChoice = 2'b10;
			end
			
			6'b100001: //lh
			begin
				ALUOp <= 11'b00000100101;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b1;
                MemRead <= 1'b1;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b1;
                DataMemChoice <= 2'b01;
                RegisterLoadChoice = 2'b01;
			end
			
			6'b101001: //sh
			begin
				ALUOp <= 11'b00000100110;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b1;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b01;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b001111: //lui
			begin
				ALUOp <= 11'b00000100111;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b1;
                RegWrite <= 1'b1;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b000001: //bgez (bits 20:16 = 00001), bltz (bits 20:16 = 00000)
			begin
				if(Instruction[20:16] == 5'b00001) //bgez
				begin
					ALUOp <= 11'b00000101000;
					ALUSrc <= 1'b1;
                    RegDst <= 1'b0;
                    Branch <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    Mem2Reg <= 1'b0;
                    RegWrite <= 1'b0;
                    DataMemChoice <= 2'b00;
                    RegisterLoadChoice = 2'b00;
				end
				
				if(Instruction[20:16] == 5'b00000) //bltz
				begin
					ALUOp <= 11'b00000101001;
					ALUSrc <= 1'b1;
                    RegDst <= 1'b0;
                    Branch <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    Mem2Reg <= 1'b0;
                    RegWrite <= 1'b0;
                    DataMemChoice <= 2'b00;
                    RegisterLoadChoice = 2'b00;
				end
			end
			
			6'b000101: //bne
			begin
				ALUOp <= 11'b00000101010;
				ALUSrc <= 1'b0;
                RegDst <= 1'b0;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b000111: //bgtz
			begin
				ALUOp <= 11'b00000101011;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b000110: //blez
			begin
				ALUOp <= 11'b00000101100;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
                
			end
			
			6'b000010: //j
			begin
				ALUOp <= 11'b00000101101;
				ALUSrc <= 1'b1;
                RegDst <= 1'b0;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b0;
                RegWrite <= 1'b0;
                DataMemChoice <= 2'b00;
                Jump <= 1'b1;
                RegisterLoadChoice = 2'b00;
			end
			
			6'b000011: //jal
			begin
				ALUOp <= 11'b00000101110;
				ALUSrc <= 1'b1;
                RegDst <= 1'b1;
                Branch <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                Mem2Reg <= 1'b1;
                RegWrite <= 1'b1;
                DataMemChoice <= 2'b00;
                RegisterLoadChoice = 2'b00;
                Jump <= 1'b1;
                Jal <= 1'b1;
			end
			
			6'b001101: //ori
			begin
				ALUOp <= 11'b00000101111;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
				RegisterLoadChoice = 2'b00;
				
			end
			
			6'b001110: //xori
			begin
				ALUOp <= 11'b00000110000;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
			    RegisterLoadChoice = 2'b00;
				
			end
			
			6'b011111: //seh (bits 10:6(5) are 11000, seb (bits 10:6(5) are 10000)
			begin
				if(Instruction[10:6] == 5'b11000) //seh
				begin
					ALUOp <= 11'b00000110001;
					ALUSrc <= 1'b0;
					RegDst <= 1'b1;
					Branch <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					Mem2Reg <= 1'b1;
					RegWrite <= 1'b1;
					DataMemChoice <= 2'b00;
					RegisterLoadChoice = 2'b00;
					
				end
				
				if(Instruction[10:6] == 5'b10000) //seh
				begin
					ALUOp <= 11'b00000110010;
					ALUSrc <= 1'b0;
					RegDst <= 1'b1;
					Branch <= 1'b0;
					MemWrite <= 1'b0;
					MemRead <= 1'b0;
					Mem2Reg <= 1'b1;
					RegWrite <= 1'b1;
					DataMemChoice <= 2'b00;
				    RegisterLoadChoice = 2'b00;
					
				end
			end
			
			6'b001010: //slti
			begin
				ALUOp <= 11'b00000110011;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
			    RegisterLoadChoice = 2'b00;
				
			end
			
			6'b001011: //sltiu
			begin
				ALUOp <= 11'b00000110100;
				ALUSrc <= 1'b1;
				RegDst <= 1'b0;
				Branch <= 1'b0;
				MemWrite <= 1'b0;
				MemRead <= 1'b0;
				Mem2Reg <= 1'b1;
				RegWrite <= 1'b1;
				DataMemChoice <= 2'b00;
				RegisterLoadChoice = 2'b00;
				
			end
		endcase
	end
endmodule
	
	
//groups of instructions:

// 000000: add, addu, and, sub, mult, multu, mthi, mtlo, mfhi, mflo, jr, or, nor, xor, sll, slt, sltu, sra, srav, srl, srlv, sllv, movn, movz, rotrv, rotr 26zr
// 001000: addi ---
// 001001: addiu ---
// 001100: andi ---
// 000100: beq ---
// 011100: mul, madd, msub ---
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