`timescale 1ns/1ps
module tb_nor_gate;
    reg a,b;
    wire y,z;
    or_gate uut(
        .a(a),
        .b(b),
        .y(y)

    );
    not_gate dut(
        .y(y),
        .z(z)
    );
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_nor_gate);
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;

    $finish;
end
endmodule










