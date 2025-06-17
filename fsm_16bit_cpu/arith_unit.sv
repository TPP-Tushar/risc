module arith_unit(
    input logic [15:0] a, b,
    input logic [2:0] opcode,
    output logic [31:0] result
);
    always_comb begin
        case (opcode)
            3'b000: result = {16'b0, a + b};
            3'b001: result = {16'b0, a - b};
            3'b010: result = a * b;
            3'b011: result = b != 0 ? a / b : 32'hFFFFFFFF;
            default: result = 32'b0;
        endcase
    end
endmodule