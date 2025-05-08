
// source: fpga4student.com 

module clock_divider(clock_in,clock_out
    );

input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor

reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd2;

// F(clock_out) = F(clock_in)/DIVISOR

always @(posedge clock_in)
begin
    counter <= counter + 28'd1;

    if(counter>=(DIVISOR-1))
        counter <= 28'd0;

    if (counter < DIVISOR / 2)
        clock_out <= 1'b1;
    else
        clock_out <= 1'b0;
end

endmodule

