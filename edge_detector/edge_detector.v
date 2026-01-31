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