module regc (
    input  logic        clk,
    input  logic        rst,
    input  logic        en,
    input  logic [31:0] d,
    output logic [31:0] q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 32'd0;
        else if (en)
            q <= d;
    end
endmodule