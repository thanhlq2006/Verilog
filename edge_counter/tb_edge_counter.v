module tb_edge_counter();
    reg clock = 1;
    reg signal = 1;
    reg reset = 1;
    wire pulse;
    wire [7:0] count;

    always #5 clock <= ~clock;

    edge_counter DUT(
        .in_clock(clock),
        .in_reset(reset),
        .in_signal(signal),
        .out_pulse(pulse),
        .out_count(count)
    );

    initial begin
        $dumpfile("tb_edge_counter.vcd");
        $dumpvars(0, tb_edge_counter);
        #11; reset = 0; signal = 0;
        #20; signal = 1;
        #10; signal = 0;
        #30; signal = 1;
        #50; signal = 0; 
        #10; signal = 1; reset = 1;
        #30; $finish;
    end
endmodule