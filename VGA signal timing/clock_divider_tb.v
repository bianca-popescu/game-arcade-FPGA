
// source: fpga4student.com

`timescale 1ns / 1ps

module clock_divider_tb;

    reg clock_in = 0;
    wire clock_out;

    
    clock_divider #(.DIVISOR(2)) i(
        .clock_in(clock_in),
        .clock_out(clock_out)
    );

    //50 MHz clock: Toggle every 10 ns

    always #10 clock_in = ~clock_in;

    initial begin

        $dumpfile("clock_divider.vcd");
        $dumpvars(0, clock_divider_tb);

       
        #1000;  
        $finish;
    end

  
    always @(posedge clock_out) begin
        $display("clock_out rising at time %t ns", $time);
    end

endmodule


