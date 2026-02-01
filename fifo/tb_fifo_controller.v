module tb_fifo_controller();

    localparam FIFO_ASIZE = 4;              
    localparam DEPTH = (1 << FIFO_ASIZE);

    reg  in_clock = 0;
    reg  in_reset = 0;
    reg  in_take  = 0;
    reg  in_put   = 0;

    wire out_empty;
    wire out_full;
    wire [FIFO_ASIZE-1:0] out_write_pointer;
    wire [FIFO_ASIZE-1:0] out_read_pointer;

    fifo_controller #(
        .FIFO_ASIZE(FIFO_ASIZE)
    ) dut (
        .in_clock(in_clock),
        .in_reset(in_reset),
        .in_take(in_take),
        .in_put(in_put),
        .out_empty(out_empty),
        .out_full(out_full),
        .out_write_pointer(out_write_pointer),
        .out_read_pointer(out_read_pointer)
    );

    always #5 in_clock = ~in_clock;

    task step(input put, input take);
    begin
        in_put  = put;
        in_take = take;
        #10;
    end
    endtask

    integer i;

    initial begin
        $dumpfile("tb_fifo_controller.vcd");
        $dumpvars(0, tb_fifo_controller);

        in_reset = 1;
        step(0,0);
        step(0,0);
        in_reset = 0;

        //TAKE when EMPTY (should NOT move read pointer)
        step(0,1);
        step(0,0);

        //PUT when EMPTY (should write one entry)
        step(1,0);
        step(0,0);

        //PUT+TAKE when AVAIL
        step(1,1);
        step(0,0);

        //TAKE only in AVAIL
        step(0,1);
        step(0,0);

        //Drain until EMPTY (extra TAKE attempts too)
        for (i = 0; i < 3; i = i + 1)
            step(0,1);
        step(0,0);

        //now empty again -> take should do nothing
        step(0,1);
        step(0,0);

        //Fill FIFO until FULL
        for (i = 0; i < DEPTH; i = i + 1)
            step(1,0);
        step(0,0);

        //PUT when FULL (should do nothing)
        step(1,0);
        step(0,0);

        //TAKE when FULL (should start freeing space)
        step(0,1);
        step(0,0);

        //PUT+TAKE while not empty/not full (AVAIL)
        for (i = 0; i < 5; i = i + 1)
            step(1,1);
        step(0,0);

        #50; $finish;
end

endmodule