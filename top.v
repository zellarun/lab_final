module top
#(
    parameter DIVIDE_BY = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately for testing
)
(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, // Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);

    // Instantiate the clock divider...
    clock_div clk_div(
        .clock(clk),
        .reset(btnC),
        .div_clock()
    );
    // ... wire it up to the scanner
    seven_seg_scanner scanner(
        .div_clock(div_clock),
        .reset(btnC)
    );
    // ... wire the scanner to the decoder
    seven_seg_decoder decoder(
        .A(sw[3:0]),
        .B(sw[7:4]),
        .anode(an)
    );

    // Wire up the math block into the decoder
    math_block math(
        .A(sw[3:0]),
        .B(sw[7:4])
    );

    // Do not forget to wire up resets!!

endmodule