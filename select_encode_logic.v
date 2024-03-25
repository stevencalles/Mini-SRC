`timescale 1ns/10ps

module select_encode_logic(input [31:0] IR, input Gra, Grb, Grc, Rin, Rout, BAout, output [4:0] opcode, output [31:0] C_sign_extended, [15:0] R0_15_in, R0_15_out);
	wire [3:0] Ra, Rb, Rc, decoder_in;
	wire [15:0] decoder_out;
	assign RA = IR[26:23] & {4{Gra}};
	assign RB = IR[22:19] & {4{Grb}};
	assign RC = IR[18:15] & {4{Grc}};
	assign decoder_in = RA | RB | RC;
	
	decoder_4_to_16 decode4to16(decoder_in, decoder_out);
	
	assign opcode = IR[31:27];
	assign C_sign_extended = {{13{IR[18]}}, IR[18:0]};
	assign R0_15_in = {16{Rin}} & R_dec_out;
	assign R0_15_out = {16{Rout | BAout}} & R_dec_out;
endmodule
