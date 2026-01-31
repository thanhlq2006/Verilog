`timescale 1ns / 1ps
module button(
    input wire button0,
    input wire button1, 
    input wire button2,
    output wire LED0,
    output wire LED1,
    output wire LED2
    );

    assign LED0 = ~(~button0 & ~button2 & button1);
    assign LED1 = ~(~button1 & ~button2 & button0);
    assign LED2 = ~(~button0 & ~button1 & ~button2);
endmodule