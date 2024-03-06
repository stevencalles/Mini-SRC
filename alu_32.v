module alu_32(input IncPC, input [31:0] A, B, input [4:0] opcode, output reg[31:0] C_out_HI, C_out_LO);
	parameter 
	Add= 5'b00011,		//R-Format OP codes
	Sub= 5'b00100,
	Shr= 5'b00101,
	Shra= 5'b00110,
	Shl= 5'b00111,
	Ror= 5'b01000,
	Rol= 5'b01001,
	And= 5'b01010,
	Or= 5'b01011,
	Div= 5'b10000,
	Mul= 5'b01111,
	Neg= 5'b10001,
	Not= 5'b10010;


	wire [31:0] Add_out, Sub_out, Shr_out, Shra_out, Shl_out, Ror_out, Rol_out, And_out, Or_out, IncPC_out, Not_out, Neg_out, Mul_HI, Mul_LO, Div_HI, Div_LO;
	wire Add_Cout, Sub_Cout;
	
	// different ALU operations
	add_32 add_32(.A(A), .B(B), .Cin(1'b0), .Z(Add_out), .Cout(Add_Cout));
	sub_32 sub_32(.A(A), .B(B), .Cin(1'b0), .Z(Sub_out), .Cout(Sub_Cout));
	switch_to_neg_32	switch_to_neg_32(.A(B), .Z(Neg_out));	//switch B to -B
	and_32 and_32(.A(A), .B(B), .Z(And_out));
	shr_32 shr_32(.A(A), .shiftNum(B), .Z(Shr_out));
	shra_32 shra_32(.A(A), .shiftNum(B), .Z(Shra_out));
	shl_32 shl_32(.A(A), .shiftNum(B), .Z(Shl_out));
	ror_32 ror_32(.A(A), .numRotate(B), .Z(Ror_out));
	rol_32 rol_32(.A(A), .numRotate(B), .Z(Rol_out));
	mul_32 mul_32(.A(A), .B(B), .HI(Mul_HI), .LO(Mul_LO));
	div_32 div_32(.A(A), .M(B), .Quo(Div_LO), .R(Div_HI));
	or_32 or_32(.A(A), .B(B), .Z(Or_out));
	not_32 not_32(.A(B), .Z(Not_out));		//switch B to NOT B, messed up before, B gets input into this, not reg Y (or A as we're calling it)

	always @ (*) begin
		case (IncPC)
			1'b1: begin
			C_out_LO <= IncPC_out;
			C_out_HI <= 32'd0;
			end
			1'b0: begin
					case (opcode)
						Add: begin
							C_out_LO <= Add_out;
							C_out_HI <= 32'd0;
							end
						Sub: begin
							C_out_LO <= Sub_out;
							C_out_HI <= 32'd0;
							end
						Shr: begin 
							C_out_LO <= Shr_out;
							C_out_HI <= 32'd0;
							end
						Shra: begin
							C_out_LO <= Shra_out;
							C_out_HI <= 32'd0;
							end
						Shl: begin
							C_out_LO <= Shl_out;
							C_out_HI <= 32'd0;
							end
						Ror: begin
							C_out_LO <= Ror_out;
							C_out_HI <= 32'd0;
							end
						Rol: begin
							C_out_LO <= Rol_out;
							C_out_HI <= 32'd0;
							end
						And: begin
							C_out_LO <= And_out;
							C_out_HI <= 32'd0;
							end
						Or: begin
							C_out_LO <= Or_out;
							C_out_HI <= 32'd0;
							end
						Div: begin
							C_out_LO <= Div_LO;
							C_out_HI <= Div_HI;
							end
						Mul: begin
							C_out_LO <= Mul_LO;
							C_out_HI <= Mul_HI;
							end
						Neg: begin
							C_out_LO <= Neg_out;
							C_out_HI <= 32'd0;
							end
						Not: begin
							C_out_LO <= Not_out;
							C_out_HI <= 32'd0;
							end
				endcase
			end	
	endcase
end
endmodule
