`timescale 1ns/1ps

module test();

	reg [3:0] A, B;
    reg clk;
    reg btnC;
    wire [3:0] AminusB, AplusB;
    wire [3:0] an;
    wire [6:0] seg;
    wire [7:0] sw;
    integer i, j;

    // Might need to be .DIVIDE_BY(2) based
    // on your implementation
    top #(.DIVIDE_BY(1)) uut(
        .sw(sw),
        .clk(clk),
        .btnC(btnC),
        .an(an),
        .seg(seg)
    );

	assign sw = {B, A};
	assign AminusB = A - B;
	assign AplusB = A + B;

    task automatic advance_clock;
        begin
            #1 clk = ~clk;
            #1 clk = ~clk;
            #1 clk = ~clk;
            #1 clk = ~clk;
        end
    endtask
    
	function automatic [6:0] seg_encode(
		input [3:0] value
	);
		begin
			case(value)
				//                  GFEDCBA
				0:  seg_encode = 7'b1000000;
				1:  seg_encode = 7'b1111001;
				2:  seg_encode = 7'b0100100;
				3:  seg_encode = 7'b0110000;
				4:  seg_encode = 7'b0011001;
				5:  seg_encode = 7'b0010010;
				6:  seg_encode = 7'b0000010;
				7:  seg_encode = 7'b1111000;
				8:  seg_encode = 7'b0000000;
				9:  seg_encode = 7'b0010000;
				10: seg_encode = 7'b0001000; // A
				11: seg_encode = 7'b0000011; // B
				12: seg_encode = 7'b1000110; // C
				13: seg_encode = 7'b0100001; // D
				14: seg_encode = 7'b0000110; // E
				15: seg_encode = 7'b0001110; // F
				default: seg_encode = 7'b1000001; // U for unknown
			endcase
		end
	endfunction

    task automatic test_segs(
        input [7:0] expected_segR,
        input [7:0] expected_segRC,
        input [7:0] expected_segLC,
        input [7:0] expected_segL
    );
        begin
            if (seg !== expected_segR) begin
                $display("Test failed, segment R!");
                $finish;
            end
            advance_clock();
            if (seg !== expected_segRC) begin
                $display("Test failed, segment RC!");
                $finish;
            end
            advance_clock();
            if (seg !== expected_segLC) begin
                $display("Test failed, segment LC!");
                $finish;
            end
            advance_clock();
            if (seg !== expected_segL) begin
                $display("Test failed, segment L!");
                $finish;
            end
            advance_clock();
        end
    endtask

    initial begin
		$dumpvars(0, test);
		clk = 0;
		btnC = 1;
		#5;
		btnC = 0;
		

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                #1;
                $display("Testing A = %0d (0x%0h), B = %0d (0x%0h)...", A, A, B, B);
                test_segs(seg_encode(A), seg_encode(B), seg_encode(A + B), seg_encode(A - B));
                $display("--Success");
            end
        end

		$display("All tests passed!");
		$finish;
	end



endmodule