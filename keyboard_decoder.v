module keyboard_decoder (
    input clk,
    input [7:0] scancode,
    input ready,
    output reg move_left,
    output reg move_right,
    output reg move_down,
    output reg rotate
);

    typedef enum reg [1:0] {      
        IDLE = 2'b00,     //key press
        BREAK = 2'b01  //key release
    } state_t;

    state_t state;

    always @(posedge clk) 
     begin
        move_left  <= 0;   
        move_right <= 0;
        move_down  <= 0;
        rotate     <= 0;

        if (ready) 
	  begin
            case (state)
                IDLE: begin
                    if (scancode == 8'hF0)
		      begin
                        state <= BREAK; 
                       end 
		    else begin
                        case (scancode)
                            8'h6B: move_left  <= 1;         // Left arrow (E0 6B)
                            8'h74: move_right <= 1;         // Right arrow (E0 74)
                            8'h72: move_down  <= 1;         // Down arrow (E0 72)
                            8'h75,
                            8'h29: rotate     <= 1;         // Up arrow (E0 75) or Spacebar (29)
                        endcase
                        state <= IDLE;
                    end
                end
                BREAK: 
		  begin
                    state <= IDLE;
                  end
            endcase
        end
    end

endmodule
