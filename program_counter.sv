module program_counter(
    input logic clk,
    input logic rst,
    output logic [15:0] pc
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        else
            pc <= pc + 1;
    end
endmodule