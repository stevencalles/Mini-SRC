module alu_32(input IncPC, input [31:0] A, B, input [4:0] opcode, output reg[63:0] output_result_c);
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
	Mul= 5'b01111,
	Div= 5'b10000,
	Neg= 5'b10001,
	Not= 5'b10010;


	wire [31:0] IncPC_out, Add_out, Sub_out, Shr_out, Shra_out, Shl_out, Ror_out, Rol_out, And_out, Or_out, InPC_out, Not_out, Neg_out;
	wire [31:0] Mul_HI_out, Mul_LO_out, Div_HI_out, Div_LO_out;
	
	wire add_carry_out, sub_carry_out;
	
	// different ALU operations
	adder	adder(.A(A), .B(B), .Result(Add_out));
	SWITCH_TO_NEG	SWITCH_TO_NEG(.B(B), .Result(Neg_Out));			//add A+(-B)
	and_32 and_32(.A(A), .B(B), .z(And_out));
//	SHR	SHR(.A(A), .B(B), .shr_out(Result));
//	SHRA	SHRA(.A(A), .B(B), .shra_out(Result));
//	SHL	SHL(.A(A), .B(B), .shl_out(Result));
//	ROR	ROR(.A(A), .B(B), .ror_out(Result));
//	ROL	ROL(.A(A), .B(B), .rol_out(Result));
//	or_32	or_32(.A(A), .B(B), .or_out(z));

	always @(*) begin
		case (opcode)
			Add: begin
				output_result_c[31:0] <= Add_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Sub: begin
				output_result_c[31:0] <= Sub_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Shr: begin 
				output_result_c[31:0] <= Shr_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Shra: begin
				output_result_c[31:0] <= Shra_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Shl: begin
				output_result_c[31:0] <= Shl_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Ror: begin
				output_result_c[31:0] <= Ror_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Rol: begin
				output_result_c[31:0] <= Rol_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			And: begin
				output_result_c[31:0] <= And_out;
				output_result_c[63:32] <= 32'd0;
				end
				
			Or: begin
				output_result_c[31:0] <= Or_out;
				output_result_c[63:32] <= 32'd0;
				end
			
			Mul: begin
				output_result_c[31:0] <= Mul_LO_out;
				output_result_c[63:32] <= Mul_HI_out;
				end
			
			Div: begin
				output_result_c[31:0] <= Div_LO_out;
				output_result_c[63:32] <= Div_HI_out;
				end
				
			Neg: begin
				output_result_c[31:0] <= Neg_out;
				output_result_c[63:32] <= 32'd0;
				end	
			
		endcase
	end
endmodule 