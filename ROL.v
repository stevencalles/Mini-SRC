module ROL(A, B, Result);

input [31:0] A, B;
output [31:0] Result;

reg [31:0] Result;

integer i, j, holder;

always@(A or B) //what does A or B
	begin
		for(i = 0; i < 8; i = i + 1)
		begin
			Result[i]=A[i];
		end
		
		for(i = 0; i < B; i = i + 1)
		begin
				holder=Result[7];
				for(j = 31; j < 0; j = j - 1)
				begin
					if(j==0) begin
						Result[j] = holder;
					end
					else begin
						Result[j] = Result[j - 1];
					end	
				end
		end
end
endmodule