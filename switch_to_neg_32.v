module switch_to_neg_32(input[31:0] A, output[31:0] Z);
	// just performing 2's complement
	wire [31:0] temp;
	wire Cout;
	not_32 not_32(.A(A), .Z(temp));
	add_32 add_32(.A(temp), .B(32'd1), .Cin(1'b0), .Z(Z), .Cout(Cout));
endmodule 