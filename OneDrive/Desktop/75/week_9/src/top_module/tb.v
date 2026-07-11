`timescale 1ns/1ps
`include "uart_top.v"
module tb;
    reg clk;
    reg rst;
    reg send;
    reg rx;
    reg [7:0]tx_data;
    wire [7:0]rx_data;
    wire tx_active; 
    wire rx_active; 
    wire tx_done;
    wire rx_done;
    uart_top uut(
        .clk(clk), .rst(rst), .tx_done(tx_done), .rx(rx), .tx_active(tx_active), .send(send), .tx_data(tx_data), .rx_active(rx_active), .rx_data(rx_data), .rx_done(rx_done)

    );
    always #10 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        rst=0;clk=0;#20;
        rst=1;#20;
        rst=0;#20;
        tx_data=8'd7;send=1;rx=0;#200000;
        rx=1;#100000;
        $finish;
    end
endmodule




     
