module top(
    input logic clk,
    input logic rst,
    output logic [31:0] result
);

    logic [15:0] instruction;
    logic [5:0] opcode;
    logic [15:0] immediate;
    logic [15:0] rega, regb;
    logic [15:0] muxa_out, muxb_out;
    logic [31:0] alu_out;
    logic [2:0] alu_op;
    logic write_a, write_b, write_c, mux_sel_a, mux_sel_b;
    logic [15:0] pc_out;

    // Program Counter
    program_counter pc (
        .clk(clk),
        .rst(rst),
        .pc(pc_out)
    );

    // Instruction Memory
    instruction_memory imem (
        .addr(pc_out),
        .instruction(instruction)
    );

    // Instruction Register
    instruction_register ireg (
        .clk(clk),
        .instruction(instruction),
        .opcode(opcode),
        .immediate(immediate)
    );

    // Decoder
    decoder decode (
        .opcode(opcode),
        .write_a(write_a),
        .write_b(write_b),
        .write_c(write_c),
        .mux_sel_a(mux_sel_a),
        .mux_sel_b(mux_sel_b),
        .alu_op(alu_op)
    );

    // Register File (A and B)
    register_file regfile (
        .clk(clk),
        .write_a(write_a),
        .write_b(write_b),
        .data_in(immediate),
        .rega(rega),
        .regb(regb)
    );

    // MUX A
    mux2 muxa (
        .a(rega),
        .b(immediate),
        .sel(mux_sel_a),
        .y(muxa_out)
    );

    // MUX B
    mux2 muxb (
        .a(regb),
        .b(immediate),
        .sel(mux_sel_b),
        .y(muxb_out)
    );

    // ALU
    ALU alu (
        .a(muxa_out),
        .b(muxb_out),
        .opcode(alu_op),
        .out(alu_out)
    );

    // RegC
    regc regc_inst (
        .clk(clk),
        .we(write_c),
        .din(alu_out),
        .dout(result)
    );

endmodule