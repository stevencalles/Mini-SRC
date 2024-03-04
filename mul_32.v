module mul_32(input signed [31:0] A, B, output reg signed [31:0] HI, LO);

    reg signed [63:0] product;
    reg [6:0] count;
    reg [1:0] state;
    reg [1:0] prev_bit;
	 reg signed [31:0] shifted_B;

    always @(A, B) begin
        case (state)
            2'b00: begin
                product <= {32'b0, A}; // Initialize product
                count <= 7'b0; // Initialize counter
                state <= 2'b01;
                prev_bit <= 2'b00;
            end
            2'b01: begin
                if (count < 32) begin // Check if all bits have been processed
                    prev_bit <= B[1:0];
                    if (B[0] != prev_bit[1]) begin
                        if (B[0] == 1'b0 && prev_bit[1] == 1'b1) begin
                            product <= product + A; // Add A to product
                        end
                        else if (B[0] == 1'b1 && prev_bit[1] == 1'b0) begin
                            product <= product - A; // Subtract A from product
                        end
                    end
                    shifted_B <= {B[30:0], B[31]}; // Shift B right by 1 bit
                    count <= count + 1; // Increment counter
                    state <= 2'b01;
                end
                else begin
                    state <= 2'b10; // Move to the next state for result extraction
                end
            end
            2'b10: begin
                HI <= product[63:32]; // Extract HI
                LO <= product[31:0]; // Extract LO
                state <= 2'b11; // Move to the final state
            end
            default: begin
                state <= state; // Hold the state
            end
        endcase
    end
endmodule