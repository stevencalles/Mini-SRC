module SHRA (A, B, Result);

input [31:0] A, B;
output [31:0] Result;

reg [31:0] Result;

integer i, j;

always@(A or B) //what does A or B
	begin
		
		for(i = 0; i < 32; i = i + 1)
		begin
			Result[i]=A[i];
		end
		
		for(i = 0; i < B; i = i + 1)
		begin
				for(j = 0; j < 32; j = j + 1)
				begin
					if(j==31) begin
					end
					else begin
						Result[j] = Result[j+1];
					end
				end
		end
end
endmodule