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
        alu_op = 0;

        case (opcode)
            6'b000001: begin // LOADA
                write_a = 1;
            end
            6'b000010: begin // LOADB
                write_b = 1;
            end
            6'b000011: begin // ADD
                mux_sel_a = 0;
                mux_sel_b = 0;
                alu_op = 3'b000;
                write_c = 1;
            end
            6'b000100: begin // READOUT (NOP for now)
            end
        endcase
    end
endmodule