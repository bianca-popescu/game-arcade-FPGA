`timescale 1ns / 1ps

module background (
    input clk,                  // 50MHz
    output o_hsync,             // horizontal sync
    output o_vsync,             // vertical sync
    output [7:0] o_red,         // 8-bit color output
    output [7:0] o_blue,
    output [7:0] o_green
);

    reg [9:0] counter_x = 0;    // horizontal counter
    reg [9:0] counter_y = 0;    // vertical counter
    reg [7:0] r_red = 0;
    reg [7:0] r_blue = 0;
    reg [7:0] r_green = 0;

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
			if (counter_x < 799)					// Horizontal counter
				counter_x <= counter_x + 1;
			else
				counter_x <= 0;
	end  //always


    always @(posedge clk25Mhz) 
		begin
			if (counter_x == 799)          		  // Vertical counter
				begin
					if (counter_y < 525)
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;
			end   //if
    end  //always
	
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
					r_red   <= 8'h03;
					r_blue  <= 8'h87;     // #0387D0   albastru deschis
					r_green <= 8'hD0;   
				end //if
		/////////////////////////////////////////////////////////    END SECTION 1
		
		//////////////////////////////////////////////////////// SECTION 2
        else if (counter_y >= 75 && counter_y < 475) 
			begin
				if (counter_x < 264) 
					begin
						r_red   <= 8'h03;   
						r_blue  <= 8'h87;     // #0387D0   albastru deschis
						r_green <= 8'hD0;
					end  //if
				else if (counter_x >= 264 && counter_x < 464)
					begin
						r_red   <= 8'h03;
						r_blue  <= 8'h34;    // #03344F albastru inchis
						r_green <= 8'h4F;  
					end
				else  if (counter_x >464)
					begin
						r_red   <= 8'h03;
						r_blue  <= 8'h87;    // #0387D0   albastru deschis
						r_green <= 8'hD0;
					end
				end
		//////////////////////////////////////////////////////   END SECTION 2
		
		/////////////////////////////////////////////////////    SECTION 3
        else begin
            if (counter_y > 475)
				begin
					r_red   <= 8'h03;
					r_blue  <= 8'h87;  				 //#0387D0 albastru deschis
					r_green <= 8'hD0;
				end		
		end
	
	//////////////////////////////////////////////////////////// END SECTION 3

    ////////////////////////////////////////////////////////////////
    // Output color only during visible area (active video)
    assign o_red   = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red   : 8'h00;
    assign o_blue  = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue  : 8'h00;
    assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 8'h00;

endmodule
