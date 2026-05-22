module tb_half_adder;
    reg a;
    reg b;
    wire y;
    wire carry ;

    and_gate uut1(
        .a(a), .b(b), .carry(carry)

    );
    xor_gate uut2(
        .a(a), .b(b), .y(y)
    );
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_half_adder);
        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;
    end
endmodule


