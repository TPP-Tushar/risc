module register_file(
    input logic clk,
    input logic rst,
    input logic [3:0] read_sel1, read_sel2, write_sel,
    input logic [15:0] write_data,
    input logic write_en,
    output logic [15:0] read_data1, read_data2
);
    logic [15:0] reg_array[15:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 16; i++)
                reg_array[i] <= 16'b0;
        end else if (write_en) begin
            reg_array[write_sel] <= write_data;
        end
    end

    assign read_data1 = reg_array[read_sel1];
    assign read_data2 = reg_array[read_sel2];
endmodule