
// AFPL: auto falling piece logic
// grid: store piece position


module top_module(

    input clk,
    input rst,
    output [4:0] current_x,
    output [4:0] current_y
);

    wire tick;

    // Coordonate
    reg [3:0] x;
    reg [4:0] y;


    wire cell_state;

    reg write_enable;

    reg cell_value;

   tick_generator #(.N(10)) tick_gen ( // tick la timp mai mic pentru simulare
	 
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

   
    grid game_grid (
	 
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y),
        .enable_reading(1'b0),
        .enable_writing(write_enable),
        .state_of_the_cell_input(cell_value),
        .state_of_the_cell_output(cell_state)
    );

    // current piece position
    assign current_x = x;
    assign current_y = y;

   
	
  always @(posedge clk or posedge rst) begin

    if (rst) begin
        x <= 4'd4;
        y <= 5'd0;

        write_enable <= 0;

        cell_value <= 0;
    end 

	else if (tick) begin

        write_enable <= 1;
        cell_value <= 1;

        if (y == 19)
            y <= 0;
        else
            y <= y + 1;

    end

end

endmodule
