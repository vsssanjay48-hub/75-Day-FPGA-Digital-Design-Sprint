`timescale 1ns/1ps

module tb_not_gate;
    reg a;
    wire b;

    not_gate uut (
        .a(a),
        .b(b)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_not_gate);

        a=0; #10;
        a=1; #10;

        $finish;
    end
endmodule




