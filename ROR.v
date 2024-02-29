module ROR(input [31:0] A, numRotate, output [31:0] Result);
    
	 assign Result[31:0] = {A >> numRotate, A << (32 - numRotate)}; 
	 
endmodule 