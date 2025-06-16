`timescale 1ns/1ps

module tb_top;

    logic clk;
    logic rst;
    logic [15:0] instr;
    logic instr_valid;
    logic [31:0] result;

    top uut (
        .clk(clk),
        .rst(rst),
        .instruction_in(instr),
        .instruction_valid(instr_valid),
        .result(result)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task send_instruction(input [15:0] i);
        begin
            instr = i;
            instr_valid = 1;
            @(posedge clk);
            instr_valid = 0;
        end
    endtask

    initial begin
        $display("Start Test");
        rst = 1; instr = 0; instr_valid = 0;
        @(posedge clk); rst = 0;

        // Send instructions: LOADA 45, LOADB 54, ADD, READOUT
        send_instruction(16'b000001_00101101); // LOADA 45
        send_instruction(16'b000010_00110110); // LOADB 54
        send_instruction(16'b000011_00000000); // ADD
        send_instruction(16'b000000_00000000); // NOP

        #20;
        $display("Result: %0d", result);
        $finish;
    end

endmodule