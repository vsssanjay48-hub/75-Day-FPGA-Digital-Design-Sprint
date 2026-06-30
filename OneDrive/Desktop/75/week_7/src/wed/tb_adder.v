module tb_adder;
    reg [3:0]a;
    reg [3:0]b;
    wire [4:0]sum;
    adder uut(
        .sum(sum), .a(a), .b(b)
    );
    integer i ,j;
    integer expected;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_adder);
        for(j=0;j<16;j=j+1)begin
            for(i=0;i<16;i=i+1)begin
                a=i;
                b=j; 
                expected = a + b; 
                #1;
                if (sum === expected) begin
                    $display("PASS: a=%d b=%d expected=%d got=%d", a, b, expected, sum);
                end else begin
                    $display("FAIL: a=%d b=%d expected=%d got=%d", a, b, expected, sum);
                end
                #5;
            end
        end
    end
endmodule

