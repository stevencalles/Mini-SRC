module SHR(input [31:0] A, shiftNum, output [31:0] Result);
    assign Result[31:0] = A >> shiftNum;
endmodule 