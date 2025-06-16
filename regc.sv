module regc(
    input logic clk,
    input logic we,
    input logic [31:0] din,
    output logic [31:0] dout
);
    always_ff @(posedge clk) begin
        if (we)
            dout <= din;
    end
endmodule