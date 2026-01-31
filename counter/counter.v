module counter (
    input wire in_clock,
    input wire in_reset,
    input wire in_enable,
    output reg[7:0] out_value
);
    always @(posedge in_clock) begin
        if (in_reset) begin
            out_value <= 8'b00000000;
        end
        else if (in_enable) begin
            out_value <= out_value + 1;
        end
    end

endmodule

