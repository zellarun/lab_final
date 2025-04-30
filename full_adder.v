module full_adder(
    input A, B, Cin,
    output Y, Cout
);
    wire Sum;
    assign Sum = A ^ B;
    assign Y = Sum ^ Cin;
    assign Cout = (Sum & Cin) | (A & B);
endmodule