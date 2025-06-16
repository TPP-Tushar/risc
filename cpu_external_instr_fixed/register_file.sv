module register_file(
    input logic clk,
    input logic write_a,
    input logic write_b,
    input logic [15:0] data_in,
    output logic [15:0] rega,
    output logic [15:0] regb
);
    logic [15:0] rega_internal, regb_internal;

    always_ff @(posedge clk) begin
        if (write_a) rega_internal <= data_in;
        if (write_b) regb_internal <= data_in;
    end

    assign rega = rega_internal;
    assign regb = regb_internal;
endmodule