module register_file (
    input  logic        clk,
    input  logic        rst,
    input  logic        en,
    input  logic [15:0] d,
    output logic [15:0] q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 16'd0;
        else if (en)
            q <= d;
    end
endmodule