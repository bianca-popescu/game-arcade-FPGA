// clock_divider: 25MHz for VGA logic
// AFPL: auto falling piece logic
// grid: store piece position
// background: display screen

module tetris_top(
    input logic clk,        
    input logic rst,        
    output logic o_hsync,
    output logic o_vsync,
    output logic [7:0] o_red,
    output logic [7:0] o_green,
    output logic [7:0] o_blue
);

    logic clk25MHz;
    logic tick1Hz;

    // status de la AFPL
    logic [3:0] x_pos;
    logic [4:0] y_pos;
    logic piece_active;

 
    logic dummy_cell_out; // dummy signal 

    clock_divider #(.DIVISOR(2)) clkdiv_25MHz (
        .clock_in(clk),
        .clock_out(clk25MHz)
    );

    tick_generator #(.N(50000000)) tick_1Hz (
        .clk(clk),
        .rst(rst),
        .tick(tick1Hz)
    );

    AFPL falling_piece_logic (
        .clk(clk),
        .rst(rst),
        .tick(tick1Hz),
        .x_pos(x_pos),
        .y_pos(y_pos),
        .piece_active(piece_active)
    );


    grid playfield (
        .clk(clk),
        .rst(rst),
        .x(x_pos),
        .y(y_pos),
        .enable_reading(1'b0),
        .enable_writing(piece_active),
        .state_of_the_cell_input(1'b1), 
        .state_of_the_cell_output(dummy_cell_out)
    );

    background vga_bg (
        .clk(clk),
        .o_hsync(o_hsync),
        .o_vsync(o_vsync),
        .o_red(o_red),
        .o_blue(o_blue),
        .o_green(o_green)
    );

endmodule
