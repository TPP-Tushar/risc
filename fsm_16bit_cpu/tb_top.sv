`timescale 1ns/1ps

module tb_top;

    logic clk, rst;
    logic [15:0] ext_input;
    logic [15:0] ext_output;

    top dut (
        .clk(clk),
        .rst(rst),
        .ext_input(ext_input),
        .ext_output(ext_output)
    );

    always #5 clk = ~clk;

    initial begin
        $display("Starting simulation...");
        clk = 0;
        rst = 1;
        ext_input = 16'h0000;

        #10 rst = 0;

        force dut.inst = 16'b000_0_0000_0001_0000;  // Example ADD instruction
        ext_input = 16'h0011;  // External input value
        #10;

        force dut.state = 2'b01; // LOAD
        force dut.load_en = 1;
        force dut.fetch_en = 1;
        #10;

        force dut.state = 2'b10; // EXECUTE
        force dut.load_en = 0;
        force dut.exec_en = 1;
        force dut.fetch_en = 0;
        #10;

        release dut.state;
        release dut.load_en;
        release dut.exec_en;
        release dut.fetch_en;
        release dut.inst;

        #50;
        $display("ext_output: %h", ext_output);
        $finish;
    end

endmodule