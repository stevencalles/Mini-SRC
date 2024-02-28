module encoder_32_5(
  input [31:0] in,
  output reg [4:0] encoder_out
);
  always @(*) begin
    case(in)
      32'h00000001 : encoder_out = 5'd0;
      32'h00000002 : encoder_out = 5'd1;
      32'h00000004 : encoder_out = 5'd2;
      32'h00000008 : encoder_out = 5'd3;
      32'h00000010 : encoder_out = 5'd4;
      32'h00000020 : encoder_out = 5'd5;
      32'h00000040 : encoder_out = 5'd6;
      32'h00000080 : encoder_out = 5'd7;
      32'h00000100 : encoder_out = 5'd8;
      32'h00000200 : encoder_out = 5'd9;
      32'h00000400 : encoder_out = 5'd10;
      32'h00000800 : encoder_out = 5'd11;
      32'h00001000 : encoder_out = 5'd12;
      32'h00002000 : encoder_out = 5'd13;
      32'h00004000 : encoder_out = 5'd14;
      32'h00008000 : encoder_out = 5'd15;
      32'h00010000 : encoder_out = 5'd16;
      32'h00020000 : encoder_out = 5'd17;
      32'h00040000 : encoder_out = 5'd18;
      32'h00080000 : encoder_out = 5'd19;
      32'h00100000 : encoder_out = 5'd20;
      32'h00200000 : encoder_out = 5'd21;
      32'h00400000 : encoder_out = 5'd22;
      32'h00800000 : encoder_out = 5'd23;
      default: encoder_out = 5'd31;
    endcase
  end
endmodule 