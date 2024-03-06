
module div_32(input [31:0] A, M, output reg [31:0] Quo, R);
	reg [31:0] temp_Quo, temp_R;
	always @ (*)
		begin 
			temp_R = A % M;
			temp_Quo = (A - temp_R) / M;
			begin
				Quo = temp_Quo;
				R = temp_R;
			end
		end
endmodule 