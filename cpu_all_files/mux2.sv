module mux2 #(parameter WIDTH = 16) (
    input  logic             sel,
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    output logic [WIDTH-1:0] out
);
    assign out = sel ? in1 : in0;
endmodule