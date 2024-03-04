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
	Or= 5'b01011;


	wire [31:0] Add_out, Sub_out, Shr_out, Shra_out, Shl_out, Ror_out, Rol_out, And_out, Or_out, IncPC_out, Not_out, Neg_Result;

	assign Not_out = ~A;
	
	// different ALU operations
	adder	adder(.A(A), .B(B), .Z(Add_out));
	subtracter()
	SWITCH_TO_NEG	SWITCH_TO_NEG(.B(B), .Result(Neg_Result));	//switch B to -B
	and_32 and_32(.A(A), .B(B), .z(And_out));
	SHR	SHR(.A(A), .shiftNum(B), .Result(shr_out));
	SHRA	SHRA(.A(A), .shiftNum(B), .Result(shra_out));
	SHL	SHL(.A(A), .shiftNum(B), .Result(shl_out));
	ROR	ROR(.A(A), .B(B), .Result(ror_out));
	ROL	ROL(.A(A), .B(B), .Result(rol_out));
	OR OR(.A(A), .B(B), .z(or_out));

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
				endcase
			end	
		endcase
	end
endmodule 