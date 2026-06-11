module tb_counter_nbit;
    reg rst;
    reg clk;
    wire [12:0]q;
    counter_nbit uut(
    .clk(clk), 
    .rst(rst),
    .q(q)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_counter_nbit);
        rst=0;clk=0;#200
        rst=1;
        #60;
        rst=0;#1200
        $finish;
    end
endmodule





