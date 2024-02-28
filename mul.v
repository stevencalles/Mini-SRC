// Ripple Carry Adder
module mul(A, B, Lo, Hi);

input [31:0] A, B;
output [31:0] Lo, Hi;

reg [31:0] Lo, Hi;
reg [15:0] holder;
reg [63:0] FULLNUMBER = 64 'b0, shift;
integer i, j, right;

always@(A or B)
	begin
		for(i = 0; i < 15; i = i + 1)
		begin
			if(i=0)
			begin
			right=0;
			end
			else
			begin
			right=B[i*2-1];
			end
			if(~B[i*2] & ~B[i*2+1] & right) begin
				FULLNUMBER=FULLNUMBER+(A<<(i*2));
			end
			if(~B[i*2] & B[i*2+1] & ~right) begin
				FULLNUMBER=FULLNUMBER+(A<<(i*2));
			end
			if(~B[i*2] & B[i*2+1] & right) begin
				FULLNUMBER=FULLNUMBER+(A<<(i*2+1));
			end
			if(B[i*2] & ~B[i*2+1] & ~right) begin
				FULLNUMBER=FULLNUMBER-(A<<(i*2+1));
			end
			if(B[i*2] & ~B[i*2+1] & right) begin
				FULLNUMBER=FULLNUMBER-(A<<(i*2));
			end
			if(B[i*2] & B[i*2+1] & ~right) begin
				FULLNUMBER=FULLNUMBER-(A<<(i*2));
			end
		end
		Lo=FUllNUMBER[31:0];
		Hi=FULLNUMBER[63:32];
	end
endmodule