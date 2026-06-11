module tb_gray_code;
    reg clk;
    wire [3:0]bin;
    reg rst;
    wire [3:0]gray;

    gray_code1 uut(
        .clk(clk), .rst(rst), .bin(bin), .gray(gray)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_gray_code);
        rst=0;clk=0;#2;
        rst=1;#5;
        rst=0;#150;
        $finish;
    end
endmodule

