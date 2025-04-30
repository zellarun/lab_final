module math_block(
    input [3:0] A,
    input [3:0] B,
    output [3:0] AplusB,
    output [3:0] AminusB
);

    wire [3:0] carry_add;
    wire [3:0] notB;
    wire [3:0] carry_sub;

    //Addition
    full_adder fa0_add(.A(A[0]), .B(B[0]), .Cin(0), .Y(AplusB[0]), .Cout(carry_add[0]));
    full_adder fa1_add(.A(A[1]), .B(B[1]), .Cin(carry_add[0]), .Y(AplusB[1]), .Cout(carry_add[1]));
    full_adder fa2_add(.A(A[2]), .B(B[2]), .Cin(carry_add[1]), .Y(AplusB[2]), .Cout(carry_add[2]));
    full_adder fa3_add(.A(A[3]), .B(B[3]), .Cin(carry_add[2]), .Y(AplusB[3]), .Cout());

    //Subtraction
    assign notB = ~B;
    full_adder fa0_sub(.A(A[0]), .B(notB[0]), .Cin(1), .Y(AminusB[0]), .Cout(carry_sub[0]));
    full_adder fa1_sub(.A(A[1]), .B(notB[1]), .Cin(carry_sub[0]), .Y(AminusB[1]), .Cout(carry_sub[1]));
    full_adder fa2_sub(.A(A[2]), .B(notB[2]), .Cin(carry_sub[1]), .Y(AminusB[2]), .Cout(carry_sub[2]));
    full_adder fa3_sub(.A(A[3]), .B(notB[3]), .Cin(carry_sub[2]), .Y(AminusB[3]), .Cout());

endmodule