`timescale 1ns / 1ps

module tb_button;

    reg button0;
    reg button1;
    reg button2;
    wire LED0;
    wire LED1;
    wire LED2;

    // Instantiate DUT
    button DUT(
        .button0(button0),
        .button1(button1),
        .button2(button2),
        .LED0(LED0),
        .LED1(LED1),
        .LED2(LED2)
    );

    initial begin
        $dumpfile("tb_button.vcd");
        $dumpvars(0, tb_button);

        // Test all cases
        // No buttons pressed
        button0 = 1; button1 = 1; button2 = 1; #5;

        // Only one button pressed
        button0 = 0; button1 = 1; button2 = 1; #5;
        button0 = 1; button1 = 0; button2 = 1; #5;
        button0 = 1; button1 = 1; button2 = 0; #5;

        // Two buttons pressed
        button0 = 0; button1 = 1; button2 = 0; #5; // LED0 should be on
        button0 = 1; button1 = 0; button2 = 0; #5; // LED1 should be on

        // All buttons pressed
        button0 = 0; button1 = 0; button2 = 0; #5; // LED2 should be on

        $finish;
    end

endmodule