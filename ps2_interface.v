module ps2_interface (
    input wire clk,           // System clock
    input wire ps2_clk,       // PS/2 clock line
    input wire ps2_data,      // PS/2 data line
    output reg [7:0] scancode, // Output: 8-bit scancode
    output reg ready          // Output: goes high for 1 clk when a valid scancode is ready
);

    // Synchronize ps2_clk to system clk to detect edges safely
    reg [2:0] ps2_clk_sync;
    always @(posedge clk) begin
        ps2_clk_sync <= {ps2_clk_sync[1:0], ps2_clk};
    end

    wire falling_edge = (ps2_clk_sync[2:1] == 2'b10);

    reg [3:0] bit_count = 0;         // Count bits from 0 to 10 (11 bits per frame)
    reg [10:0] shift_reg = 0;        // Store all 11 bits (start, 8 data, parity, stop)
    reg [7:0] last_scancode = 0;

    always @(posedge clk) begin
        ready <= 0;

        if (falling_edge) begin
            shift_reg <= {ps2_data, shift_reg[10:1]}; // Shift in bit from ps2_data
            bit_count <= bit_count + 1;

            if (bit_count == 10) begin
                // After receiving full 11-bit frame
                bit_count <= 0;

                // Frame format: [stop][parity][data][...][start]
                // Check start bit == 0 and stop bit == 1
                if (shift_reg[0] == 0 && ps2_data == 1) begin
                    // Optionally: check for parity here if desired
                    last_scancode <= shift_reg[8:1]; // Data bits
                    scancode <= shift_reg[8:1];
                    ready <= 1; // Tell system a new key was received
                end
            end
        end
    end
endmodule
