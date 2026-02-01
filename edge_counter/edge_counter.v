module edge_detector(
    input wire in_clock,
    input wire in_signal,
    output wire out_strobe
    );
    reg past = 0;

    always @(posedge in_clock)
    begin
        past <= in_signal;
    end

    assign out_strobe = ~past & in_signal;
endmodule

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

module edge_counter(
    input wire in_clock,
    input wire in_reset,
    input wire in_signal,
    output wire out_pulse,
    output wire [7:0] out_count
);

    edge_detector detector(
        .in_clock(in_clock),
        .in_signal(in_signal),
        .out_strobe(out_pulse)
    );

    counter count(
        .in_clock(in_clock),
        .in_reset(in_reset),
        .in_enable(out_pulse),
        .out_value(out_count)
    );

endmodule