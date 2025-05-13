
// source: fpga4student.com (modified)


module clock_divider (
    input wire clock_in,       // input clock (e.g., 50 MHz)
    output reg clock_out = 0   // output clock
);

    parameter DIVISOR = 2;     // set to 2 for 25 MHz output from 50 MHz input
    reg [27:0] counter = 0;    // counter to divide clock

    always @(posedge clock_in) begin

        if (counter >= DIVISOR - 1)
            counter <= 0;
        else
            counter <= counter + 1;

        clock_out <= (counter < DIVISOR / 2);
    end

endmodule


