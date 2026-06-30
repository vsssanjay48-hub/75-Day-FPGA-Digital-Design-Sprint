module tb_traffic;
    wire o_red;
    wire o_yellow;
    wire o_green;
    reg rst;
    reg clk;
    traffic uut(
        .clk(clk), .rst(rst), .o_yellow(o_yellow), .o_red(o_red), .o_green(o_green)
    );
    always #5 clk=~clk; 
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_traffic);
        rst=0;clk=0;#3;
        rst=1;#3;
        rst=0;#1500;
        $finish;
    end
endmodule
