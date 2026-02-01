module tb_up_down_counter();
    reg clock = 1;
    reg reset = 0;
    reg start = 0;
    wire ready;
    wire [3:0] value;

    always #5 clock <= ~clock;

    up_down_counter DUT(
        .in_clock(clock),
        .in_reset(reset),
        .in_start(start),
        .out_ready(ready),
        .out_value(value)
    );

    initial begin
        $dumpfile("tb_up_down_counter.vcd");
        $dumpvars(0, tb_up_down_counter);

        #10; start = 1;
        #10; start = 0;
        #200; reset = 1;
        #10; reset = 0;
        #10; start = 1;
        #50; start = 0;
        #300; $finish;
    end
endmodule
