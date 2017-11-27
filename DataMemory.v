`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, DataMemChoice, RegisterLoadChoice, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input [1:0] DataMemChoice, RegisterLoadChoice;
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] ReadData; // Contents of memory location at Address

    /* Please fill in the implementation here */
    reg[31:0] modifiedReadData;
    reg[31:0] memory[0:1023];
    
    initial begin
        memory[0] = 32'd100;
        memory[1] = 32'd200;
        memory[2] = 32'd300;
        memory[3] = 32'd400;
        memory[4] = 32'd500;
        memory[5] = 32'd600;
        memory[6] = 32'd700;
        memory[7] = 32'd800;
        memory[8] = 32'd900;
        memory[9] = 32'd1000;
        memory[10] = 32'd1100;
        memory[11] = 32'd1200;
       /* memory[0] = 32'd0;
        memory[1] = 32'd1;
        memory[2] = 32'd2;
        memory[3] = 32'd3;
        memory[4] = 32'd4;
        memory[5] = -32'd1;*/
       /* memory[0] = 32'h10;
        memory[1] = 32'h10;
        memory[2] = 32'h4;
        memory[3] = 32'h4;
        memory[4] = 32'h0;
        memory[5] = 32'h1;
        memory[6] = 32'h2;
        memory[7] = 32'h3;
        memory[8] = 32'h0;
        memory[9] = 32'h0;
        memory[10] = 32'h0;
        memory[11] = 32'h0;
        memory[12] = 32'h0;
        memory[13] = 32'h0;
        memory[14] = 32'h0;
        memory[15] = 32'h0;
        memory[16] = 32'h0;
        memory[17] = 32'h0;
        memory[18] = 32'h0;
        memory[19] = 32'h0;
        memory[20] = 32'h1;
        memory[21] = 32'h2;
        memory[22] = 32'h3;
        memory[23] = 32'h4;
        memory[24] = 32'h4;
        memory[25] = 32'h5;
        memory[26] = 32'h6;
        memory[27] = 32'h7;
        memory[28] = 32'h8;
        memory[29] = 32'h9;
        memory[30] = 32'ha;
        memory[31] = 32'hb;
        memory[32] = 32'hc;
        memory[33] = 32'hd;
        memory[34] = 32'he;
        memory[35] = 32'hf;
        memory[36] = 32'h2;
        memory[37] = 32'h3;
        memory[38] = 32'h20;
        memory[39] = 32'h1;
        memory[40] = 32'h2;
        memory[41] = 32'h3;
        memory[42] = 32'hc;
        memory[43] = 32'he;
        memory[44] = 32'h10;
        memory[45] = 32'h12;
        memory[46] = 32'h14;
        memory[47] = 32'h16;
        memory[48] = 32'h18;
        memory[49] = 32'h1a;
        memory[50] = 32'h1c;
        memory[51] = 32'h1e;
        memory[52] = 32'h3;
        memory[53] = 32'h4;
        memory[54] = 32'h1;
        memory[55] = 32'h2;
        memory[56] = 32'h3;
        memory[57] = 32'h4;
        memory[58] = 32'h12;
        memory[59] = 32'h15;
        memory[60] = 32'h18;
        memory[61] = 32'h1b;
        memory[62] = 32'h1e;
        memory[63] = 32'h21;
        memory[64] = 32'h24;
        memory[65] = 32'h27;
        memory[66] = 32'h2a;
        memory[67] = 32'h2d;
        memory[68] = 32'h0;
        memory[69] = 32'h4;
        memory[70] = 32'h2;
        memory[71] = 32'h3;
        memory[72] = 32'h4;
        memory[73] = 32'h5;
        memory[74] = 32'h18;
        memory[75] = 32'h1c;
        memory[76] = 32'h20;
        memory[77] = 32'h24;
        memory[78] = 32'h28;
        memory[79] = 32'h2c;
        memory[80] = 32'h30;
        memory[81] = 32'h34;
        memory[82] = 32'h38;
        memory[83] = 32'h3c;
        memory[84] = 32'h0;
        memory[85] = 32'h5;
        memory[86] = 32'h3;
        memory[87] = 32'h4;
        memory[88] = 32'h5;
        memory[89] = 32'h6;
        memory[90] = 32'h1e;
        memory[91] = 32'h23;
        memory[92] = 32'h28;
        memory[93] = 32'h2d;
        memory[94] = 32'h32;
        memory[95] = 32'h37;
        memory[96] = 32'h3c;
        memory[97] = 32'h41;
        memory[98] = 32'h46;
        memory[99] = 32'h4b;
        memory[100] = 32'h0;
        memory[101] = 32'h6;
        memory[102] = 32'hc;
        memory[103] = 32'h12;
        memory[104] = 32'h18;
        memory[105] = 32'h1e;
        memory[106] = 32'h24;
        memory[107] = 32'h2a;
        memory[108] = 32'h30;
        memory[109] = 32'h36;
        memory[110] = 32'h3c;
        memory[111] = 32'h42;
        memory[112] = 32'h48;
        memory[113] = 32'h4e;
        memory[114] = 32'h54;
        memory[115] = 32'h5a;
        memory[116] = 32'h0;
        memory[117] = 32'h4;
        memory[118] = 32'he;
        memory[119] = 32'h15;
        memory[120] = 32'h1c;
        memory[121] = 32'h23;
        memory[122] = 32'h2a;
        memory[123] = 32'h31;
        memory[124] = 32'h38;
        memory[125] = 32'h3f;
        memory[126] = 32'h46;
        memory[127] = 32'h4d;
        memory[128] = 32'h54;
        memory[129] = 32'h5b;
        memory[130] = 32'h62;
        memory[131] = 32'h69;
        memory[132] = 32'h0;
        memory[133] = 32'h8;
        memory[134] = 32'h10;
        memory[135] = 32'h18;
        memory[136] = 32'h20;
        memory[137] = 32'h28;
        memory[138] = 32'h30;
        memory[139] = 32'h38;
        memory[140] = 32'h40;
        memory[141] = 32'h48;
        memory[142] = 32'h50;
        memory[143] = 32'h58;
        memory[144] = 32'h60;
        memory[145] = 32'h68;
        memory[146] = 32'h70;
        memory[147] = 32'h78;
        memory[148] = 32'h0;
        memory[149] = 32'h9;
        memory[150] = 32'h12;
        memory[151] = 32'h1b;
        memory[152] = 32'h24;
        memory[153] = 32'h2d;
        memory[154] = 32'h36;
        memory[155] = 32'h3f;
        memory[156] = 32'h48;
        memory[157] = 32'h51;
        memory[158] = 32'h5a;
        memory[159] = 32'h63;
        memory[160] = 32'h6c;
        memory[161] = 32'h75;
        memory[162] = 32'h7e;
        memory[163] = 32'h87;
        memory[164] = 32'h0;
        memory[165] = 32'ha;
        memory[166] = 32'h14;
        memory[167] = 32'h1e;
        memory[168] = 32'h28;
        memory[169] = 32'h32;
        memory[170] = 32'h3c;
        memory[171] = 32'h46;
        memory[172] = 32'h50;
        memory[173] = 32'h5a;
        memory[174] = 32'h64;
        memory[175] = 32'h6e;
        memory[176] = 32'h78;
        memory[177] = 32'h82;
        memory[178] = 32'h8c;
        memory[179] = 32'h96;
        memory[180] = 32'h0;
        memory[181] = 32'hb;
        memory[182] = 32'h16;
        memory[183] = 32'h21;
        memory[184] = 32'h2c;
        memory[185] = 32'h37;
        memory[186] = 32'h42;
        memory[187] = 32'h4d;
        memory[188] = 32'h58;
        memory[189] = 32'h63;
        memory[190] = 32'h6e;
        memory[191] = 32'h79;
        memory[192] = 32'h84;
        memory[193] = 32'h8f;
        memory[194] = 32'h9a;
        memory[195] = 32'ha5;
        memory[196] = 32'h0;
        memory[197] = 32'hc;
        memory[198] = 32'h18;
        memory[199] = 32'h24;
        memory[200] = 32'h30;
        memory[201] = 32'h3c;
        memory[202] = 32'h48;
        memory[203] = 32'h54;
        memory[204] = 32'h60;
        memory[205] = 32'h6c;
        memory[206] = 32'h78;
        memory[207] = 32'h84;
        memory[208] = 32'h0;
        memory[209] = 32'h1;
        memory[210] = 32'h2;
        memory[211] = 32'h3;
        memory[212] = 32'h0;
        memory[213] = 32'hd;
        memory[214] = 32'h1a;
        memory[215] = 32'h27;
        memory[216] = 32'h34;
        memory[217] = 32'h41;
        memory[218] = 32'h4e;
        memory[219] = 32'h5b;
        memory[220] = 32'h68;
        memory[221] = 32'h72;
        memory[222] = 32'h82;
        memory[223] = 32'h8f;
        memory[224] = 32'h1;
        memory[225] = 32'h2;
        memory[226] = 32'h3;
        memory[227] = 32'h4;
        memory[228] = 32'h0;
        memory[229] = 32'he;
        memory[230] = 32'h1c;
        memory[231] = 32'h2a;
        memory[232] = 32'h38;
        memory[233] = 32'h46;
        memory[234] = 32'h54;
        memory[235] = 32'h62;
        memory[236] = 32'h70;
        memory[237] = 32'h7e;
        memory[238] = 32'h8c;
        memory[239] = 32'h9a;
        memory[240] = 32'h2;
        memory[241] = 32'h3;
        memory[242] = 32'h4;
        memory[243] = 32'h5;
        memory[244] = 32'h0;
        memory[245] = 32'hf;
        memory[246] = 32'h1e;
        memory[247] = 32'h2d;
        memory[248] = 32'h3c;
        memory[249] = 32'h4b;
        memory[250] = 32'h5a;
        memory[251] = 32'h69;
        memory[252] = 32'h78;
        memory[253] = 32'h87;
        memory[254] = 32'h96;
        memory[255] = 32'ha5;
        memory[256] = 32'h3;
        memory[257] = 32'h4;
        memory[258] = 32'h5;
        memory[259] = 32'h6;
        memory[260] = 32'h0;
        memory[261] = 32'h1;
        memory[262] = 32'h2;
        memory[263] = 32'h3;
        memory[264] = 32'h1;
        memory[265] = 32'h2;
        memory[266] = 32'h3;
        memory[267] = 32'h4;
        memory[268] = 32'h2;
        memory[269] = 32'h3;
        memory[270] = 32'h4;
        memory[271] = 32'h5;
        memory[272] = 32'h3;
        memory[273] = 32'h4;
        memory[274] = 32'h5;
        memory[275] = 32'h6;*/
    end
    
    
    always@(posedge Clk)
    begin
        
       /* if(DataMemChoice == 2'b00)//sw
        begin
            modifiedWriteData[31:0] = WriteData[31:0];
        end
        
        else if(DataMemChoice == 2'b01)//sh
        begin
        
            if(WriteData[15] == 1'b0)
            begin
                modifiedWriteData[31:0] = {16'h0000, WriteData[15:0]};
            end
            else
            begin
                modifiedWriteData[31:0] = {16'hffff, WriteData[15:0]};
            end
        end
        
        else if(DataMemChoice == 2'b10)//sb
        begin
            if(WriteData[7] == 1'b0)
            begin
                modifiedWriteData[31:0] = {24'h000000, WriteData[7:0]};
            end
            else
            begin
                modifiedWriteData[31:0] = {24'hffffff, WriteData[7:0]};
            end
        end
        
        else
        begin
        modifiedWriteData[31:0] <= WriteData[31:0];
        end
        
        if(MemWrite == 1'b1)
        begin
            memory[Address[11:2]] <= modifiedWriteData[31:0];
        end*/
        
        if(MemWrite == 1'b1)
        begin
            if(DataMemChoice == 2'b00)//sw
            begin
                memory[Address[11:2]][31:0] <= WriteData[31:0];
            end
            else if(DataMemChoice == 2'b01)//sh
            begin
                memory[Address[11:2]][15:0] <= WriteData[15:0];
            end
            
            else if(DataMemChoice == 2'b10)//sb
            begin
                memory[Address[11:2]][7:0] <= WriteData[7:0];
            end
            else
            begin
                memory[Address[11:2]] <= WriteData[31:0];
            end
        end
            
        
    end
    
    always@(*)
    begin
        
        if(MemRead == 1'b1)
        begin
            if(RegisterLoadChoice == 2'b00)//lw
            begin
                ReadData <= memory[Address[11:2]];
            end
            else if(RegisterLoadChoice == 2'b01)//lh
            begin
                if(memory[Address[11:2]][15] == 1'b0)
                begin
                    ReadData <= { 16'h0000, memory[Address[11:2]][15:0]};
                end
                else
                begin
                    ReadData <= { 16'hffff, memory[Address[11:2]][15:0]};
                end
            end 
            else if(RegisterLoadChoice == 2'b10)//lb
            begin
                if(memory[Address[11:2]][7] == 1'b0)
                   begin
                       ReadData <= { 24'h000000, memory[Address[11:2]][7:0]};
                   end
                   else
                   begin
                       ReadData <= { 24'hffffff, memory[Address[11:2]][7:0]};
                   end
            end
            else
            begin
                ReadData <= memory[Address[11:2]];
            end
        end
        else
            ReadData <= 32'h00000000;
        
    end

endmodule
