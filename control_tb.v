`timescale 1ns/10ps
module control_tb;
	reg clock, clear, stop;
	
	wire [31:0] OutPort_output;
	reg [31:0] InPort_input;
	
	Datapath DUT(clock, clear, stop, InPort_input, OutPort_output);
	
	initial begin
		clock = 0; clear = 0; stop = 0;
		forever #10 clock = ~clock;
	end
endmodule
