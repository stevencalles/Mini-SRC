`timescale 1ns/10ps
// for some reason our states weren't holding long enough and timing was off, but this main structure is correct
module control_unit(output reg Gra, Grb, Grc, Rin, Rout, CONin, BAout,
							PCout, Zhighout, Zlowout, MDRout, MDRin, MARin, IRin, PCin, InPortout, OutPortin, InPortin, OutPortout,
							Yin, HIin, LOin, Cout, Zhighin, Zlowin, LOout, HIout, JAL_flag, Run,
							Read, Write, IncPC, 
							input [31:0] IR,
							input clock, clear, stop);
							
	// defining ALU opcodes
	parameter 
	Load = 5'b00000,	Loadi = 5'b00001,	Store = 5'b00010,
	Addi = 5'b01100,	Andi = 5'b01101,	Ori = 5'b01110,	Branch = 5'b10011,	Jr = 5'b10100,
	Jal = 5'b10101, In = 5'b10110,	Out = 5'b10111,	Mfhi = 5'b11000,	Mflo = 5'b11001, 	Add= 5'b00011,		
	Sub= 5'b00100,	Shr= 5'b00101,	Shra= 5'b00110, Shl= 5'b00111,	Ror= 5'b01000,	Rol= 5'b01001,
	And= 5'b01010,	Or= 5'b01011,	Div= 5'b10000,	Mul= 5'b01111,	Neg= 5'b10001, Not= 5'b10010,
	Nop=5'b11010, Halt= 5'b11011;
	
	// define control state machine for all instruction types
	parameter Reset_state = 7'd0, T0 = 7'd1, T1 = 7'd2, T2 = 7'd3,
	add3 = 7'd4, add4 = 7'd5, add5 = 7'd6, sub3 = 7'd7, sub4 = 7'd8, sub5 = 7'd9,
	mul3 = 7'd10, mul4 = 7'd11, mul5 = 7'd12, mul6 = 7'd13, div3 = 7'd14, div4 = 7'd15, div5 = 7'd16, div6 = 7'd17,
	and3 = 7'd18, and4 = 7'd19, and5 = 7'd20, or3 = 7'd21, or4 = 7'd22, or5 = 7'd23, 
	shl3 = 7'd24, shl4 = 7'd25, shl5 = 7'd26, shr3 = 7'd27, shr4 = 7'd28, shr5 = 7'd29, 
	rol3 = 7'd30, rol4 = 7'd31, rol5 = 7'd32, ror3 = 7'd33, ror4 = 7'd34, ror5 = 7'd35, 
	neg3 = 7'd36, neg4 = 7'd37, not3 = 7'd38, not4 = 7'd39, shra3 = 7'd40, shra4 = 7'd41, shra5 = 7'd42, 
	ld3 = 7'd43, ld4 = 7'd44, ld5 = 7'd45, ld6 = 7'd46, ld7 = 7'd47, ldi3 = 7'd48, ldi4 = 7'd49, ldi5 = 7'd50, 
	st3 = 7'd51, st4 = 7'd52, st5 = 7'd53, st6 = 7'd54, st7 = 7'd55, 
	addi3 = 7'd56, addi4 = 7'd57, addi5 = 7'd58, andi3 = 7'd59, andi4 = 7'd60, andi5 = 7'd61, ori3 = 7'd62, ori4 = 7'd63, ori5 = 7'd64,
	br3 = 7'd65, br4 = 7'd66, br5 = 7'd67, br6 = 7'd68, _jr = 7'd69, jal3 = 7'd70, jal4 = 7'd71, jal5 = 7'd72, _in = 7'd73, _out = 7'd74,
	_mfhi = 7'd75, _mflo = 7'd76, _nop = 7'd77, _halt = 7'd78;
	
	reg [6:0] Present_state = Reset_state;
	
	always @(posedge clock, posedge clear, posedge stop)
		begin
			if (clear == 1'b1) Present_state = Reset_state;
			if (stop == 1'b1) Present_state = _halt;
			case (Present_state)
				Reset_state: Present_state = T0;
				T0: Present_state = T1;
				T1: Present_state = T2;
				T2: begin
					case (IR[31:27])
						Add: Present_state = add3;
						Sub: Present_state = sub3;
						And: Present_state = and3;
						Or: Present_state = or3;
						Shr: Present_state = shr3;
						Shra: Present_state = shra3;
						Shl: Present_state = shl3;
						Ror: Present_state = ror3;
						Rol: Present_state = rol3;
						Addi: Present_state = addi3;
						Andi: Present_state = andi3;
						Ori: Present_state = ori3;
						Mul: Present_state = mul3;
						Div: Present_state = div3;
						Neg: Present_state = neg3;
						Not: Present_state = not3;
						Load: Present_state = ld3;
						Loadi: Present_state = ldi3;
						Store: Present_state = st3;
						Branch: Present_state = br3;
						Jr: Present_state = _jr;
						Jal: Present_state = jal3;
						In: Present_state = _in;
						Out: Present_state = _out;
						Mfhi: Present_state = _mfhi;
						Mflo: Present_state = _mflo;
						Nop: Present_state = _nop;
						Halt: Present_state = _halt;
						default: Present_state = Reset_state;
					endcase
				end	// end T2
			
			ld3: Present_state = ld4;
			ld4: Present_state = ld5;
			ld5: Present_state = ld6;
			ld6: Present_state = ld7;
			ld7: Present_state = T0;
			
			ldi3: Present_state = ldi4;
			ldi4: Present_state = ldi5;
			ldi5: Present_state = T0;
			
			st3: Present_state = st4;
			st4: Present_state = st5;
			st5: Present_state = st6;
			st6: Present_state = st7;
			st7: Present_state = T0;
			
			add3: Present_state = add4;
			add4: Present_state = add5;
			add5: Present_state = T0;
			
			addi3: Present_state = addi4;
			addi4: Present_state = addi5;
			addi5: Present_state = T0;
			
			and3: Present_state = and4;
			and4: Present_state = and5;
			and5: Present_state = T0;
			
			andi3: Present_state = andi4;
			andi4: Present_state = andi5;
			andi5: Present_state = T0;
			
			sub3: Present_state = sub4;
			sub4: Present_state = sub5;
			sub5: Present_state = T0;
			
			mul3: Present_state = mul4;
			mul4: Present_state = mul5;
			mul5: Present_state = mul6;
			mul6: Present_state = T0;
			
			div3: Present_state = div4;
			div4: Present_state = div5;
			div5: Present_state = div6;
			div6: Present_state = T0;
			
			or3: Present_state = or4;
			or4: Present_state = or5;
			or5: Present_state = T0;
			
			ori3: Present_state = ori4;
			ori4: Present_state = ori5;
			ori5: Present_state = T0;
			
			shr3: Present_state = shr4;
			shr4: Present_state = shr5;
			shr5: Present_state = T0;
			
			shl3: Present_state = shl4;
			shl4: Present_state = shl5;
			shl5: Present_state = T0;
			
			shra3: Present_state = shra4;
			shra4: Present_state = shra5;
			shra5: Present_state = T0;
			
			rol3: Present_state = rol4;
			rol4: Present_state = rol5;
			rol5: Present_state = T0;
			
			ror3: Present_state = ror4;
			ror4: Present_state = ror5;
			ror5: Present_state = T0;
			
			neg3: Present_state = neg4;
			neg4: Present_state = T0;
			
			not3: Present_state = not4;
			not4: Present_state = T0;
						
			br3: Present_state = br4;
			br4: Present_state = br5;
			br5: Present_state = br6;
			br6: Present_state = T0;
			
			_jr: Present_state = T0;
			
			jal3: Present_state = jal4;
			jal4: Present_state = jal5;
			jal5: Present_state = T0;
			
			_in: Present_state = T0;
			_out: Present_state = T0;
			
			_mfhi: Present_state = T0;
			_mflo: Present_state = T0;
			
			_nop: Present_state = T0;
			_halt: Present_state = _halt;
			
			default: Present_state = Reset_state;
			
		endcase // ending case (Present_state)
	end // ending always @(posedge clock, posedge reset, posedge stop)
	
	always @(Present_state) begin
		case(Present_state)
	/*============= COMMON STEPS ==================*/	
			Reset_state: begin
			
				PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; InPortout <= 0; HIout <= 0; LOout <= 0; BAout <= 0;
				PCin <= 0; Zlowin <= 0; Zhighin <= 0; MDRin <= 0; MARin <= 0; InPortin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
				Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0; OutPortout <= 0;
				IncPC <= 0; Read <= 0; Write <= 0; Cout <= 0; JAL_flag <= 0; Run <= 1;
				
			end
			T0: begin
				 PCout <= 1; MARin <= 1; IncPC <= 1; PCin <= 1;
				 #20 PCin <= 0; IncPC <= 0; PCout <= 0;  MARin <= 0;
         end
			T1: begin
				 Read <= 1; MDRin <= 1;
				 #20 Read <= 0; MDRin <= 0;
			end
			T2: begin
				 MDRout <= 1; IRin <= 1;
				 #20 MDRout <= 0; IRin <= 0;
			end	
	/*===============================*/
			add3, sub3, or3, and3, shr3, shl3, shra3, ror3, rol3: begin
				Grb <= 1; Rout <= 1; Yin <= 1;
				#20 Grb <= 0; Rout <= 0; Yin <= 0;
			end
			add4, sub4, or4, and4, shr4, shl4, shra4, ror4, rol4: begin
				Grc <= 1; Rout <= 1; Zlowin <= 1;
				#20 Grc <= 0; Rout <= 0; Zlowin <= 0;
			end
			add5, sub5, or5, and5, shr5, shl5, shra5, ror5, rol5: begin
				Zlowout <= 1; Rin <= 1; Gra <= 1;
				#20 Zlowout <= 0; Rin <= 0; Gra <= 0;
			end
	/*===============================*/
			mul3, div3: begin
				Gra <= 1; Rout <= 1; Yin <= 1;
				#20 Gra <= 0; Rout <= 0; Yin <= 0;
			end
			mul4, div4: begin
				Grb <= 1; Rout <= 1; Zlowin <= 1; Zhighin <= 1;
				#20 Grb <= 0; Rout <= 0; Zlowin <= 0; Zhighin <= 0;
			end
			mul5, div5: begin
				Zlowout <= 1; LOin <= 1;
            #20 Zlowout <= 0; LOin <= 0;
			end
			mul6, div6: begin
				Zhighout <= 1; HIin <= 1;
				#20 Zhighout <= 0; HIin <= 0;
			end
	/*===============================*/
			addi3, ori3, andi3: begin
				 Grb <= 1; Rout <= 1; Yin <= 1;
				 #20 Grb <= 0; Rout <= 0; Yin <= 0;
			end
			addi4, ori4, andi4: begin
				 Cout <= 1; Zlowin <= 1;
				 #20 Cout <= 0; Zlowin <= 0;
			end
			addi5, ori5, andi5: begin
				 Zlowout <= 1; Rin <= 1; Gra <= 1;
				 #20 Zlowout <= 0; Rin <= 0; Gra <= 0;
			end
	/*===============================*/
			ld3: begin
				 Grb <= 1; BAout <= 1; Yin <= 1;
				 #20 Grb <= 0; BAout <= 0; Yin <= 0;
            end
			ld4: begin
				 Cout <= 1; Zlowin <= 1;
				 #20 Cout <= 0; Zlowin <= 0;
			end
			ld5: begin
				 Zlowout <= 1; MARin <= 1;
				 #20 Zlowout <= 0; MARin <= 0;
			end
			ld6: begin
				 Read <= 1; MDRin <= 1;
				 #20 Read <= 0; MDRin <= 0;
			end
			ld7: begin
				 MDRout <= 1; Gra <= 1; Rin <= 1;
				 #20 MDRout <= 0; Gra <= 0; Rin <= 0;
			end
	/*===============================*/
			ldi3: begin
				 Grb <= 1; BAout <= 1; Yin <= 1;
				 #20 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			ldi4: begin
				 Cout <= 1; Zlowin <= 1;
				 #20 Cout <= 0; Zlowin <= 0;
			end
			ldi5: begin
				 Zlowout <= 1; Gra <= 1; Rin <= 1;
				 #20 Zlowout <= 0; Gra <= 0; Rin <= 0;
			end
	/*===============================*/
			st3: begin
				 Grb <= 1; BAout <= 1; Yin <= 1;
				 #20 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			st4: begin
				 Cout <= 1; Zlowin <= 1;
				 #20 Cout <= 0; Zlowin <= 0;
			end
			st5: begin
				 Zlowout <= 1; MARin <= 1;
				 #20 Zlowout <= 0; MARin <= 0;
			end
			st6: begin
				 Rout <= 1; MDRin <= 1; Gra <= 1;
				 #20 Rout <= 0; MDRin <= 0; Gra <= 0;
			end
			st7: begin
				 MDRout <= 1; Write <= 1; 
				 #20 MDRout <= 0; Write <= 0;
			end
	/*===============================*/
			br3: begin
				 Gra <= 1; Rout <= 1; CONin <= 1;
				 #20 Gra <= 0; Rout <= 0; CONin <= 0;
			end
			br4: begin
				 PCout <= 1; Yin <= 1;
				 #20 PCout <= 0; Yin <= 0;
			end
			br5: begin
				 Cout <= 1; Zlowin <= 1; 
				 #20 Cout <= 0; Zlowin <= 0; 
			end
			br6: begin
				 Zlowout <= 1; PCin <= 1; 
				 #20 Zlowout <= 0; PCin <= 0;
			end
	/*===============================*/
			_jr: begin
				 Gra <= 1; Rout <= 1; PCin <= 1;
				 #20 Gra <= 0; Rout <= 0; PCin <= 0;
			end
	/*===============================*/
			jal3: begin
				 PCout <= 1; Zlowin <= 1;
				 #20 PCout <= 0; Zlowin <= 0;
			end
			jal4: begin
				 Zlowout <= 1; JAL_flag <= 1;
				 #20 Zlowout <= 0; JAL_flag <= 0;
			end
			jal5: begin
				 Gra <= 1; Rout <= 1; PCin <= 1;
				 #20 Gra <= 0; Rout <= 0; PCin <= 0;
			end
	/*===============================*/
			_in: begin
				 Rin <= 1; InPortout <= 1; Gra <= 1;
				 #20 Rin <= 0; InPortout <= 0; Gra <= 0;
			end
	/*===============================*/
			_out: begin
				 Rout <= 1; OutPortin <= 1; Gra <= 1;
				 #20 Rout <= 0; OutPortin <= 0; Gra <= 0;
			end
	/*===============================*/
			_mfhi: begin
				 Rin <= 1; HIout <= 1; Gra <= 1;
				 #20 Rin <= 0; HIout <= 0; Gra <= 0;
			end
	/*===============================*/
			_mflo: begin
				 Rin <= 1; LOout <= 1; Gra <= 1;
				 #20 Rin <= 0; LOout <= 0; Gra <= 0;
			end
	/*===============================*/
			_nop: begin
			end
	/*===============================*/
			_halt: begin
				Run <= 0;
			end
		endcase // ending (Present_state)
	end	// ending always @(Present_state) begin
endmodule
			
			
			
			
			
			
			
			
	