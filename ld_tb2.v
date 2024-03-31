`timescale 1ns/10ps
module ld_tb2;
	 
	reg clock, clear, PCout, Zlowout, MDRout, Zhighout;
	reg MARin, PCin, MDRin, IRin, Yin, InPortin, OutPortin;
	reg BAout, InPortout, Cout; 
	reg LOout, HIin, LOin, HIout;
	reg Zhighin, Zlowin, Cin;
	reg IncPC, Read, Write, Rin, Rout;
	reg Gra, Grb, Grc, CONin;
	reg holdstate = 0;

	wire [31:0] OutPort_out;
	reg [31:0] InPort_input;

	parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;

//	datapath DUT(Clock, Reset, Read, Write, IncPC, PCin, Zin, MDRin, MARin, Yin, HIin, LOin, IRin, OutPortin, PCout, Zhighout, Zlowout, HIout, LOout, MDRout, InPortout, Cout, BAout, CONin, Gra, Grb, Grc, Rin, Rout, InPort_input);
	
	Datapath DUT(.PCout(PCout), .Zhighout(Zhighout), .Zlowout(Zlowout), .MDRout(MDRout), .BAout(BAout), .CONin(CONin), .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .InPort_input(InPort_input),
	.MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .IncPC(IncPC), .Read(Read), .Write(Write),
	.clock(clock), .clear(clear), .HIin(HIin), .InPortout(InPortout), .Cout(Cout),
	.LOin(LOin), .Zhighin(Zhighin), .Zlowin(Zlowin), .Cin(Cin), .LOout(LOout), .HIout(HIout), .OutPortin(OutPortin), .InPortin(InPortin));
	
	
	initial
		begin
			DUT.R2.BusMuxIn = 32'd50;
			clock = 0;
			forever #10 clock = ~clock;
		end
	
	always @(posedge clock)
		begin 
			if (!holdstate) begin
				case (Present_state)
					Default: Present_state = T0;
					T0					:	 Present_state = T1;
					T1					:	 Present_state = T2;
					T2					:	 Present_state = T3;
					T3					:	 Present_state = T4;
					T4					:	 Present_state = T5;
					T5					:	 Present_state = T6;
					T6					:	 Present_state = T7;
				endcase
			end
		end

    always @(Present_state) begin
		  holdstate = 1;
        case (Present_state)
            Default: begin
                PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; InPortout <= 0; HIout <= 0; LOout <= 0; BAout <= 0;
                PCin <= 0; Zlowin <= 0; MDRin <= 0; MARin <= 0; InPortin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
                Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0;
                IncPC <= 0; Read <= 0; Write <= 0; Cout <= 0;
                InPort_input <= 32'd0;
            end
            T0: begin
					 PCout <= 1; MARin <= 1; IncPC <= 1;
                PCout <= 0;  MARin <= 0; PCin <= 1;
					 #25 PCin <= 0; IncPC <= 0;
            end
            T1: begin
                 Read <= 1; MDRin <= 1;
                #25 Read <= 0; MDRin <= 0;
            end
            T2: begin
                MDRout <= 1; IRin <= 1;
                #25 MDRout <= 0; IRin <= 0;
            end
            T3: begin
                Grb <= 1; BAout <= 1; Yin <= 1;
                #25 Grb <= 0; BAout <= 0; Yin <= 0;
            end
            T4: begin
                Cout <= 1; Zlowin <= 1;
                #25 Cout <= 0; Zlowin <= 0;
            end
            T5: begin
                Zlowout <= 1; MARin <= 1;
                #25 Zlowout <= 0; MARin <= 0;
            end
            T6: begin
                Read <= 1; MDRin <= 1;
                #25 Read <= 0; MDRin <= 0;
            end
            T7: begin
                MDRout <= 1; Gra <= 1; Rin <= 1;
                #25 MDRout <= 0; Gra <= 0; Rin <= 0;
            end
        endcase
		  holdstate = 0;
    end
endmodule