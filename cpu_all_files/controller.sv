module controller (
    input  logic [5:0] opcode,
    output logic rega_en,
    output logic regb_en,
    output logic regc_en,
    output logic muxa_sel,
    output logic muxb_sel,
    output logic [2:0] alu_op
);
    always_comb begin
        rega_en    = 0;
        regb_en    = 0;
        regc_en    = 0;
        muxa_sel   = 0;
        muxb_sel   = 0;
        alu_op     = 3'b000;
        case (opcode)
            6'b000001: begin // LOADA
                rega_en    = 1;
                muxa_sel   = 1;
            end
            6'b000010: begin // LOADB
                regb_en    = 1;
                muxb_sel   = 1;
            end
            6'b000011: begin // ADD
                regc_en    = 1;
                alu_op     = 3'b000;
            end
            6'b000100: begin // SUB
                regc_en    = 1;
                alu_op     = 3'b001;
            end
            6'b000101: begin // AND
                regc_en    = 1;
                alu_op     = 3'b010;
            end
            6'b000110: begin // OR
                regc_en    = 1;
                alu_op     = 3'b011;
            end
            6'b000111: begin // XOR
                regc_en    = 1;
                alu_op     = 3'b100;
            end
        endcase
    end
endmodule