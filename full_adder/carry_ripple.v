//8-bit carry ripple adder
module counter (
    input wire in_clock,
    input wire in_reset,
    input wire in_enable,
    output wire[7:0] out_value
);
    reg[7:0] value;
    wire[7:0] carry;
    wire[7:0] sum;

    fa fa0(
        .i_a(value[0]),
        .i_b(1'b1),
        .c_i(1'b0),
        .s(sum[0]),
        .c_o(carry[0])
    );

    fa fa1(
        .i_a(value[1]),
        .i_b(1'b0),
        .c_i(carry[0]),
        .s(sum[1]),
        .c_o(carry[1])
    );

    fa fa2(
        .i_a(value[2]),
        .i_b(1'b0),
        .c_i(carry[1]),
        .s(sum[2]),
        .c_o(carry[2])
    );

    fa fa3(
        .i_a(value[3]),
        .i_b(1'b0),
        .c_i(carry[2]),
        .s(sum[3]),
        .c_o(carry[3])
    );

    fa fa4(
        .i_a(value[4]),
        .i_b(1'b0),
        .c_i(carry[3]),
        .s(sum[4]),
        .c_o(carry[4])
    );

    fa fa5(
        .i_a(value[5]),
        .i_b(1'b0),
        .c_i(carry[4]),
        .s(sum[5]),
        .c_o(carry[5])
    );

    fa fa6(
        .i_a(value[6]),
        .i_b(1'b0),
        .c_i(carry[5]),
        .s(sum[6]),
        .c_o(carry[6])
    );

    fa fa7(
        .i_a(value[7]),
        .i_b(1'b0),
        .c_i(carry[6]),
        .s(sum[7]),
        .c_o(carry[7])
    );
    
    assign out_value[7:0] = value[7:0];
endmodule