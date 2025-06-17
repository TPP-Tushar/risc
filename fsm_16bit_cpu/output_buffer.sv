module output_buffer(
    input logic clk,
    input logic rst,
    input logic [15:0] data_in,
    input logic en,
    output logic [15:0] data_out
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 16'b0;
        else if (en)
            data_out <= data_in;
    end
endmodule