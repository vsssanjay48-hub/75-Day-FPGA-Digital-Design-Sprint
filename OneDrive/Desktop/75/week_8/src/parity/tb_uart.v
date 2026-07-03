`timescale 1ns/1ps
module tb_uart;
    reg tx_start;
    reg [7:0]tx_data;
    wire tx_done;
    wire tx_active ;
    wire tx_out ;
    reg rst;
    reg clk;
    uart uut(
        .clk(clk), .rst(rst), .tx_done(tx_done), .tx_out(tx_out), .tx_active(tx_active), .tx_start(tx_start), .tx_data(tx_data)
    );
    always #10 clk=~clk;   //so thime period will be 20ns ,so freq will be 50Mhz
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_uart);
        rst=0;clk=0;#20;
        rst=1;#20;
        rst=0;#20;
        tx_data=01010101;tx_start=1;#1000;
        $finish;
    end
endmodule
