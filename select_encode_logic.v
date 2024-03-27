`timescale 1ns/10ps

module select_encode_logic(input [31:0] IR, input Gra, Grb, Grc, Rin, Rout, BAout, output [4:0] opcode, output [31:0] C_sign_extended, output [15:0] R0_15_in, R0_15_out);
	wire [3:0] Ra, Rb, Rc, decoder_in;
	wire [15:0] decoder_out;
	assign Ra = IR[26:23] & {4{Gra}};
	assign Rb = IR[22:19] & {4{Grb}};
	assign Rc = IR[18:15] & {4{Grc}};
	assign decoder_in = Ra | Rb | Rc;
	
	decoder_4_to_16 decode4to16(decoder_in, decoder_out);
	
	assign opcode = IR[31:27];
	assign C_sign_extended = {{13{IR[18]}}, IR[18:0]};
	assign R0_15_in = {16{Rin}} & decoder_out;
	assign R0_15_out = {16{Rout | BAout}} & decoder_out;
endmodule
