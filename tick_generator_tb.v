`timescale 1ns/1ps

module tick_generator_tb;

    // Parameters
    parameter N = 10;  // Small value for quick simulation

    // Testbench signals
    logic clk;
    logic rst;
    logic tick;

    // Instantiate the module
    tick_generator #(.N(N)) uut (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    // Clock generation: 10ns period = 100 MHz
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("Starting simulation...");
        $dumpfile("tick_generator.vcd");  // For GTKWave
        $dumpvars(0, tb_tick_generator);

        // Initialize signals
        clk = 0;
        rst = 1;

        // Hold reset for a few cycles
        #20;
        rst = 0;

        // Run simulation long enough to observe several ticks
        #200;

        $display("Simulation complete.");
        $finish;
    end

endmodule
