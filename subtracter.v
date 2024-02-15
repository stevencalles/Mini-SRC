module subtracter(input [31:0] A, input [31:0] B, output [31:0] difference);

	wire [31:0] twos_compliment_A;
	wire [31:0] negative_A;
	wire [31:0] one;
	assign one = 32'b0_0000_0000_0000_0000_0000_0000_0001;
	assign negative_A = ~A;
	
	adder perform_2s_comp(
		.negative_A(A), 
		.one(B), 
		.twos_compliment_A(Result)
		);
		
	adder final_op(
		.twos_compliment_A(A), 
		.B(B), 
		.difference(Result)
		);
		
endmodule
