`timescale 1ns / 1ps

module top_module_tb;

    reg clk = 0;
    reg rst = 1;

    wire o_hsync, o_vsync;
    wire [7:0] o_red, o_green, o_blue;

    // 50MHz clock
    always #10 clk = ~clk;

    tetris_top uut (
        .clk(clk),
        .rst(rst),
        .o_hsync(o_hsync),
        .o_vsync(o_vsync),
        .o_red(o_red),
        .o_green(o_green),
        .o_blue(o_blue)
    );

    initial begin
        $dumpfile("tetris.vcd");
        $dumpvars(0, tb_tetris_top);
        #100 rst = 0;  
        #1000000;      // timp de simulare
        $finish;
    end

endmodule
