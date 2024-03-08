module non_restoring_division(input [31:0] A, M, output reg [31:0] Quo, output reg [31:0] R
);

reg [31:0] Q;
reg [4:0] counter;

initial begin
    Q = 32'b0;
    counter = 5'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 0;
        counter <= 0;
    end
    else begin
        if (counter < 5) begin
            // Shift A and Q left by 1 bit
            A <= {A[30:0], Q[31]};
            Q <= {Q[30:0], 1'b0};
            // Subtract M from A
            if (A[31] == 1'b0) // If A is positive
                A <= A - M;
            else // If A is negative
                A <= A + M;
            // If A is negative, set Q0 to 0 and add M back to A
            if (A[31] == 1'b1) begin
                Q[0] <= 1'b0;
                A <= A + M;
            end
            else begin
                Q[0] <= 1'b1;
            end
            counter <= counter + 1;
        end
        else begin
            R <= A[31:0];
            Quo <= Q;
        end
    end
end

endmodule
