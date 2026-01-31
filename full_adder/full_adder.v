module fa(
    input wire i_a,
    input wire i_b, 
    input wire c_i,
    output wire c_o, 
    output wire s
);
    assign s = (i_a ^ i_b) ^ c_i;
    assign c_o = (i_a & i_b) | ((i_a ^ i_b) & c_i);
endmodule
