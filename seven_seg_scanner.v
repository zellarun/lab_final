module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] anode
);

    reg [1:0] state;

    // This block should activate one anode at a time in the seven segment
    // displays. Keep in mind THEY ARE INVERSE DRIVE, that is that 0 is ON 1 is
    // OFF. Think of it as a state machine.

    // The reset line should set things back to segment 0

    // Use the D FlipFlops from previous labs, and implement all other logic
    // purely combinatorial.

    // Anodes are:
    // 0: R Right           1110
    // 1: RC Right Center   1101
    // 2: LC Left Center    1011
    // 3: L Left            0111
    
    // Sequential logic (state update)
    always @(posedge div_clock or posedge reset) begin
        if (reset)
            state <= 2'b00;         //Start @ A State
        else
            state <= state + 1;     //Next State
    end
    
    always @ (state) begin
        case(state)
            2'b00: anode = 4'b1110; // A
            2'b01: anode = 4'b1101; // B
            2'b10: anode = 4'b1011; // C
            2'b11: anode = 4'b0111; // D
        endcase
    end
    
endmodule