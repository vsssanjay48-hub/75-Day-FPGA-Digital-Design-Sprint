`timescale 1ns/1ps
module xnor_gate(
    input a,
    input b,
    output y   
);

    wire not_a, not_b;
    wire and1_gate, and2_gate;

    not_gate not1 (.a(a), .y(not_a));
    not_gate not2 (.a(b), .y(not_b));
    
    and_gate and1 (.a(not_a), .b(b_not), .y(and1_gate));
    and_gate and2 (.a(a), .b(b), .y(and2_gate)); 

    or_gate or1 (.a(and1_gate), .b(and2_gate), .y(y));
    
endmodule