`timescale 1ns / 1ps
module toggle(
    input wire in_clock,
    output wire out_data
    );
    reg latch = 1;

    always @(posedge in_clock) 
    begin
        latch <= ~latch;
    end
    assign out_data = latch;
endmodule