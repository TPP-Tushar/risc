module instruction_memory(
    input logic [15:0] addr,
    output logic [15:0] instruction
);
    logic [15:0] mem[0:255];

    initial begin
        mem[0] = 16'b000001_0000101101; // LOADA 45
        mem[1] = 16'b000010_00110110;   // LOADB 54
        mem[2] = 16'b000011_00000000;   // ADD
        mem[3] = 16'b000100_00000000;   // READOUT
    end

    assign instruction = mem[addr];

endmodule