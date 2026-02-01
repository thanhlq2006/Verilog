module deserializer(
    input wire in_clock,
    input wire in_enable,
    input wire in_bit,
    output wire [7:0] out_data
);
    reg [7:0] internal = 0;
    assign out_data = internal;

    always @(posedge in_clock) begin
        if (in_enable) begin 
            internal <= (internal << 1) | in_bit;
        end
    end
endmodule