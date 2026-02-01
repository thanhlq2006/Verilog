module fifo_controller #(
    parameter FIFO_ASIZE = 4
)(
    input wire in_clock,
    input wire in_reset,
    input wire in_take,
    input wire in_put,
    output wire out_empty,
    output wire out_full,
    output wire [FIFO_ASIZE-1:0] out_write_pointer,
    output wire [FIFO_ASIZE-1:0] out_read_pointer
);
    reg [FIFO_ASIZE:0] read_pointer;
    reg [FIFO_ASIZE:0] write_pointer; // write pointer can go back to begin when memory is full, then the extra bit indicates it went back

    assign out_write_pointer = write_pointer[FIFO_ASIZE-1:0];
    assign out_read_pointer  = read_pointer[FIFO_ASIZE-1:0];

    assign out_empty = (read_pointer == write_pointer); // read pointer catches write pointer, higher addresses are not written or already read, write is allowed
    assign out_full = (read_pointer[FIFO_ASIZE-1:0] == write_pointer[FIFO_ASIZE-1:0]) // read pointer went back to begin, so higher addresses are unread and cannot be overwritten
                && (read_pointer[FIFO_ASIZE] != write_pointer[FIFO_ASIZE]);

    always @(posedge in_clock) begin
        if (in_reset) begin // reset case
            read_pointer <= 0;
            write_pointer <= 0;
        end
        else begin
            if (out_empty) begin // empty case: only in_put or both is allowed
                if (in_put && ~in_take) begin
                    write_pointer <= write_pointer + 1;
                end
                else if (in_put && in_take) begin
                    write_pointer <= write_pointer + 1;
                    read_pointer <= read_pointer + 1;
                end
            end
            else if (out_full) begin // full case: only in_take or both is allowed
                if (in_take & ~in_put) begin 
                    read_pointer <= read_pointer + 1;
                end
                else if (in_put & in_take) begin
                    write_pointer <= write_pointer + 1;
                    read_pointer <= read_pointer + 1;
                end
            end
            else begin // normal case: everything is allowed
                if (in_take) begin
                    read_pointer <= read_pointer + 1;
                end
                if (in_put) begin
                    write_pointer <= write_pointer + 1;
                end
            end
        end
    end
endmodule