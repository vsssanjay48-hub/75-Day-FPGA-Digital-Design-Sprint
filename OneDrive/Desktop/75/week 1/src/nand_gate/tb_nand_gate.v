`timescale 1ns/1ps

module tb_nand_gate;
    reg a, b;
    wire y;

    nand_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_nand_gate);

        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;

        $finish;
    end
endmodule