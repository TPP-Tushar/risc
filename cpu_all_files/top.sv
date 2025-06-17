module top (
    input  logic        clk,
    input  logic        rst,
    input  logic [15:0] instruction_in,
    input  logic        instruction_valid,
    output logic [31:0] result
);
    logic [5:0]  opcode;
    logic [9:0]  immediate;

    logic [15:0] a, b, muxa_out, muxb_out;
    logic [31:0] alu_result;
    logic        rega_en, regb_en, regc_en;
    logic        muxa_sel, muxb_sel;
    logic [2:0]  alu_op;
    logic [15:0] rega_out, regb_out;
    logic [31:0] regc_out;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            opcode    <= 6'b0;
            immediate <= 10'b0;
        end else if (instruction_valid) begin
            opcode    <= instruction_in[15:10];
            immediate <= instruction_in[9:0];
        end
    end

    controller ctrl (
        .opcode(opcode),
        .rega_en(rega_en),
        .regb_en(regb_en),
        .regc_en(regc_en),
        .muxa_sel(muxa_sel),
        .muxb_sel(muxb_sel),
        .alu_op(alu_op)
    );

    register_file rega (
        .clk(clk),
        .rst(rst),
        .en(rega_en),
        .d({6'b0, immediate}),
        .q(rega_out)
    );

    register_file regb (
        .clk(clk),
        .rst(rst),
        .en(regb_en),
        .d({6'b0, immediate}),
        .q(regb_out)
    );

    mux2 #(16) muxa (
        .sel(muxa_sel),
        .in0(rega_out),
        .in1({6'b0, immediate}),
        .out(muxa_out)
    );

    mux2 #(16) muxb (
        .sel(muxb_sel),
        .in0(regb_out),
        .in1({6'b0, immediate}),
        .out(muxb_out)
    );

    ALU alu (
        .a(muxa_out),
        .b(muxb_out),
        .opcode(alu_op),
        .out(alu_result)
    );

    regc regc_inst (
        .clk(clk),
        .rst(rst),
        .en(regc_en),
        .d(alu_result),
        .q(regc_out)
    );

    assign result = regc_out;
endmodule