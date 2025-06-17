module top(
    input logic clk,
    input logic rst,
    input logic [15:0] ext_input,
    output logic [15:0] ext_output
);
    logic [15:0] inst;
    logic [7:0] pc;
    logic [15:0] reg1, reg2_rf, reg2_inbuf, reg2;
    logic [31:0] alu_out;
    logic [15:0] mem_out;
    logic [15:0] output_reg;
    logic load_en, exec_en, fetch_en;
    logic [2:0] opcode;
    logic mode;
    logic [3:0] rdst, rsrc;

    state_t state;

    program_memory pmem(pc, inst);
    control_unit CU(clk, rst, state, load_en, exec_en, fetch_en);
    register_file RF(
        .clk(clk),
        .rst(rst),
        .read_sel1(rsrc),
        .read_sel2(rdst),
        .write_sel(rdst),
        .write_data(alu_out[15:0]),
        .write_en(exec_en),
        .read_data1(reg1),
        .read_data2(reg2_rf)
    );
    alu ALU(reg1, reg2, opcode, mode, alu_out, , , , , );
    data_memory DM(clk, rst, alu_out[7:0], reg2, fetch_en, exec_en, mem_out);
    input_buffer INBUF(clk, rst, ext_input, fetch_en, reg2_inbuf);
    output_buffer OUTBUF(clk, rst, alu_out[15:0], exec_en, ext_output);

    assign reg2 = (state == LOAD) ? reg2_inbuf : reg2_rf;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        else if (fetch_en)
            pc <= pc + 1;
    end

    always_comb begin
        opcode = inst[15:13];
        mode   = inst[12];
        rdst   = inst[11:8];
        rsrc   = inst[7:4];
    end
endmodule