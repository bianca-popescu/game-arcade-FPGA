`timescale 1ns / 1ps

module background (
    input clk,                  // 50MHz
    output o_hsync,             // horizontal sync
    output o_vsync,             // vertical sync
    output [3:0] o_red,         // 8-bit color output
    output [3:0] o_blue,
    output [3:0] o_green
);

    reg [9:0] counter_x = 0;    // horizontal counter
    reg [9:0] counter_y = 0;    // vertical counter
    reg [3:0] r_red = 0;
    reg [3:0] r_blue = 0;
    reg [3:0] r_green = 0;

    wire clk25Mhz;

    ////////////////////////////////////////////////////////////////
    // Clock divider: 50 MHz -> 25 MHz  Bianca
    clock_divider #(
        .DIVISOR(2)
    ) uut (
        .clock_in(clk),
        .clock_out(clk25Mhz)
    );

    ////////////////////////////////////////////////////////////////
	//Counter and sync generation
	
    always @(posedge clk25Mhz) 
		begin
			if (counter_x <= 799)					// Horizontal counter
				counter_x <= counter_x + 1;
			else
				counter_x <= 0;
	end  //always


    always @(posedge clk25Mhz) 	
		begin 	
			//if(counter_x == 799)
			//begin									  
				if (counter_y < 525)				// Vertical counter
					counter_y <= counter_y + 1;
				else
					counter_y <= 0;
			end //if
    		//end  //always
	
	//end counter and sync generation
    ////////////////////////////////////////////////////////////////
    // HSYNC and VSYNC output assigments
    assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1 : 0;
    assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1 : 0;

    ////////////////////////////////////////////////////////////////

    // Background color generation
   always @(posedge clk25Mhz) 
		begin
		///////////////////////////////////////////////////////////// SECTION 1 
			if (counter_y < 75) 
				begin
					r_red   <= 4'hf;
					r_blue  <= 4'hf;     // #0387D0   alb
					r_green <= 4'hf;   
				end //if
		/////////////////////////////////////////////////////////    END SECTION 1
		
		//////////////////////////////////////////////////////// SECTION 2
        else if (counter_y >= 75 && counter_y < 475) 
			begin
				if (counter_x < 264) 
					begin
						r_red   <= 4'hf;   
						r_blue  <= 4'hf;     // #0387D0   alb
						r_green <= 4'hf;
					end  //if
				else if (counter_x >= 264 && counter_x < 464)
					begin
						r_red   <= 4'hf;
						r_blue  <= 4'h0;    // #03344F galben
						r_green <= 4'hf;  
					end
				else  if (counter_x >464)
					begin
						r_red   <= 4'hf;
						r_blue  <= 4'hf;    // #0387D0   alb
						r_green <= 4'hf;
					end
			end
		//////////////////////////////////////////////////////   END SECTION 2
		
		/////////////////////////////////////////////////////    SECTION 3
        else if (counter_y > 475)
			begin
					r_red   <= 4'hf;
					r_blue  <= 4'hf;  				 //#0387D0 alb
					r_green <= 4'hf;
			end		
	end //always
	
	//////////////////////////////////////////////////////////// END SECTION 3
    ////////////////////////////////////////////////////////////////
    // Output color only during visible area (active video)
    assign o_red   = (counter_x >= 144 && counter_x < 784 && counter_y >= 35 && counter_y < 515) ? r_red   : 4'h0;
    assign o_blue  = (counter_x >= 144 && counter_x < 784 && counter_y >= 35 && counter_y < 515) ? r_blue  : 4'h0;
    assign o_green = (counter_x >= 144 && counter_x < 784 && counter_y >= 35 && counter_y < 515) ? r_green : 4'h0;

endmodule

