module serializer (
    input wire in_clock,
    input wire in_write,
    input wire [7:0] in_data,
    input wire in_enable,
    output wire out_bit
);
    reg [7:0] internal;
    reg [2:0] pointer;
    assign out_bit = internal[pointer];

    always @(posedge in_clock) begin
        if (in_write) begin
            internal <= in_data;
            pointer = 7;
        end
        else if (in_enable) begin // in_write is given higher priority than in_enable
            if (pointer > 0) begin
                pointer <= pointer - 1;
            end
            else begin // undefined value to out_bit
                internal[pointer] <= 1'bx;
            end
        end
    end
endmodule