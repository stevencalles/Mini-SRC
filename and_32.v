module and_32(input[31:0] A, B, output[31:0] z);

genvar i;
generate
	for (i=0; i < 32; i=i+1) begin : loop
		assign z[i] = ((A[i] & B[i]));
	end
endgenerate
endmodule 