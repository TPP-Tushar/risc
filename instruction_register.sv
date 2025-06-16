module instruction_register(
    input logic clk,
    input logic [15:0] instruction,
    output logic [5:0] opcode,
    output logic [15:0] immediate
);
    always_ff @(posedge clk) begin
        opcode <= instruction[15:10];
        immediate <= instruction[9:0];
    end
endmodule