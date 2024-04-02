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
		
		memory[90] = 32'h00000012;	// random val for second load test
		memory[149] = 32'h00000022; // random value for first ld test
		
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