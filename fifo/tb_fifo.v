module tb_fifo;

    localparam DATA_WIDTH = 8;
    localparam FIFO_ASIZE = 4;
    localparam DEPTH = (1 << FIFO_ASIZE);

    reg  in_clock = 0;
    reg  in_reset = 0;
    reg  in_put = 0;
    reg  in_take = 0;
    reg  [DATA_WIDTH-1:0] in_data = 0;

    wire out_empty;
    wire out_full;
    wire [DATA_WIDTH-1:0] out_data;

    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_ASIZE(FIFO_ASIZE)
    ) DUT (
        .in_clock(in_clock),
        .in_reset(in_reset),
        .in_put(in_put),
        .in_take(in_take),
        .in_data(in_data),
        .out_data(out_data),
        .out_empty(out_empty),
        .out_full(out_full)
    );

    always #5 in_clock = ~in_clock;

    task step(input put, input take, input [DATA_WIDTH-1:0] data);
    begin
        in_put  = put;
        in_take = take;
        in_data = data;
        #10;
    end
    endtask

    integer i;

    initial begin
        $dumpfile("tb_fifo.vcd");
        $dumpvars(0, tb_fifo);

        // -------- RESET --------
        in_reset = 1;
        step(0,0,0);
        in_reset = 0;
        step(0,0,0);

        step(1,0,8'hAA); // put 0xAA
        step(0,0,0);

        step(0,1,0); // take
        step(0,0,0);

        for (i = 0; i < DEPTH; i = i + 1) // fill to full
            step(1,0,i);
        step(0,0,0);

        step(1,0,8'hFF); //put when full 
        step(0,0,0);

        for (i = 0; i < 3; i = i + 1)
            step(0,1,0);
        step(0,0,0);

        step(1,1,8'h55); //put+take
        step(0,0,0);

        #50; $finish;
    end

endmodule
