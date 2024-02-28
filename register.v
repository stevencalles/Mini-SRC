module register #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clock, clear, enable, 
	input [DATA_WIDTH_IN-1:0]BusMuxOut,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn
);
reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;
always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				q <= BusMuxOut;
			end
		end
	assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];
endmodule

module registerMDR (input clear, clock, enable, read, input[31:0] BusMuxOut, Mdatain, output[31:0] MDRout);
wire [31:0] MDRin;
mux_2_1 MDMux(BusMuxOut, Mdatain, read, MDRin);
register reg_MDR(clear, clock, enable, MDRin, MDRout);
endmodule
