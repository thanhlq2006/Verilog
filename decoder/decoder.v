module decoder #(
    parameter NUM_OUTPUT = 4
) (
    input wire [$clog2(NUM_OUTPUT)-1:0] in_address,
    output wire [NUM_OUTPUT-1:0] out_select,
    output wire out_error
);

    assign out_error = (in_address >= NUM_OUTPUT); //out_select max index is NUM_OUTPUT - 1, which is the maximum of in_address
    assign out_select = (out_error & 0) | (~out_error & (1 <<  in_address));

endmodule