module tb_clock_divider;
    reg clk_in;
    reg rst;
    wire clk_out;
    clock_divider uut(
        .rst(rst), .clk_in(clk_in), .clk_out(clk_out)

    );
    always #5 clk_in=~clk_in;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_clock_divider);
        rst=0;clk_in=0;#3;
        rst=1;
        #3;
        rst=0;
        #300;
        $finish;
    end
endmodule