module alu_32(input InPC, input [31:0] A, B, input [4:0] opcode, output reg[31:0] output_result, HI, LO);
	parameter 
	Add= 5'b00011,		//R-Format OP codes
	Sub= 5'b00100,
	Shr= 5'b00101,
	Shra= 5'b00110,
	Shl= 5'b00111,
	Ror= 5'b01000,
	Rol= 5'b01001,
	And= 5'b01010,
	Or= 5'b01011;
	
	Mul=5'b01111;
	Div=5'b10000;
	Not=5'b10010;
	Neg=5'b10001;


	wire [31:0] Add_out, Sub_out, Shr_out, Shra_out, Shl_out, Ror_out, Rol_out, And_out, Or_out, InPC_out, Not_out, Neg_Result, lo, hi;

	assign Not_out = ~A;
	
	// different ALU operations
	mul mul(.A(A), .B(B), .lo(Lo), .hi(Hi);
	adder	adder(.A(A), .B(B), .Add_out(Result));
	SWITCH_TO_NEG	SWITCH_TO_NEG(.B(B), .Neg_Result(Result));	//switch B to -B
	adder subber(.A(A), .Neg_Result(B), .Sub_out(Result));			//add A+(-B)
	and_32 and_32(.A(A), .B(B), .And_out(z));
	SHR	SHR(.A(A), .B(B), .Shr_out(Result));
	SHRA	SHRA(.A(A), .B(B), .Shra_out(Result));
	SHL	SHL(.A(A), .B(B), .Shl_out(Result));
	ROR	ROR(.A(A), .B(B), .Ror_out(Result));
	ROL	ROL(.A(A), .B(B), .Rol_out(Result));
	or_32	or_32(.A(A), .B(B), .or_out(z));
	SWITCH_TO_NEG	A(.A(A), .Neg_A(Result));

	always @ (*) begin
		case (InPC)
			1'b1: begin
			LO <= A+4;
			end
			1'b0: begin
					case (opcode)
						Add: begin
							output_result = Add_out;
							end
						Sub: begin
							output_result = Sub_out;
							end
						Shr: begin 
							output_result = Shr_out;
							end
						Shra: begin
							output_result = Shra_out;
							end
						Shl: begin
							output_result = Shl_out;
						Ror: begin
							output_result = Ror_out;
							end
						Rol: begin
							output_result = Rol_out;
							end
						And: begin
							output_result = And_out;
							end
						Or: begin
							output_result = Or_out;
							end
						Mul: begin
							LO = Lo;
							HI = HI;
							end
						Div: begin
							output_result = Or_out;
							end
						Not: begin
							output_result = Not_out;
							end
						Neg: begin
							output_result = Neg_A;
							end
					end
			endcase
		end
		endcase
end
endmodule
