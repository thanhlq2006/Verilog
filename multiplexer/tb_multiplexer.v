module tb_multiplexer();
    reg I0 = 0;
    reg I1 = 0;
    reg I2 = 0;
    reg I3 = 0;
    reg [1:0] S = 2'b00;
    wire out;

    multiplexer DUT(
        .I0(I0),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .S(S),
        .O(O)
    );

    initial begin 
        $dumpfile("tb_multiplexer.vcd");
        $dumpvars(0, tb_multiplexer);

        #3; I0 = 1;
        #3; I0 = 0; I1 = 1;
        #3; S = 2'b01;
        #3; S = 2'b10;
        #2; I2 = 1;
        #1; S = 3'b11;
        #1; I3 = 1;
        #5; $finish;
    end
endmodule
