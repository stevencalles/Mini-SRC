module Datapath(
	input wire PCout,
	input ZHighout, ZLowout,
	input MDRout,
	input R2out, R3out, 
	input MARin, Zin, PCin, MDRin, IRin, Yin, 
	input IncPC, 
	input Read, AND, 
	input wire [4:0] opcode,
	input R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	input clock, clear,
	input [31:0] Mdatain
);

wire [31:0] BusMuxOut, BusMuxIn;

wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2,
BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7,
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12,
BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO,
BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxOut_Y, BusMuxIn_InPort;

wire R0out, R1out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, 
PCout, MDRout, InPortout;

// MAKE AN ENCODER

//Devices
register R0(clear, clock, R0in, BusMuxOut, BusMuxIn_R0);
register R1(clear, clock, R1in, BusMuxOut, BusMuxIn_R1);
register R2(clear, clock, R2in, BusMuxOut, BusMuxIn_R2);
register R3(clear, clock, R3in, BusMuxOut, BusMuxIn_R3);
register R4(clear, clock, R4in, BusMuxOut, BusMuxIn_R4);
register R5(clear, clock, R5in, BusMuxOut, BusMuxIn_R5);
register R6(clear, clock, R6in, BusMuxOut, BusMuxIn_R6);
register R7(clear, clock, R7in, BusMuxOut, BusMuxIn_R7);
register R8(clear, clock, R8in, BusMuxOut, BusMuxIn_R8);
register R9(clear, clock, R9in, BusMuxOut, BusMuxIn_R9);
register R10(clear, clock, R10in, BusMuxOut, BusMuxIn_R10);
register R11(clear, clock, R11in, BusMuxOut, BusMuxIn_R11);
register R12(clear, clock, R12in, BusMuxOut, BusMuxIn_R12);
register R13(clear, clock, R13in, BusMuxOut, BusMuxIn_R13);
register R14(clear, clock, R14in, BusMuxOut, BusMuxIn_R14);
register R15(clear, clock, R15in, BusMuxOut, BusMuxIn_R15);

register Y(clear, clock, Yin, BusMuxOut, BusMuxOut_Y);
register HI(clear, clock, HIin, BusMuxOut, BusMuxIn_HI);
register LO(clear, clock, LOin, BusMuxOut, BusMuxIn_LO);
register Zhigh(clear, clock, Zhighin, BusMuxOut, BusMuxIn_Zhigh);
register Zlow(clear, clock, Zlowin, BusMuxOut, BusMuxIn_Zlow);
register PC(clear, clock, PCin, BusMuxOut, BusMuxIn_PC);	
registerMDR MDR(clear, clock, MDRin, Read, BusMuxOut, Mdatain, BusMuxIn_MDR);

//adder add(A, BusMuxOut, Zregin);

//alu_32 alu_32(IncPC, BusMuxOut, opcode, ZHighout, ZLowout, PCout);

// i would more accurately declare these just for yourselves

Bus bus(.BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1), .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3), 
.BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5), .BusMuxIn_R6(BusMuxIn_R6), 
.BusMuxIn_R7(BusMuxIn_R7), .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9), .BusMuxIn_R10(BusMuxIn_R10), 
.BusMuxIn_R11(BusMuxIn_R11), .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13), 
.BusMuxIn_R14(BusMuxIn_R14,), .BusMuxIn_R15(BusMuxIn_R15), .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO), BusMuxIn_Zhigh, 
.BusMuxIn_Zout(BusMuxIn_Zout), .BusMuxIn_PC(BusMuxIn_PC), 
.BusMuxIn_MDR(BusMuxIn_MDR), BusMuxIn_InPort(BusMuxIn_InPort), .C_sign_extended(C_sign_extended), .BusMuxOut(BusMuxOut));

endmodule
