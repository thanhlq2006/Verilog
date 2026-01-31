`timescale 1ns / 1ps
module tb_toggle();
    reg clock = 0;
    wire out;

    toggle DUT(
        .in_clock(clock),
        .out_data(out)
    );
    always #5 clock <= !clock;

    initial begin
        $dumpfile("tb_toggle.vcd");
        $dumpvars(0, tb_toggle);
        #30; $finish;
    end
endmodule