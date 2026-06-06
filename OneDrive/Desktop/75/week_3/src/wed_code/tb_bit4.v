module tb_bit4;
    reg [3:0]parallel_in;
    reg clk;
    reg load;
    reg rst;
    wire [3:0]q;
    bit4 uut(
        .clk(clk), .rst(rst), .load(load), .parallel_in(parallel_in), .q(q)
    );
    always #5 clk=~ clk;
    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_bit4);
        rst=0;clk=0;parallel_in=4'b0000;
        #2;
        rst=1;
        #4;
        rst=0;
        #6;
        load=1;
        parallel_in=4'b0101;
        #10;
        load=0;
        parallel_in=4'b0010;
        #30;
        $finish;
    end 
endmodule


