module instruction_register(
    input logic clk,
    input logic [15:0] instruction,
    input logic valid,
    output logic [5:0] opcode,
    output logic [15:0] immediate
);
    always_ff @(posedge clk) begin
        if (valid) begin
            opcode <= instruction[15:10];
            immediate <= {6'b0, instruction[9:0]}; // Extend to 16-bit
        end
    end
endmodule