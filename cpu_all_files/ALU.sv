module ALU (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [2:0]  opcode,
    output logic [31:0] out
);
    always_comb begin
        case(opcode)
            3'b000: out = a + b;
            3'b001: out = a - b;
            3'b010: out = a & b;
            3'b011: out = a | b;
            3'b100: out = a ^ b;
            default: out = 32'd0;
        endcase
    end
endmodule