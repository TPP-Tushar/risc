module program_memory(
    input logic [7:0] address,
    output logic [15:0] instruction
);
    logic [15:0] rom[255:0];
    assign instruction = rom[address];
endmodule