module RAM(input clock, read, write, input [8:0] address, input [31:0] ram_data_in, output [31:0] ram_data_out);

    reg [31:0] memory [0:511];
     reg [31:0] addressReg;
     
     initial begin
        $readmemh("RAM.ram.txt", memory);
        end
      
    always @ (posedge clock) begin 
        if (write == 1) begin
            memory[address] <= ram_data_in;
            end

         addressReg <= address;
    end
     
     assign ram_data_out = memory[addressReg];
     
endmodule 