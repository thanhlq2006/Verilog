module tb_serializer();
    reg clock = 1;
    reg write = 0;
    reg [7:0] data = 8'b10101010;
    reg enable = 0;
    wire out;

    serializer DUT(
        .in_clock(clock),
        .in_write(write),
        .in_data(data),
        .in_enable(enable),
        .out_bit(out)
    );

    always #5 clock <= ~clock;

    initial begin
        $dumpfile("tb_serializer.vcd");
        $dumpvars(0, tb_serializer);
        #2; write = 1; 
        #10; write = 0; data = 0;
        #10; enable = 1;
        #30; enable = 0;
        #20; write = 1; enable = 1; data = 8'b10110101;
        #10; write = 0; data = 0;
        #100; $finish;
    end
endmodule