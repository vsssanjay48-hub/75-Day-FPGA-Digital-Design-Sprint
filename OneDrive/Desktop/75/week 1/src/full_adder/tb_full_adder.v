module tb_full_adder;
    reg a;
    reg b;
    reg carryin;
    wire sum;
    wire carryint;
    wire carryout;
    wire sumout;
    half_add uut1(
        .a(a), .b(b), .carryin(carryin), .sum(sum), .carryint(carryint)
    );
    full_adder uut2(
        .sum(sum), .carryint(carryint), .carryout(carryout), .sumout(sumout)
    );
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_full_adder);
        a=0;b=0;carryin=0; #10
        a=0;b=0;carryin=1; #10
        a=0;b=1;carryin=0; #10
        a=0;b=1;carryin=1; #10
        a=1;b=0;carryin=0; #10
        a=1;b=0;carryin=1; #10
        a=1;b=1;carryin=0; #10
        a=1;b=1;carryin=1; #10
        $finish;
    end
endmodule

    


