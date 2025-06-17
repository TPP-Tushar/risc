module data_memory(
    input logic clk,
    input logic rst,
    input logic [7:0] address,
    input logic [15:0] write_data,
    input logic read_en, write_en,
    output logic [15:0] read_data
);
    logic [15:0] mem[255:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 256; i++)
                mem[i] <= 16'b0;
        end else if (write_en) begin
            mem[address] <= write_data;
        end
    end

    assign read_data = (read_en) ? mem[address] : 16'bz;
endmodule