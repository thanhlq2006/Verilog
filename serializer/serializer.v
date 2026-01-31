module serializer(
    input wire in_clock,
    input wire in_write,
    input wire [7:0] in_data,
    input wire in_enable,
    output wire out_bit
);
    reg [7:0] internal;
    assign out_bit = internal[7];

    always @(posedge in_clock) begin
        if (in_write) begin
            internal <= in_data;
        end
        else if (in_enable) begin // in_write is given higher priority than in_enable
            internal <= (internal << 1);
        end
    end
endmodule