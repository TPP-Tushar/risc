typedef enum logic [1:0] {
    RESET = 2'b00,
    LOAD = 2'b01,
    EXECUTE = 2'b10
} state_t;

module control_unit(
    input logic clk,
    input logic rst,
    output state_t current_state,
    output logic load_en, exec_en, fetch_en
);
    state_t state, next;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= RESET;
        else
            state <= next;
    end

    always_comb begin
        case(state)
            RESET: begin
                next = LOAD;
                load_en = 0;
                exec_en = 0;
                fetch_en = 0;
            end
            LOAD: begin
                next = EXECUTE;
                load_en = 1;
                exec_en = 0;
                fetch_en = 1;
            end
            EXECUTE: begin
                next = LOAD;
                load_en = 0;
                exec_en = 1;
                fetch_en = 0;
            end
        endcase
        current_state = state;
    end
endmodule