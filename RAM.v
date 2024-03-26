module RAM(input clock, read, write, input [8:0] address, input [31:0] ram_data_in, output reg [31:0] ram_data_out);

    reg [31:0] memory [0:511];
     
     initial begin
        memory[0] <= 32'h01000095;
        memory[149] <= 32'h000000FF;
     end

    always @ (posedge clock) begin 
        if (write == 1) begin
            memory[address] <= ram_data_in;
            end

         ram_data_out <= memory[address];
    end
	 
endmodule 