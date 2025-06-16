`timescale 1ns/1ps

module tb_top;

    logic clk;
    logic rst;
    logic [31:0] result;

    top uut (
        .clk(clk),
        .rst(rst),
        .result(result)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Starting simulation...");
        rst = 1; #10;
        rst = 0;

        repeat (10) @(posedge clk);

        $display("Final result = %0d", result);
        $display("Expected result = 99");

        if (result == 99)
            $display("✅ Test PASSED!");
        else
            $display("❌ Test FAILED!");

        $finish;
    end

endmodule