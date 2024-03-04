module ror_32(input [31:0] A, numRotate, output [31:0] Z);
    
	 assign Z[31:0] = {A >> numRotate, A << (32 - numRotate)}; 
	 
endmodule 