module tb_bit2;
    reg clk;
    reg rst;
    reg [1:0]load;
    wire [3:0]q;
    reg [3:0]parallel_in;
    
    bit uut(
        .clk(clk),
        .rst(rst),
        .q(q),
        .load(load),
        .parallel_in(parallel_in)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_bit2);
        clk=0;rst=0;parallel_in=4'b1010; load=2'b01;
        #2;
        rst=1;
        #6;
        rst=0;
        #6;
        parallel_in=4'b1011;load=2'b10; #10;
        parallel_in=4'b1111;load=2'b00; #10;
        parallel_in=4'b0000;load=2'b11; #10;
        parallel_in=4'b1011;load=2'b01; #10;
        #50;

        $finish;
    end
endmodule


