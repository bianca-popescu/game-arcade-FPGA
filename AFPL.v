module auto_piece (
    input clk,  
    input rst,  
    input tick,  
    output [3:0] x_pos,  
    output [4:0] y_pos,  
    output piece_active  
);
    reg [3:0] x_pos_reg;
    reg [4:0] y_pos_reg;
    reg piece_active_reg;
    
    assign x_pos=x_pos_reg;
    assign y_pos=y_pos_reg;
    assign piece_active = piece_active_reg;

    localparam [3:0] start_x = 4'd5;   
    localparam [4:0] start_y = 5'd0;     
    localparam [4:0] max_y  = 5'd19;   
 
always @(posedge clk or posedge rst) begin
    if (rst)
      begin
          x_pos_reg <= start_x;   
          y_pos_reg <= start_y;  
          piece_active_reg <= 1'b1;   
      end 
     else if (tick && piece_active_reg) 
       begin
           if (y_pos_reg < max_y) 
              begin   
                y_pos_reg <= y_pos_reg + 1;  
              end 
           else 
              begin
                piece_active_reg <= 1'b0;  
              end
        end
     end
endmodule




