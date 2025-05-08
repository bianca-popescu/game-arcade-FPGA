
// source: fpga4student.com

`timescale 1ns / 1ps


module clock_divider_tb;

 reg clock_in;
 wire clock_out;

 // Instantiate the Unit Under Test (UUT)
 // Test the clock divider in Verilog

 clock_divider uut (
  .clock_in(clock_in), 
  .clock_out(clock_out)
 );

 initial begin

  clock_in = 0;
  // create input clock 50MHz
        forever #10 clock_in = ~clock_in;
 end
      
endmodule

