// 32 bit Carry lookahead adder
module add_32(input [31:0] A, B, input Cin, output [31:0] Z, output Cout);
	wire Cout1;

	add_16 a1_16 (.A(A[15:0]), .B(B[15:0]), .Cin(Cin), .Z(Z[15:0]), .Cout(Cout1));
	add_16 a2_16 (.A(A[31:16]), .B(B[31:16]), .Cin(Cout1), .Z(Z[31:16]), .Cout(Cout));

endmodule

module add_16(input [15:0] A, B, input Cin, output [15:0] Z, output Cout);

	wire Cout1, Cout2, Cout3;
	add_4 a1_4 (.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .Z(Z[3:0]), .Cout(Cout1));
	add_4 a2_4 (.A(A[7:4]), .B(B[7:4]), .Cin(Cout1), .Z(Z[7:4]), .Cout(Cout2));
	add_4 a3_4 (.A(A[11:8]), .B(B[11:8]), .Cin(Cout2), .Z(Z[11:8]), .Cout(Cout3));
	add_4 a4_4 (.A(A[15:12]), .B(B[15:12]), .Cin(Cout3), .Z(Z[15:12]), .Cout(Cout));

endmodule

module add_4(input [3:0] A, B, input Cin, output [3:0] Z, output Cout);

	wire [3:0] P, G, c;
	assign P = A ^ B;
	assign G = A & B;
	
	assign c[0] = Cin;
	assign c[1] = G[0] | (P[0] & c[0]);
	assign c[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c[0]);
	assign c[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c[0]);
	assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c[0]);
	assign Z[3:0] = P^c;
	
endmodule
	