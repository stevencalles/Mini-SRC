module shr_32(input [31:0] A, shiftNum, output [31:0] Z);
    assign Z[31:0] = A >> shiftNum;
endmodule 