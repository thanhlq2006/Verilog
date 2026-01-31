module tb_decoder ();
    parameter num = 5;
    reg [$clog2(num)-1:0] address = 0;
    wire [num-1:0] select;
    wire error;

    decoder #(.NUM_OUTPUT(num)) DUT (
        .in_address(address),
        .out_select(select),
        .out_error(error)
    );

    initial begin 
        $dumpfile("tb_decoder.vcd");
        $dumpvars(0, tb_decoder);
        #5; address = 1;
        #5; address = 2;
        #5; address = 3;
        #5; address = 4;
        #5; address = 5;
        #5; address = 6;
        #5; address = 7;
        #5; $finish;
    end
endmodule