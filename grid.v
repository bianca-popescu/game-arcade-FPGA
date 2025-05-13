module grid (
    input logic clk,
    input logic rst,
    input logic [3:0]x, // 3 doar 4 biti sunt necesari pana la 9
    input logic [4:0]y, // 5 biti pana la 19
    input logic enable_reading,
    input logic enable_writing,
    input logic state_of_the_cell_input,
    output logic state_of_the_cell_output
);

// logic = un tip de dapte din SystemVerilog care este mai putin ambiguu decat
// reg si wire din verilog original
// logic se comporta ca un reg (pentru intrari iesiri si semnale interne)
// logic = poate lua 1 sau 0

    reg [0:0] grid [0:19][0:9];

    // De ce se foloseste always_comb in loc de always @(*) ? 
    //     - Este mai sigur de folosit deoarece reinitializeaza semnalele
    //     - Este mai clar faptul ca este logica combinationala
    
    always_comb begin
        if (enable_reading) begin
            state_of_the_cell_output = grid[y][x];
        end else begin
            state_of_the_cell_output = 1'b0;
        end
    end
    
    // Pare invers la indici. But why? - Daca e un grid unde x e axa Ox si y axa Oy, atunci y sunt indicatorii pt linii si x sunt coloane

    // La fel si cu always_ff (ff vine de la flip-flop)
    //      - Este special gandit pentru blocuri secventiale
    //      - Protejeaza de greseli
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Curatarea grid-ului, cu reset activ pe 1
            integer i,j;
            for (i=0;i<20;i=i+1) begin
                for (j=0;j<10;j=j+1) begin
                    grid[i][j] <= 1'b0;
                end
            end
        end else if (enable_writing) begin
            grid[y][x] <= state_of_the_cell_input;
        end
    end

endmodule

