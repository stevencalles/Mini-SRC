module sub_32(input [31:0] A, input [31:0] B, input Cin, output [31:0] Z, output Cout);
	wire [31:0] neg_B;	// this is gonna hold (-B)
	switch_to_neg_32 switch_to_neg_32(.A(B), .Z(neg_B));
	add_32 add_32(.A(A), .B(neg_B), .Cin(Cin), .Z(Z), .Cout(Cout));
endmodule
