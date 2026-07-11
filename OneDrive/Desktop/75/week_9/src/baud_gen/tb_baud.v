module tb_baud;
    reg clk;
    reg rst;
    wire baud_tick;
    rx_baud_gen uut(
        .clk(clk), .rst(rst), .baud_tick(baud_tick)
    );
    always #10 clk=~clk;
    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_baud);
        rst=0;clk=0;#10;
        rst=1;
        #10;
        rst=0;
        #1000;
        $finish;
    end
endmodule

