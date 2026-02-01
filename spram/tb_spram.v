module tb_spram();
    reg in_clock = 1;
    reg in_reset = 1;
    reg in_enable = 0;
    reg in_write = 0;
    reg  [9:0]  in_address = 0;
    reg  [15:0] in_data = 0;
    wire [15:0] out_data;

    spram DUT (
        .in_clock (in_clock),
        .in_reset (in_reset),
        .in_enable (in_enable),
        .in_write (in_write),
        .in_address (in_address),
        .in_data (in_data),
        .out_data (out_data)
    );

    always #5 in_clock = ~in_clock;

    initial begin
        $dumpfile("tb_spram.vcd");
        $dumpvars(0, tb_spram);

        #20; in_reset = 0;
        #10; in_enable = 1; in_write = 1; in_address = 10; in_data = 16'h1234;
        #10; in_write = 0; in_enable = 0;
        #10; in_enable = 1;
        #10; in_address = 20;
        #10; in_enable  = 1; in_write = 1; in_address = 20; in_data = 16'hABCD;
        #10; in_write = 0;
        #20; in_reset = 1;
        #10; in_reset = 0; 
        #10; in_write = 1; in_address = 10; in_data = 15;
        #10; in_write = 0; in_enable = 0;
        #15; in_enable = 1;
        #10; in_write = 1;
        #20; $finish;
    end

endmodule