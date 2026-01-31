module tb_alu();
    reg clock = 0;
    reg valid = 1;
    reg [7:0] lhs = 8'd19;
    reg [7:0] rhs = 8'd7;
    reg [2:0] funct = 3'b000;
    wire ovalid;
    wire [7:0] out;

    alu DUT(
        .in_clock(clock),
        .in_valid(valid),
        .in_lhs(lhs),
        .in_rhs(rhs),
        .in_function(funct),
        .out_valid(ovalid),
        .out_result(out)
    );
    
    always #5 clock <= ~clock;

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, tb_alu);
        #6; funct = 3'b001;
        #10; funct = 3'b010; 
        #10; funct = 3'b011; 
        #10; funct = 3'b100;
        #10; funct = 3'b101;
        #10; funct = 3'b110;
        #10; $finish;
    end

endmodule