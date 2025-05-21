`timescale 1ns / 1ps

module top_module_tb;
    reg clk;
    reg rst;
    wire [4:0] current_x;
    wire [4:0] current_y;

    // Single instantiation of DUT
    top_module uut (
        .clk(clk),
        .rst(rst),
        .current_x(current_x),
        .current_y(current_y)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period clock

    initial begin
        // Initialize reset
        rst = 1;
        #50 rst = 0;  // Deassert reset after 50 ns

        // Optional: assert reset again if needed
        // #100 rst = 1;
        // #110 rst = 0;

        // Run simulation long enough
        #1000000;
        $finish;
    end

    initial begin
        $dumpfile("tetris.vcd");
        $dumpvars(0, top_module_tb);
    end

    initial begin
        $monitor("Time=%0t rst=%b tick=%b y=%d", $time, rst, uut.tick, uut.y);
    end


endmodule
