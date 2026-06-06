`timescale 1ns/1ps

module tb_pipelinebug;


    reg clk;
    reg rst;
    reg d;
    wire q1;
    wire q2;
    pipelinebug uut(
        .clk(clk),
        .rst(rst), 
        .d(d),
        .q1(q1),
        .q2(q2)
    );
    always #5 clk = ~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_pipelinebug);
        

        clk = 0; rst = 0; d = 0;
        #2 rst = 1;
        #10 rst = 0;
        #6 d = 1;
        #30; 
        d = 0;  
        #30;
        $finish; 
    end

endmodule