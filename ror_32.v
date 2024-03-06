module ror_32(input [31:0] A, numRotate, output [31:0] Z);
	reg [31:0] temp;
	always @ (*)
		begin
			temp = ((A >> numRotate) | (A << (32 - numRotate)));
		end
	assign Z = temp;
endmodule 