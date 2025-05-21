// clock_divider: 25MHz for VGA logic
// AFPL: auto falling piece logic
// grid: store piece position
// background: display screen

module top_module(

    input clk,
    input rst,
    output [3:0] current_x,
    output [4:0] current_y
);

    wire tick;

    // Coordonate
    reg [3:0] x;
    reg [4:0] y;


    wire cell_state;

    reg write_enable;

    reg cell_value;

    tick_generator #(.N(25000000)) tick_gen (
	 
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
				
        end else if (tick) begin
            // Write current cell as filled
            write_enable <= 1;
            cell_value <= 1;
            y <= y + 1;

            if (y == 19) begin
                y <= 0; // Reset the piece
            end
				
        end else begin
            write_enable <= 0;
        end
    end

endmodule
