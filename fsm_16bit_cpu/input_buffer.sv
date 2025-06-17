module input_buffer(
    input logic clk,
    input logic rst,
    input logic [15:0] in_data,
    input logic en,
    output logic [15:0] buffered_data
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            buffered_data <= 16'b0;
        else if (en)
            buffered_data <= in_data;
    end
endmodule