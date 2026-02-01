module tb_deserializer();
    reg clock = 1;
    reg enable = 0;
    reg bit = 0;
    wire [7:0] data;

    deserializer DUT(
        .in_clock(clock),
        .in_bit(bit),
        .in_enable(enable),
        .out_data(data)
    );

    always #5 clock <= ~clock;

    initial begin
        $dumpfile("tb_deserializer.vcd");
        $dumpvars(0, tb_deserializer);

        #2; enable = 1; bit = 1;
        #10; bit = 0;
        #5; enable = 0;
        #10; bit = 1;
        #10; enable = 1;
        #10; bit = 0;
        #20; enable = 0;
        #10; $finish;

    end
endmodule