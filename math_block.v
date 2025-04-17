module math_block(
    input [3:0] A,
    input [3:0] B,
    output [3:0] AplusB,
    output [3:0] AminusB
);

assign AplusB = A + B;
assign AminusB = A - (~B + 1);

endmodule