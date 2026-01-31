module alu(
    input wire in_clock,
    input wire in_valid,
    input wire [7:0] in_lhs,
    input wire [7:0] in_rhs,
    input wire [2:0] in_function,
    output reg out_valid = 1'b0,
    output wire [7:0] out_result
); 
    reg [7:0] temp = 0;

    always @(posedge in_clock) begin
        out_valid <= 1'b0;
        if (in_valid) begin
            case (in_function)
                3'b000 : temp <= in_lhs + in_rhs;
                3'b001 : temp <= in_lhs - in_rhs;
                3'b010 : temp <= in_lhs & in_rhs;
                3'b011 : temp <= in_lhs | in_rhs;
                3'b100 : temp <= in_lhs ^ in_rhs;
                3'b101 : temp <= in_lhs << in_rhs;
                3'b110 : temp <= in_lhs >> in_rhs;
            endcase
            out_valid <= 1'b1;
        end
    end

    assign out_result = temp;


endmodule