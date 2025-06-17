module alu(
    input logic [15:0] a, b,
    input logic [2:0] opcode,
    input logic mode,
    output logic [31:0] outALU,
    output logic za, zb, eq, gt, lt
);
    logic [31:0] arith_out, logic_out;

    arith_unit AU(a, b, opcode, arith_out);
    logic_unit LU(a, b, opcode, logic_out);

    assign outALU = (mode == 0) ? arith_out : logic_out;
    assign za = (a == 0);
    assign zb = (b == 0);
    assign eq = (a == b);
    assign gt = (a > b);
    assign lt = (a < b);
endmodule