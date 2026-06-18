module tb_s1011;
    reg clk;
    reg rst;
    reg data;
    wire out;
    s1011 uut(
        .clk(clk), .rst(rst), .data(data), .out(out)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_s1011);
        rst=0;clk=0;#10;
        rst=1;
        #10;
        rst=0;data=1;#10;
        data=0;#10;
        data=1;#10;
        data=1;#10;
        data=0;#10;
        $finish;
    end
endmodule

