module mux_2_1 (input [31:0] in1, in2, input read, output [31:0] mux_2_1_out); 
assign mux_2_1_out[31:0] = read ? in2[31:0] : in1[31:0]; //read=1 sets in2 as mux_out
endmodule 