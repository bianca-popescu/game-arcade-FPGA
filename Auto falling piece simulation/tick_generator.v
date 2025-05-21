module tick_generator #(
    parameter N = 50000000  // Adjust based on your clock frequency
)(
    input clk,
    input rst,
    output reg tick
);

    reg [$clog2(N)-1:0] count;

    always @(posedge clk or posedge rst) begin
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

