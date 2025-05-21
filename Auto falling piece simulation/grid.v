module grid (
    input clk,
    input rst,
    input [3:0] x, // 3 doar 4 biti sunt necesari pana la 9
    input [4:0] y, // 5 biti pana la 19
    input enable_reading,
    input enable_writing,
    input state_of_the_cell_input,
    output reg state_of_the_cell_output
);

    reg grid_mem [0:19][0:9];

    always @(*) begin
        if (enable_reading) begin
            state_of_the_cell_output = grid_mem[y][x];
        end else begin
            state_of_the_cell_output = 1'b0;
        end
    end
    
    // Pare invers la indici. But why? - Daca e un grid unde x e axa Ox si y axa Oy, atunci y sunt indicatorii pt linii si x sunt coloane

    // La fel si cu always_ff (ff vine de la flip-flop)
    //      - Este special gandit pentru blocuri secventiale
    //      - Protejeaza de greseli
    

    integer i, j;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Curatarea grid-ului, cu reset activ pe 1
     
            for (i = 0; i < 20; i = i + 1) begin
                for (j = 0; j < 10; j = j + 1) begin
                    grid_mem[i][j] <= 1'b0;
                end
            end
        end else if (enable_writing) begin
            grid_mem[y][x] <= state_of_the_cell_input;
        end
    end

endmodule
