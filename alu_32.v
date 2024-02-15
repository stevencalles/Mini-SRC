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


	wire [31:0] Add_out, Sub_out, Shr_out, Shra_out, Shl_out, Ror_out, Rol_out, And_out, Or_out, InPC_out, Not_out;

	assign Not_out = ~A;
	
	// different ALU operations
	adder	adder(.A(A), .B(B), .Add_out(Result));
	subtracter subtracter(.A(A), .B(B), .Sub_out(Difference));
	and_32 and_32(.A(A), .B(B), .And_out(z));

	always @ (*) begin
	//	case (InPC)
	//		1'b1: begin
	//		LO <= 
	//		end
		case (opcode)
//			Add: begin
//				output_result = Add_out;
//				end
//			Sub: begin
//				output_result = Sub_out;
//				end
//			Shr: begin 
//				Shr_out = A >> 1;
//				output_result = Shr_out;
//				end
//			Shra: begin
//				Shra_out = A >>> 1;
//				output_result = Shra_out;
//				end
//			Shl: begin
//				Shl_out = A << 1;
//				output_result = Shl_out;
//			Ror: begin
//				// perform ror
//				// do we need a module for this?
//				end
//			Rol: begin
//				// rol
//				end
			And: begin
				output_result = And_out;
				end
//			Or: begin
//				Or_out = A || B;
//				output_result = Or_out;
//				end
		endcase
	end
endmodule 