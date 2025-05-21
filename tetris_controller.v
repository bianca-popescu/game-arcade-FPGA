module tetris_controller (
    input clk,
    input reset,
    input tick, // Tick-ul jocului pentru ca piesele sa coboare automat,semnal periodic
    input move_left,
    input move_right,
    input move_down,
    input rotate,
    output reg [3:0]x,
    output reg [3:0]y,
    output reg [1:0]orientation, // stadiu de orientare 2-bit
    output reg update_position // stadiul in care se regaseste piesa dupa ce coboara
);

// DE COMPLETAT IN VIITOR: functie pentru verificarea coliziunii !!!!!!!!!!!!
// function is_valid_collision folosita mai jos

reg [3:0]next_x, next_y;
reg [1:0]next_orientation;

// Control priority FSM
always @(posedge clk or posedge reset) begin
    if (reset) begin
    // se pune piesa in mijlocului gridului, sus
        x <= 4'd5;
        y <= 4'd0;
        orientation <= 2'd0;
        update_position <= 1'b0;
    end else begin
    // daca nu primeste reset atunci are pozitia curenta
        next_x = x;
        next_y = y;
        next_orientation = orientation;
        update_position = 1'b0;

        // Prioritatea miscarilor: move_left -> move_right -> rotate -> move_down -> tick
        if (move_left) begin
            //if (is_valid_position(x-1, y, orientation)) begin
                next_x = x-1;
                update_position = 1'b1;
            //end
        end else if (move_right) begin
            //if (is_valid_position(x+1, y, orientation)) begin
                next_x = x+1;
                update_position = 1'b1;
            //end
        end else if (rotate) begin
            //if (is_valid_position(x, y, orientation+1)) begin
                next_orientation = orientation+1;
                update_position = 1'b1;
            //end
        end else if (move_down) begin
            //if (is_valid_position(x, y+1, orientation)) begin
                next_y = y+1;
                update_position = 1'b1;
            //end
        end else if (tick) begin
            //if (is_valid_position(x, y+1, orientation)) begin
                next_y = y+1;
                update_position = 1'b1;
            //end
        end

        // daca update_position e 1 atunci e clar ca au avut loc schimbari ce trebuie date ca output, acele next_y si next_x devin x si y pentru operatia viitoare
        if (update_position) begin
            x <= next_x;
            y <= next_y;
            orientation <= next_orientation;
        end
    end
end

endmodule
