module up_down_counter(
    input wire in_clock,
    input wire in_reset,
    input wire in_start,
    output wire out_ready,
    output wire [3:0] out_value
);
    localparam [1:0] s_IDLE = 2'b00,
                     s_UP = 2'b10,
                     s_DOWN = 2'b01;

    reg [1:0] state = s_IDLE;
    reg [3:0] value = 4'b0000;
    reg avail = 0;

    assign out_value = value;
    assign out_ready = avail;

    always @(posedge in_clock) begin
        if (in_reset) begin
            state <= s_IDLE;
            value <= 0;
        end
        else begin
            case (state)
                s_IDLE : begin 
                    avail <= 1; 
                    if (in_start) begin 
                        state <= s_UP; 
                    end
                end
                s_UP : begin 
                    avail <= 0;
                    value <= (value + 1);
                    if (value == 4'b1110) begin 
                        state <= s_DOWN;  
                    end
                end
                s_DOWN : begin
                    avail <= 0;
                    value <= (value - 1); 
                    if (value == 4'b0001) begin 
                        state <= s_IDLE; 
                    end
                end
            endcase
        end
    end

endmodule