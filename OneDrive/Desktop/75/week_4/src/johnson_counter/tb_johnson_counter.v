module tb_johnson_counter;
    reg clk;
    reg rst;
    wire[3:0]q;
    johnson_counter uut(
        .clk(clk), .rst(rst), .q(q)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_johnson_counter);
        rst=0;clk=0;#3;
        rst=1;#3;
        rst=0;#10;
        $finish;
    end
endmodule