`timescale 1ns/10ps
module control_unit(

	input [31:0] IR, 
	input clock, reset, stop

	// removed clock/clear as reg
	output reg PCout, Zlowout, MDRout, Zhighout,
	MARin, PCin, MDRin, IRin, Yin, InPortin, OutPortin,
	BAout, InPortout, Cout,
	LOout, HIin, LOin, HIout,
	Zhighin, Zlowin, Cin,
	IncPC, Read, Write, Rin, Rout,
	Gra, Grb, Grc, CONin,
	holdstate = 0,

	wire [31:0] OutPort_out,
	reg [31:0] InPort_input
);


parameter reset_state = 8’b00000000, fetch0 = 8’b00000001, fetch1 = 8’b00000010, fetch2 = 8’b00000011,
				 add3 = 8'b00000100, add4= 8'b00000101, add5= 8'b00000110, sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001,
				mul3 = 8'b00001010, mul4 = 8'b00001011, mul5 = 8'b00001100, mul6 = 8'b00001101, div3 = 8'b00001110, div4 = 8'b00001111,
				div5 = 8'b00010000, div6 = 8'b00010001, or3 = 8'b00010010, or4 = 8'b00010011, or5 = 8'b00010100, and3 = 8'b00010101, 
				and4 = 8'b00010110, and5 = 8'b00010111, shl3 = 8'b00011000, shl4 = 8'b00011001, shl5 = 8'b00011010, shr3 = 8'b00011011,
				shr4 = 8'b00011100, shr5 = 8'b00011101, rol3 = 8'b00011110, rol4 = 8'b00011111, rol5 = 8'b00100000, ror3 = 8'b00100001,
				ror4 = 8'b00100010, ror5 = 8'b00100011, neg3 = 8'b00100100, neg4 = 8'b00100101, neg5 = 8'b00100110, not3 = 8'b00100111,
				not4 = 8'b00101000, not5 = 8'b00101001, ld3 = 8'b00101010, ld4 = 8'b00101011, ld5 = 8'b00101100, ld6 = 8'b00101101, 
				ld7 = 8'b00101110, ldi3 = 8'b00101111, ldi4 = 8'b00110000, ldi5 = 8'b00110001, st3 = 8'b00110010, st4 = 8'b00110011,
				st5 = 8'b00110100, st6 = 8'b00110101, st7 = 8'b00110110, addi3 = 8'b00110111, addi4 = 8'b00111000, addi5 = 8'b00111001,
				andi3 = 8'b00111010, andi4 = 8'b00111011, andi5 = 8'b00111100, ori3 = 8'b00111101, ori4 = 8'b00111110, ori5 = 8'b00111111,
				br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011, br7 = 8'b11111111, jr3 = 8'b01000100, jal3 = 8'b01000101, 
				jal4 = 8'b01000110, mfhi3 = 8'b01000111, mflo3 = 8'b01001000, in3 = 8'b01001001, out3 = 8'b01001010, nop3 = 8'b01001011, 
				halt3 = 8'b01001100;

	reg [7:0] present_state = 8'b0;
	
always @(posedge clock, posedge reset, posedge stop)
	begin
		// check for reset/stop
		
		if (!holdstate) begin
				case (Present_state)
					Default			:	 Present_state = fetch0
					fetch0			:	 Present_state = fetch1
					fetch1			: 	 Present_state = fetch2
					fetch2			: 	 begin
						
					@(posedge clock);
						// check opcode
						case (IR[31:27])
								5'b00011		:		present_state=add3;	
								5'b00100		: 		present_state=sub3;
								5'b01110		:		present_state=mul3;
								5'b01111		:		present_state=div3;
								5'b00101		:		present_state=shr3;
								5'b00110		:		present_state=shl3;
								5'b00111		:		present_state=ror3;
								5'b01000		:		present_state=rol3;
								5'b01001		:		present_state=and3;
								5'b01010		:		present_state=or3;
								5'b10000		:		present_state=neg3;
								5'b10001		:		present_state=not3;
								5'b00000		:		present_state=ld3;
								5'b00001		:		present_state=ldi3;
								5'b00010		:		present_state=st3;
								5'b01011		:		present_state=addi3;
								5'b01100		:		present_state=andi3;
								5'b01101		:		present_state=ori3;
								5'b10010		:		present_state=br3;
								5'b10011		:		present_state=jr3;
								5'b10100		:		present_state=jal3;
								5'b10111		:		present_state=mfhi3;
								5'b11000		:		present_state=mflo3;
								5'b10101		:		present_state=in3;
								5'b10110		:		present_state=out3;
								5'b11001		:		present_state=nop3;
								5'b11010		:		present_state=halt3;
						endcase
					end // end fetch2 opcode check
				
					add3			: 	Present_state = add4;
					add4			:	Present_state = add5;
					add5 			:	Present_state = fetch0;
			
					addi3			: 	Present_state = addi4;
					addi4			:	Present_state = addi5;
					addi5 		:	Present_state = fetch0;
			
					sub3			: 	Present_state = sub4;
					sub4			: 	Present_state = sub5;
					sub5			:	Present_state = fetch0;
			
					mul3			: 	Present_state = mul4;
					mul4			: 	Present_state = mul5;
					mul5			: 	Present_state = mul6;
					mul6        :	Present_state = fetch0; 
			
					div3			: 	Present_state = div4;
					div4			: 	Present_state = div5;
					div5			: 	Present_state = div6;
					div6			:	Present_state = fetch0;
			
					or3			: 	Present_state = or4;
					or4			: 	Present_state = or5;
					or5			:	Present_state = fetch0;
			
					and3			: 	Present_state = and4;
					and4			: 	Present_state = and5;
					and5   		:	Present_state = fetch0;
			
					shl3			: 	Present_state = shl4;
					shl4			: 	Present_state = shl5;
					shl5 			:	Present_state = fetch0;
			
					shr3			: 	Present_state = shr4;
					shr4			: 	Present_state = shr5;
					shr5 			:	Present_state = fetch0;
			
					rol3			: 	Present_state = rol4;
					rol4			: 	Present_state = rol5;
					rol5 			:	Present_state = fetch0;
		
					ror3			: 	Present_state = ror4;
					ror4			: 	Present_state = ror5;
					ror5 			:	Present_state = fetch0;
			
					neg3			: 	Present_state = neg4;
					neg4			: 	Present_state = fetch0;
			
					not3			: 	Present_state = not4;
					not4			: 	Present_state = fetch0;
			
					ld3			: 	Present_state = ld4;
					ld4			: 	Present_state = ld5;
					ld5			: 	Present_state = ld6;
					ld6			: 	Present_state = ld7;
					ld7			:  Present_state = fetch0;
			
					ldi3			: 	Present_state = ldi4;
					ldi4			: 	Present_state = ldi5;
					ldi5 			:	Present_state = fetch0;
			
					st3			: 	Present_state = st4;
					st4			: 	Present_state = st5;
					st5			: 	Present_state = st6;
					st6			: 	Present_state = st7;
					st7 			:	Present_state = fetch0;
			
					andi3			: 	Present_state = andi4;
					andi4			: 	Present_state = andi5;
					andi5 		:	Present_state = fetch0;
					
					ori3			: 	Present_state = ori4;
					ori4			: 	Present_state = ori5;
					ori5 			:	Present_state = fetch0;
			
					jal3			: 	Present_state = jal4;
					jal4 			:	Present_state = fetch0;
			
					jr3 			:	Present_state = fetch0;
			
					br3			: 	Present_state = br4;
					br4			: 	Present_state = br5;
					br5			: 	Present_state = br6;
					br6  			:	Present_state = br7;
					br7  			:	Present_state = fetch0;
			
					out3 			:	Present_state = fetch0;
			
					in3 			:	Present_state = fetch0;
			
					mflo3 		:	Present_state = fetch0;
			
					mfhi3 		:	Present_state = fetch0;
			
					nop3 			:	Present_state = fetch0;
					
				endcase // present state case switch	
			end 			// end holdstate
		end
		
always @(present_state) begin
	case (present_state)
		reset_state: begin
			PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; InPortout <= 0; HIout <= 0; LOout <= 0; BAout <= 0;
			PCin <= 0; Zlowin <= 0; MDRin <= 0; MARin <= 0; InPortin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
         Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0;
         IncPC <= 0; Read <= 0; Write <= 0; Cout <= 0; JAL_flag <= 0;
			// Reset <= 1;
			// Clear <= 1;
			// RUn <= 1;
         //InPort_input <= 32'd0;
			// missing zhighin?
		end
		fetch0: begin
			PCout <= 1; MARin <= 1; IncPC <= 1; Zlowin <= 1;
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; Zlowin <= 0;
		end
		fetch1: begin
			Zlowout <= 1; PCin <= 1; read <= 1; MDRin <= 1;
			#15 Zlowout <= 0; PCin <= 0; read <= 0; MDRin <= 0;
		end
		fetch2: begin
			MDRout <= 1; IRin <= 1;
			#15 MDRout <= 0; IRin <= 0;
		end
	
	
		// specific instructions
		add3, sub3: begin
			
		end

	
	
	endcase
end		
endmodule