


//There are some places where a logical shift was used and should not have been	



module Div(Q, M, Quo, R);

input [31:0] Q, M;
output [31:0] Quo, R;

reg [31:0] Result;
reg [31:0]  A=32b'0;
A=Q;
integer i;

always@(Q or M) //what does A or B
	begin
		
		for(i = 0; i < 32; i = i + 1)
		begin
		
			A=A<<1;
			A=A+Q[31];
			Q=Q<<1;
			A=A-M;
			if(A<0) begin
				A=M+A;
			end
			else begin
				Q=Q+1;
			end
			if(a<0) begin
				A=A+M;
			end
		end
		Quo=Q;
		R=A;
	end
endmodule