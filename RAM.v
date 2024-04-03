module RAM(input clock, read, write, input [8:0] address, input [31:0] ram_data_in, output [31:0] ram_data_out);

    reg [31:0] memory [0:511];
    reg [31:0] addressReg;
	 
	 initial begin
		memory[0] = 32'h01000095;	// ld R2, 0x95
		memory[1] = 32'h00100038;	// ld R0, 0x38(R2)
		
		memory[2] = 32'h09000095;	// ldi R2, 0x95
		memory[3] = 32'h08100038;	// ldi R0, 0x38(R2)
		
		memory[4] = 32'h10800087;	// st 0x87, R1
		memory[5] = 32'h10880087;	// st 0x87(R1), R1
		
		memory[6] = 32'h61a7fffb; // addi R3, R4, -5
		memory[7] = 32'h69a00053; // andi R3, R4, 0x53
		memory[8] = 32'h71a00053; // ori R3, R4, 0x53
		
		memory[9] = 32'h9a80000e; // brzr R5, 14
		memory[10] = 32'h9a88000e; // brnz R5, 14
		memory[11] = 32'h9a90000e; // brpl R5, 14
		memory[12] = 32'h9a98000e; // brmi R5, 14
		
		memory[13] = 32'ha3000000;	// jr R6
		memory[14] = 32'hab000000; // jal R6
		
		memory[15] = 32'hc3000000; // mfhi R6
		memory[16] = 32'hcb800000; // mflo R7
		
		memory[17] = 32'hb9800000; // out R3
		memory[18] = 32'hb2000000; // in R4



	
		memory[24] = 32'h00000000;		// location just to show that there is something here for branch instr
		memory[23] = 32'h00000000;		// location just to show that there is something here for branch instr
		memory[25] = 32'h00000000;		// location just to show that there is something here for branch instr
		memory[26] = 32'h00000000;		// location just to show that there is something here for branch instr

		memory[27] = 32'h00000000;	// spot where jr R6 takes you
		memory[28] = 32'h00000000; // spot where jal takes you
		
	
		
		memory[90] = 32'h00000012;	// random val for second load test
		memory[149] = 32'h00000022; // random value for first load test
		
     end
	  
	  
//     initial begin
//        $readmemh("RAM.ram.txt", memory);
//	  end
      
    always @ (posedge clock) begin 
        if (write == 1) begin
            memory[address] <= ram_data_in;
            end

         addressReg <= address;
    end
     
     assign ram_data_out = memory[addressReg];
     
endmodule 