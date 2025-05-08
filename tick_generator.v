module tick_generator #(
    parameter N = 50000000  // Adjust this based on your clock frequency
)(
    input logic clk,
    input logic rst,
    output logic tick
);

    logic [$clog2(N)-1:0] count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tick <= 0;
        end else begin
            if (count == N-1) begin
                count <= 0;
                tick <= 1;
            end else begin
                count <= count + 1;
                tick <= 0;
            end
        end
    end

endmodule
