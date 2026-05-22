`timescale 1ns/1ps
module tb_xnor_gate;
    reg a,b;
    wire y;
    xnor_gate uut(
        .b(b),
        .a(a),
        .y(y)
    );
    
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_xnor_gate);
    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;

    $finish;
end
endmodule

