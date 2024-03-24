module con_ff(input [1:0] IR, input [31:0] BusMuxOut, input CONin, output reg CONout);

	wire [3:0] decode_out;
	wire eq;
	wire not_eq;
	wire pos;
	wire neg;
	wire br_flag;
	
	assign eq = (BusMuxOut == 32'd0) ? 1'b1 : 1'b0;
	assign not_eq = (BusMuxOut != 32'd0) ? 1'b1 : 1'b0;
	assign pos = (BusMuxOut[31] == 0) ? 1'b1 : 1'b0;
	assign neg = (BusMuxOut[31] == 1) ? 1'b1 : 1'b0;
	
	// call 2-4 decoder here with IR as input and decode_out as output
	
	assign br_flag = (decode_out[0] & eq | decode_out[1] & not_eq | decode_out[2] & pos | decode_out[3] & neg);
	
	d_flip_flop CON_d_ff(.clk(CONin), .D(br_flag), .Q(CONout));
	
endmodule 