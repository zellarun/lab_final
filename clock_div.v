module clock_div #( parameter DIVIDE_BY = 17 )(
    input clock,
    input reset,
    output reg div_clock
);

integer counter = 0;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;
            div_clock <= 0;
        end
        else begin
            if (counter >= (DIVIDE_BY / 2) - 1) begin
                counter <= 0;
                div_clock <= ~div_clock;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule

