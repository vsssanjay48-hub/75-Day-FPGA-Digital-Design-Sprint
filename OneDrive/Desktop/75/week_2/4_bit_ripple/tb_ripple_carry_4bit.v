module tb_ripple_carry_4bit;
    reg [3:0]a;
    reg [3:0]b;
    wire [3:0]sum;
    wire cout;
    ripple_carry_adder_4bit uut(
        .a(a), .b(b), .sum(sum), .cout(cout)

    );
    integer i,j;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_ripple_carry_4bit);
        for(i=0;i<16;i=i+1) begin
            a=i;
             for(j=0;j<16;j=j+1) begin
                b=j; #10;
             end
        end
        $finish;
    end
endmodule


        