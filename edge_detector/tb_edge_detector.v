module tb_edge_detector();
    reg clock = 0;
    reg signal = 0;
    wire out;

    always #5 clock <= !clock;
    
    edge_detector DUT(
        .in_clock(clock),
        .in_signal(signal),
        .out_strobe(out)
    );

    initial begin
        $dumpfile("tb_edge_detector.vcd");
        $dumpvars(0, tb_edge_detector);

        #7 signal = 1;
        #5 signal = 0;
        #10 signal = 1;
        #10 $finish;
    end

endmodule