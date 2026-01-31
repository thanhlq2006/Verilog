module multiplexer(
    input wire I1,
    input wire I2,
    input wire I3,
    input wire I0,
    input wire [1:0] S,
    output wire O
);
    assign O = (I0&(~S[0])&(~S[1]) | (I1&(S[0])&(~S[1])) | (I2&(~S[0])&(S[1])) | (I3&(S[0])&(S[1])));
endmodule