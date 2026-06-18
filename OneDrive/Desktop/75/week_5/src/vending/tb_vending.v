module tb_vending;
    reg clk;
    reg rst;
    reg coin_5p;
    reg coin_10p;
    reg coin_25p;
    wire dispenceo;
    vending uut(
        .clk(clk), .rst(rst), .coin_5p(coin_5p), .coin_10p(coin_10p), .coin_25p(coin_25p), .dispenceo(dispenceo)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_vending);
        rst=0;clk=0;#3;
        rst=1;#3;
        rst=0;coin_5p=1;coin_10p=1;coin_25p=1;#200;
        $finish;
    end
endmodule 