module mul_32(input signed [31:0] A, B, output signed [31:0] HI, LO);
		
	 reg [2:0] B_G [15:0];
    reg signed [32:0] PP [15:0];
	 reg signed [63:0] S_PP [15:0];
	 wire signed [31:0] n_a;
	 wire signed [31:0] n_a2;
	 wire signed [31:0] a_2;
	 
	 reg signed [63:0] tempreg;
	 integer i;
	 assign n_a = -A;
	 assign a_2 = A<<1;
	 assign n_a2 = n_a << 1;

    always @(A or B or n_a) begin
		B_G[0] = {B[1], B[0], 1'b0};
			
		for (i = 1; i < 16; i = i + 1) begin
        B_G[i] = {B[2*i+1], B[2*i], B[2*i-1]};
		end
		
		for (i = 0; i < 16; i = i+1) begin
			case(B_G[i])
			3'b001, 3'b010:
				PP[i] = {A[31], A};
			3'b011:
				PP[i] = {a_2[31], a_2};
			3'b100:
				PP[i] = {n_a2[31], n_a2};
			3'b101, 3'b110:
				PP[i] = {n_a[31], n_a};
			default:
				PP[i] = 0;
			endcase
			S_PP[i] = PP[i] << (2*i);
		end
		tempreg = S_PP[0];
		for (i = 1; i < 16; i =i+1) begin
			tempreg = tempreg + S_PP[i];
		end
	end
	assign HI = tempreg[63:32];
	assign LO = tempreg[31:0];
endmodule


