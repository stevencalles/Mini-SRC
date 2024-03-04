module SWITCH_TO_NEG(B, Result);

input [31:0] B;
output [31:0] Result;

reg [31:0] Result;

integer i, j, holder;

always@(B) //what does A or B
	begin
		if(B[31]==1)
		begin
			Result=B ^ 32'b11111111111111111111111111111111;    //Xor operation with 1 effectively switch bit-wise
			Result=Result+1;
		end
		else
		begin
			Result=B ^ 32'b11111111111111111111111111111111;	//Xor operation with 1 effectively switch bit-wise
			Result=Result+1;
		end	
end
endmodule