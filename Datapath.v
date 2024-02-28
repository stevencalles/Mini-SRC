module Datapath(
	input wire PCout,
	input Zhighout, Zlowout, 
	input MDRout,
	input R2out, R3out, 
	input MARin, PCin, MDRin, IRin, Yin, 
	input IncPC, 
	input Read, 
	input wire [4:0] opcode,
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	input clock, clear,
	input [31:0] Mdatain,
	input HIin, LOin, Zhighin, Zlowin, Cin
);

wire [31:0] BusMuxOut, BusMuxIn;

wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2,
BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7,
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12,
BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO,
BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxOut_Y, BusMuxIn_InPort, C_sign_extended,
BusMuxIn_MAR;

wire R0out = 0; 
wire R1out = 0;  
wire R5out = 0;
wire R4out = 0;  
wire R6out = 0;  
wire R7out = 0;  
wire R8out = 0;  
wire R9out = 0;  
wire R10out = 0; 
wire R11out = 0;  
wire R12out = 0;  
wire R13out = 0;  
wire R14out = 0;  
wire R15out = 0;  
wire HIout = 0;  
wire LOout = 0;  
wire InPortout = 0; 
wire Cout = 0; 

wire [63:0] C_data_out;

//Devices
register R0(clock, clear, R0in, BusMuxOut, BusMuxIn_R0);
register R1(clock, clear, R1in, BusMuxOut, BusMuxIn_R1);
register R2(clock, clear, R2in, BusMuxOut, BusMuxIn_R2);
register R3(clock, clear, R3in, BusMuxOut, BusMuxIn_R3);
register R4(clock, clear, R4in, BusMuxOut, BusMuxIn_R4);
register R5(clock, clear, R5in, BusMuxOut, BusMuxIn_R5);
register R6(clock, clear, R6in, BusMuxOut, BusMuxIn_R6);
register R7(clock, clear, R7in, BusMuxOut, BusMuxIn_R7);
register R8(clock, clear, R8in, BusMuxOut, BusMuxIn_R8);
register R9(clock, clear, R9in, BusMuxOut, BusMuxIn_R9);
register R10(clock, clear, R10in, BusMuxOut, BusMuxIn_R10);
register R11(clock, clear, R11in, BusMuxOut, BusMuxIn_R11);
register R12(clock, clear, R12in, BusMuxOut, BusMuxIn_R12);
register R13(clock, clear, R13in, BusMuxOut, BusMuxIn_R13);
register R14(clock, clear, R14in, BusMuxOut, BusMuxIn_R14);
register R15(clock, clear, R15in, BusMuxOut, BusMuxIn_R15);

register Y(clock, clear, Yin, BusMuxOut, BusMuxOut_Y);
register HI(clock, clear, HIin, BusMuxOut, BusMuxIn_HI);
register LO(clock, clear, LOin, BusMuxOut, BusMuxIn_LO);
register Zhigh(clock, clear, Zhighin, C_data_out[63:32], BusMuxIn_Zhigh);
register Zlow(clock, clear, Zlowin, C_data_out[31:0], BusMuxIn_Zlow);
register PC(clock, clear, PCin, BusMuxOut, BusMuxIn_PC);	
registerMDR MDR(.clock(clock), .clear(clear), .enable(MDRin), .read(Read), .BusMuxOut(BusMuxOut), .Mdatain(Mdatain), .MDRout(BusMuxIn_MDR));
register MAR(clock, clear, MARin, Mdatain, BusMuxIn_MAR);


// Encoder input and output wires
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	
	assign encoder_in = {
								{8{1'b0}},
								Cout,
								InPortout,
								MDRout,
								PCout,
								Zlowout,
								Zhighout,
								LOout,
								HIout,
								R15out,
								R14out,
								R13out,
								R12out,
								R11out,
								R10out,
								R9out,
								R8out,
								R7out,
								R6out,
								R5out,
								R4out,
								R3out,
								R2out,
								R1out,
								R0out
								};
	
// Instatiating 32-to-5 encoder for the bus
encoder_32_5 encoder_32_5(encoder_in, encoder_out);


Bus bus(.BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), 
.BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), .BusMuxIn_R6(BusMuxIn_R6), 
.BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), 
.BusMuxIn_R11(BusMuxIn_R11), .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), 
.BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), .BusMuxIn_Zhigh(BusMuxIn_Zhigh), 
.BusMuxIn_Zlow(BusMuxIn_Zlow), .BusMuxIn_PC(BusMuxIn_PC), 
.BusMuxIn_MDR(BusMuxIn_MDR), .BusMuxIn_InPort(BusMuxIn_InPort), .C_sign_extended(C_sign_extended), .select_sig(encoder_out), .BusMuxOut(BusMuxOut));

endmodule 