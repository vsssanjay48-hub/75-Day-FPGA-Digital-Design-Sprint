module tb_pipo;
reg clk;
reg rst;
wire [7:0]q;
reg [7:0]parallel_in;
reg [7:0]enable;
pipo uut(
    .enable(enable),
    .clk(clk), 
    .rst(rst),
    .q(q), 
    .parallel_in(parallel_in)
);
always #5 clk=~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_pipo);
    rst=0;clk=0;enable=8'b00000000;parallel_in=8'b00000000;
    #2;
    rst=1;
    #4
    rst=0;
    // here im trying the nibble concept 
    parallel_in=8'b11010010;enable=8'b00001111;#10;
    parallel_in=8'b10001010;enable=8'b11110000;#10;
    $finish;
end
endmodule

