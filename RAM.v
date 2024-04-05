module RAM(input clock, read, write, input [8:0] address, input [31:0] ram_data_in, output [31:0] ram_data_out);

    reg [31:0] memory [0:511];
    reg [31:0] addressReg;
	 
	 initial begin
	 
	 // PHASE 2 INSTRUCTIONS
	 
//		memory[0] = 32'h01000095;	// ld R2, 0x95
//		memory[1] = 32'h00100038;	// ld R0, 0x38(R2)
//		
//		memory[2] = 32'h09000095;	// ldi R2, 0x95
//		memory[3] = 32'h08100038;	// ldi R0, 0x38(R2)
//		
//		memory[4] = 32'h10800087;	// st 0x87, R1
//		memory[5] = 32'h10880087;	// st 0x87(R1), R1
//		
//		memory[6] = 32'h61a7fffb; // addi R3, R4, -5
//		memory[7] = 32'h69a00053; // andi R3, R4, 0x53
//		memory[8] = 32'h71a00053; // ori R3, R4, 0x53
//		
//		memory[9] = 32'h9a80000e; // brzr R5, 14
//		memory[10] = 32'h9a88000e; // brnz R5, 14
//		memory[11] = 32'h9a90000e; // brpl R5, 14
//		memory[12] = 32'h9a98000e; // brmi R5, 14
//		
//		memory[13] = 32'ha3000000;	// jr R6
//		memory[14] = 32'hab000000; // jal R6
//		
//		memory[15] = 32'hc3000000; // mfhi R6
//		memory[16] = 32'hcb800000; // mflo R7
//		
//		memory[17] = 32'hb9800000; // out R3
//		memory[18] = 32'hb2000000; // in R4
//
//	
//		memory[24] = 32'h00000000;		// location just to show that there is something here for branch instr
//		memory[23] = 32'h00000000;		// location just to show that there is something here for branch instr
//		memory[25] = 32'h00000000;		// location just to show that there is something here for branch instr
//		memory[26] = 32'h00000000;		// location just to show that there is something here for branch instr
//
//		memory[27] = 32'h00000000;	// spot where jr R6 takes you
//		memory[28] = 32'h00000000; // spot where jal takes you
//		
//	
//		memory[90] = 32'h00000012;	// random val for second load test
//		memory[149] = 32'h00000022; // random value for first load test

	// PHASE 3 INSTRUCTIONS
	
		memory[0] = 32'h09000069; // ldi r2, 0x69
		memory[1] = 32'h09100002; // ldi r2, 2(r2)
		memory[2] = 32'h00800047; // ld r1, 0x47
		memory[3] = 32'h08880001; // ldi r1, 1(r1)
		memory[4] = 32'h000ffff9; // ld r0, -7(r1)
		memory[5] = 32'h09800003; // ldi r3, 3
		memory[6] = 32'h09000043; // ldi r2, 0x43
		memory[7] = 32'h99180003; // brmi r2, 3
		memory[8] = 32'h09100006; // ldi r2, 6(r2)
		memory[9] = 32'h0397fffe; // ld r7, -2(r2)
		memory[10] = 32'hd0000000; // nop
		memory[11] = 32'h9b900002; // brpl r7, 2 
		memory[12] = 32'h0a900004; // ldi r5, 4(r2)
		memory[13] = 32'h0a2ffffd; // ldi r4, -3(r5)
		memory[14] = 32'h19118000; // add r2, r2, r3,	AKA "target:"
		memory[15] = 32'h63b80003; // addi r7, r7, 3
		memory[16] = 32'h8bb80000; // neg r7, r7
		memory[17] = 32'h93b80000; // not r7, r7
		memory[18] = 32'h6bb8000f; // andi r7, r7, 0xF
		memory[19] = 32'h40818000; // ror r1, r0, r3
		memory[20] = 32'h73880009; // ori r7, r1, 9
		memory[21] = 32'h30b98000; // shra r1, r7, r3
		memory[22] = 32'h29118000; // shr r2, r2, r3 
		memory[23] = 32'h1100008e; // st 0x8E, r2
		memory[24] = 32'h49018000; // rol r2, r0, r3
		memory[25] = 32'h5a180000; // or r4, r3, r0 
		memory[26] = 32'h50900000; // and r1, r2, r0
		memory[27] = 32'h12080027; // st 0x27(r1), r4
		memory[28] = 32'h20120000; // sub r0, r2, r4 
		memory[29] = 32'h38918000; // shl r1, r2, r3
		memory[30] = 32'h0a000006; // ldi r4, 6
		memory[31] = 32'h0a80001b; // ldi r5, 0x1B
		memory[32] = 32'h7aa00000; // mul r5, r4
		memory[33] = 32'hc3800000; // mfhi r7
		memory[34] = 32'hcb000000; // mflo r6
		memory[35] = 32'h82a00000; // div r5, r4
		memory[36] = 32'h0d200001; // ldi r10, 1(r4)
		memory[37] = 32'h0daffffe; // ldi r11, -2(r5)
		memory[38] = 32'h0e300000; // ldi r12, 0(r6)
		memory[39] = 32'h0eb80003; // ldi r13, 3(r7)
		memory[40] = 32'hae000000; // jal r12
		memory[41] = 32'hd8000000; // halt
		
		// location 0xA2, where program jumps to from jal 12 instruction (subA)
		memory[162] = 32'h1cd60000; // add r9, r10, r12
		memory[163] = 32'h245e8000; // sub r8, r11, r13
		memory[164] = 32'h24cc0000; // sub r9, r9, r8
		memory[165] = 32'ha7800000; // jr r15
		
		memory[71] = 32'h00000094; // value for ld r1, 0x47
		memory[142] = 32'h00000034; // value for ld r0, 7(r1)
		
     end
      
    always @ (posedge clock) begin 
        if (write == 1) begin
            memory[address] <= ram_data_in;
            end

         addressReg <= address;
    end
     
     assign ram_data_out = memory[addressReg];
     
endmodule 