module Datapath(
	input clock, clear, stop,
	input [31:0] InPort_input,
	output [31:0] OutPort_output
);

wire Gra, Grb, Grc, Rin, Rout, CONin, BAout, PCout, Zhighout, Zlowout, MDRout, MDRin, MARin, IRin, PCin, InPortout, 
OutPortin, InPortin, OutPortout, Yin, HIin, LOin, Cout, Zhighin, Zlowin, LOout, HIout, JAL_flag,
Read, Write, IncPC, Run;

wire [31:0] BusMuxOut, BusMuxIn;
wire [4:0] opcode;

wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2,
BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7,
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12,
BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO,
BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxOut_Y, BusMuxIn_InPort, C_sign_extended,
BusMuxIn_MAR, BusMuxIn_IR, C_out_HI, C_out_LO, BusMuxIn_RAM;
wire [31:0] BusMuxIn_And_R0;

wire CONout;

reg [15:0] R0_15_out, R0_15_in;
wire [15:0] R0_15_out_IR, R0_15_in_IR;

initial begin
	R0_15_out = 16'd0;
	R0_15_in = 16'd0;
end

always @(*) begin
	R0_15_in <= R0_15_in_IR;
	R0_15_out <= R0_15_out_IR;
end

assign BusMuxIn_R0 = {32{!BAout}} & BusMuxIn_And_R0;
//Devices
register R0(clock, clear, R0_15_in[0], BusMuxOut, BusMuxIn_And_R0);
register R1(clock, clear, R0_15_in[1], BusMuxOut, BusMuxIn_R1);
register R2(clock, clear, R0_15_in[2], BusMuxOut, BusMuxIn_R2);
register R3(clock, clear, R0_15_in[3], BusMuxOut, BusMuxIn_R3);
register R4(clock, clear, R0_15_in[4], BusMuxOut, BusMuxIn_R4);
register R5(clock, clear, R0_15_in[5], BusMuxOut, BusMuxIn_R5);
register R6(clock, clear, R0_15_in[6], BusMuxOut, BusMuxIn_R6);
register R7(clock, clear, R0_15_in[7], BusMuxOut, BusMuxIn_R7);
register R8(clock, clear, R0_15_in[8], BusMuxOut, BusMuxIn_R8);
register R9(clock, clear, R0_15_in[9], BusMuxOut, BusMuxIn_R9);
register R10(clock, clear, R0_15_in[10], BusMuxOut, BusMuxIn_R10);
register R11(clock, clear, R0_15_in[11], BusMuxOut, BusMuxIn_R11);
register R12(clock, clear, R0_15_in[12], BusMuxOut, BusMuxIn_R12);
register R13(clock, clear, R0_15_in[13], BusMuxOut, BusMuxIn_R13);
register R14(clock, clear, R0_15_in[14], BusMuxOut, BusMuxIn_R14);
register R15(clock, clear, R0_15_in[15]|JAL_flag, BusMuxOut, BusMuxIn_R15);

register Y(clock, clear, Yin, BusMuxOut, BusMuxOut_Y);
register HI(clock, clear, HIin, BusMuxOut, BusMuxIn_HI);
register LO(clock, clear, LOin, BusMuxOut, BusMuxIn_LO);
register Zhigh(clock, clear, Zhighin, C_out_HI, BusMuxIn_Zhigh);
register Zlow(clock, clear, Zlowin, C_out_LO, BusMuxIn_Zlow);
pc_register PC(clock, clear, PCin, IncPC, CONout, BusMuxOut, BusMuxIn_PC);		
registerMDR MDR(.clock(clock), .clear(clear), .enable(MDRin), .read(Read), .BusMuxOut(BusMuxOut), .Mdatain(BusMuxIn_RAM), .MDRout(BusMuxIn_MDR));
register MAR(clock, clear, MARin, BusMuxOut, BusMuxIn_MAR);
register IR(clock, clear, IRin, BusMuxOut, BusMuxIn_IR);
register inport(clock, clear, 1'b1, InPort_input, BusMuxIn_InPort);
register outport(clock, clear, OutPortin, BusMuxOut, OutPort_output);


// Encoder input and output wires
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	
	assign encoder_in = {
								{8{1'b0}},
								Cout,			// this will represent Cout eventually
								InPortout,	// this will represent InPortout eventually
								MDRout,
								PCout,
								Zlowout,
								Zhighout,
								LOout,
								HIout,
								R0_15_out
								};
	
// Instatiating 32-to-5 encoder for the bus
encoder_32_5 encoder_32_5(encoder_in, encoder_out);

select_encode_logic select_encode_logic(.IR(BusMuxIn_IR), .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .opcode(opcode), .C_sign_extended(C_sign_extended), .R0_15_in(R0_15_in_IR), .R0_15_out(R0_15_out_IR));

con_ff con_ff(BusMuxIn_IR[20:19], BusMuxOut, CONin, CONout);

alu_32 alu(.IncPC(IncPC), .A(BusMuxOut_Y), .B(BusMuxOut), .opcode(opcode), .C_out_HI(C_out_HI), .C_out_LO(C_out_LO), .branch_flag(CONout));

RAM RAM(.clock(clock), .read(Read), .write(Write), .address(BusMuxIn_MAR[8:0]), .ram_data_in(BusMuxIn_MDR), .ram_data_out(BusMuxIn_RAM));

Bus bus(.BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), 
.BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), .BusMuxIn_R6(BusMuxIn_R6), 
.BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), 
.BusMuxIn_R11(BusMuxIn_R11), .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), 
.BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), .BusMuxIn_Zhigh(BusMuxIn_Zhigh), 
.BusMuxIn_Zlow(BusMuxIn_Zlow), .BusMuxIn_PC(BusMuxIn_PC), 
.BusMuxIn_MDR(BusMuxIn_MDR), .BusMuxIn_InPort(BusMuxIn_InPort), .C_sign_extended(C_sign_extended), .select_sig(encoder_out), .BusMuxOut(BusMuxOut));

control_unit control(.clock(clock), .clear(clear), .stop(stop), .Run(Run), .IR(BusMuxIn_IR), .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin),
.Rout(Rout), .CONin(CONin), .BAout(BAout), .PCout(PCout), .Zhighout(Zhighout), .Zlowout(Zlowout), .MDRout(MDRout), .MARin(MARin), .IRin(IRin), 
.PCin(PCin), .InPortout(InPortout), .OutPortin(OutPortin), .InPortin(InPortin), .OutPortout(OutPortout), .Yin(Yin), .HIin(HIin), .LOin(LOin), 
.Cout(Cout), .Zhighin(Zhighin), .Zlowin(Zlowin), .LOout(LOout), .HIout(HIout), .JAL_flag(JAL_flag), .Read(Read), .Write(Write), .IncPC(IncPC), .MDRin(MDRin));

endmodule 