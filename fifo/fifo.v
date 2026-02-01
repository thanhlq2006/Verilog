`include "./fifo_controller.v"

module fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_ASIZE = 4
)(
    input wire in_clock,
    input wire in_reset,
    input wire in_take,
    input wire in_put,
    output wire out_empty,
    output wire out_full,
    output wire [DATA_WIDTH-1:0] out_data,
    input wire [DATA_WIDTH-1:0] in_data
);
    wire [FIFO_ASIZE-1:0] write_address;
    wire [FIFO_ASIZE-1:0] read_address;

    fifo_controller controller(
        .in_clock(in_clock),
        .in_reset(in_reset),
        .in_put(in_put),
        .in_take(in_take),
        .out_empty(out_empty),
        .out_full(out_full),
        .out_read_pointer(read_address),
        .out_write_pointer(write_address)
    );

    reg [DATA_WIDTH-1:0] memory [0:(1<<FIFO_ASIZE)-1];
    reg [DATA_WIDTH-1:0] data;
    assign out_data = data;

    always @(posedge in_clock) begin
        if (in_reset) begin
            data <= 0;
        end
        else if (in_take && ~out_empty) begin
            data <= memory[read_address];
        end
        else begin
            data <= data;
        end
        if (in_put && ~out_full) begin
            memory[write_address] <= in_data;
        end

    end
endmodule
