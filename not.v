// Ripple Carry Adder
module mul(A, Result);

input [31:0] A, B;
output [31:0] Result;

reg [31:0] Result;

integer i, j;

always@(A)
	begin
		
		for(i = 0; i < 32; i = i + 1)
		begin
			if(A[i])
				begin
				Result[i]=0;
				end
			else 
				begin
				Result[i]=1;
				end
		end
	end
endmodule