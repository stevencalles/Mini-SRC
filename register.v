module register(
	input wire clock, 
	input wire clear,
	input wire enable,
	input wire [31:0] BusMuxOut,
	output reg [31:0] BusMuxIn
);
//reg [DATA_WIDTH_IN-1:0]q;
initial BusMuxIn = 0;
always @ (posedge clock) begin 
			if (clear) begin
				BusMuxIn <= 32'b0;
			end
			else if (enable) begin
				BusMuxIn <= BusMuxOut;
			end
	end
endmodule

module registerMDR(input clock, clear, enable, read, input[31:0] BusMuxOut, Mdatain, output[31:0] MDRout);
	wire [31:0] MDRin;
	mux_2_1 MDMux(BusMuxOut, Mdatain, read, MDRin);
	register reg_MDR(clock, clear, enable, MDRin, MDRout);
endmodule