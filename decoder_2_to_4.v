module decoder_2_to_4(input [1:0] dec_in, output reg [3:0] dec_out);

	always@(*) begin
		case(dec_in)
			2'b00 : dec_out <= 4'b0001;
			2'b01 : dec_out <= 4'b0010;
			2'b10 : dec_out <= 4'b0100;
			2'b11 : dec_out <= 4'b1000;
		endcase
	end
	
endmodule 