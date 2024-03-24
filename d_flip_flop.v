module d_flip_flop(input wire clk, input wire D, output reg Q, output reg Q_bar);

	initial begin
		Q <= 0;
		Q_bar <= 1;
	end
	always @(clk)
	begin
		Q <= D;
		Q_bar <= !D;
	end
	
endmodule 