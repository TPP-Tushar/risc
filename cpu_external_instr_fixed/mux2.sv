module mux2(
    input logic [15:0] a,
    input logic [15:0] b,
    input logic sel,
    output logic [15:0] y
);
    assign y = sel ? b : a;
endmodule