module decoder(
    input logic [5:0] opcode,
    output logic write_a,
    output logic write_b,
    output logic write_c,
    output logic mux_sel_a,
    output logic mux_sel_b,
    output logic [2:0] alu_op
);
    always_comb begin
        write_a = 0;
        write_b = 0;
        write_c = 0;
        mux_sel_a = 0;
        mux_sel_b = 0;
        alu_op = 3'b000;

        case (opcode)
            6'b000001: write_a = 1; // LOADA
            6'b000010: write_b = 1; // LOADB
            6'b000011: begin // ADD
                write_c = 1;
                alu_op = 3'b000;
            end
            6'b000100: begin // SUB
                write_c = 1;
                alu_op = 3'b001;
            end
            6'b000101: begin // AND
                write_c = 1;
                alu_op = 3'b010;
            end
            6'b000110: begin // OR
                write_c = 1;
                alu_op = 3'b011;
            end
            6'b000111: begin // XOR
                write_c = 1;
                alu_op = 3'b100;
            end
            default: ; // NOP
        endcase
    end
endmodule