module tb_n_adder;
    parameter bit=4;
    reg carryin;
    reg [bit-1:0]a;
    reg [bit-1:0]b;
    wire carryout;
    wire sum;
    n_adder #(
        .bit(bit)
    ) uut(
        .carryin(carryin), .carryout(carryout), .a(a), .b(b), .sum(sum)
    );
    integer i;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_n_adder);
        for(i=0;i<10;i=i+1)begin
            a=$random;
            b=$random;
            carryin=$random%2;
            #10;
        end
        $finish;
    end 
endmodule
