`timescale 1ns/10ps
module div_32_tb;

	reg clock, clear, PCout, Zlowout, MDRout, R4out, R5out, Zhighout;
	reg MARin, PCin, MDRin, IRin, Yin;
	reg LOout, HIin, LOin, HIout;
	reg Zhighin, Zlowin, Cin;
	reg IncPC, Read, R4in, R5in;
	reg R0in;
	reg [4:0] DIV_signal;
	reg [31:0] Mdatain;
	reg holdstate = 0;
	
	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
								Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
								T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101;
								
	reg [3:0] Present_state = Default;
	initial clear = 0;
	
	Datapath DUT(.PCout(PCout), .Zhighout(Zhighout), .Zlowout(Zlowout), .MDRout(MDRout), .R0_15_out({10'd0, R5out, R4out, 4'd0}), 
	.MARin(MARin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .IncPC(IncPC), .Read(Read), 
	.opcode(DIV_signal), .R0in(R0in), .R4in(R4in), .R5in(R5in), .clock(clock), .clear(clear), .Mdatain(Mdatain), .HIin(HIin),
	.LOin(LOin), .Zhighin(Zhighin), .Zlowin(Zlowin), .Cin(Cin), .LOout(LOout), .HIout(HIout));
	
	
	
	initial
		begin
			clock = 0;
			forever #10 clock = ~clock;
		end
	
	always @(posedge clock)
		begin 
			if (!holdstate) begin
				case (Present_state)
					Default			:	 Present_state = Reg_load1a;
					Reg_load1a		:	 Present_state = Reg_load1b;
					Reg_load1b		:	 Present_state = Reg_load2a;
					Reg_load2a		:	 Present_state = Reg_load2b;
					Reg_load2b		:	 Present_state = Reg_load3a;
					Reg_load3a		:	 Present_state = Reg_load3b;
					Reg_load3b		:	 Present_state = T0;
					T0					:	 Present_state = T1;
					T1					:	 Present_state = T2;
					T2					:	 Present_state = T3;
					T3					:	 Present_state = T4;
					T4					:	 Present_state = T5;
					T5					:	 Present_state = T6;
				endcase
			end
		end
	always @ (Present_state)
		begin
			holdstate = 1;
			case(Present_state)
				Default: begin
					PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0;
					clear <= 0; HIout <= 0; LOout <= 0;
					R4out <= 0; R5out <= 0; MARin <= 0; Zlowin <= 0; Zhighin <= 0; DIV_signal <= 5'b00000;
					PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0; HIin <= 0; LOin <= 0;
					IncPC <= 0; Read <= 0; R4in <= 0; R5in <= 0; Mdatain <= 32'h00000000;
				end
				Reg_load1a: begin
                Mdatain <= 32'h00000017;		// loading with value 23
                Read = 0; MDRin = 0;
                Read <= 1; MDRin <= 1;
                #25 Read <= 0; MDRin <= 0;
            end
            Reg_load1b: begin
                MDRout <= 1; R4in <= 1;
                #25 MDRout <= 0; R4in <= 0;
            end
            Reg_load2a: begin
                Mdatain <= 32'h00000005;		// loading with value 5 
                Read <= 1; MDRin <= 1;
                #25 Read <= 0; MDRin <= 0;
            end
            Reg_load2b: begin
                MDRout <= 1; R5in <= 1;
                #25 MDRout <= 0; R5in <= 0;
            end
            Reg_load3a: begin
				// not necessary for this op
            end
            Reg_load3b: begin
				// not necessary for this op
            end
            T0: begin
					PCout <= 1; MARin <= 1; IncPC <= 1; //Zlowin <= 1;
					PCout <= 0;  MARin <= 0; PCin <= 1;
					#15 PCin <= 0; IncPC <= 0;
            end
            T1: begin
                Mdatain <= 32'h28918000; // regs opcode to be placed here in the future
                Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            T2: begin
                MDRout <= 1; IRin <= 1;
                #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
                R4out <= 1; Yin <= 1;
                #25 R4out <= 0; Yin <= 0;
            end
            T4: begin
                R5out <= 1; DIV_signal <= 5'b10000; Zlowin <= 1; Zhighin <= 1;
                #25 R5out <= 0; Zlowin <= 0; Zhighin <= 0;
            end
            T5: begin
                Zlowout <= 1; LOin <= 1;
                #25 Zlowout <= 0; LOin <= 0;
            end
				T6: begin
					 Zhighout <= 1; HIin <= 1;
					 #25 Zhighout <= 0; HIin <= 0;
				end
        endcase
		  holdstate = 0;
    end
endmodule
