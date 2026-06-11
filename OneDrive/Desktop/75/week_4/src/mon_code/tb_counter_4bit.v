module tb_counter_4bit;
    reg rst;
    reg clk;
    reg enable;
    reg updown;
    wire [3:0]q;
    counter_4bit uut(
    .enable(enable),
    .clk(clk), 
    .rst(rst),
    .q(q), 
    .updown(updown)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_counter_4bit);
        rst=0;clk=0;updown=0;enable=0;#200
        rst=1;
        #60;
        rst=0;enable=1;updown=1;#120;
        enable=1;updown=0;#200;
        enable=0;updown=1;#200;
        enable=1;updown=1;#400;
        $finish;
    end
endmodule





