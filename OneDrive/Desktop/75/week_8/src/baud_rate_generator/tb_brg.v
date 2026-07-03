module tb_brg;
parameter clk_freq=50000000;
parameter baud_rate=9600;
parameter DIVISOR=5208;
reg rst;
reg clk;
reg tx_active;
brg  #(
    .clk_freq(clk_freq), .baud_rate(baud_rate), .DIVISOR(DIVISOR)
)uut (
    .rst(rst), .clk(clk), .tx_active(tx_active)
);
always #5 clk=~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_brg);
    rst=0;#5;rst=1;
    #5;
    rst=0;#100;
end
endmodule







