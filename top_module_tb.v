module top_module_tb;
    reg clk = 0;
    reg rst = 1;
    wire [3:0] x;
    wire [4:0] y;
    wire piece_active;

    always #10 clk = ~clk;  // 50MHz clock

    top_module_tb uut (
        .clk(clk),
        .rst(rst),
        .o_hsync(),
        .o_vsync(),
        .o_red(),
        .o_green(),
        .o_blue()
    );

    initial begin
        $monitor("Time=%0t, X=%d, Y=%d, Active=%b", $time, uut.x_pos, uut.y_pos, uut.piece_active);
        #100 rst = 0;
        #1000000 $finish;
    end
endmodule
