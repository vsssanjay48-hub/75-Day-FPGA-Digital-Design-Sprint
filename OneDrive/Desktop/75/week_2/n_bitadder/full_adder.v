module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    // Internal wires to connect the chips together
    wire sum1;
    wire carry1;
    wire carry2;

    // Instantiate First Half Adder
    half_adder HA1 (
        .a(a), 
        .b(b), 
        .sum(sum1), 
        .carry(carry1)
    );

    // Instantiate Second Half Adder
    half_adder HA2 (
        .a(sum1), 
        .b(cin), 
        .sum(sum), 
        .carry(carry2)
    );

    // Instantiate OR Gate for the final carry
    or_gate OR1 (
        .a(carry1), 
        .b(carry2), 
        .y(cout)
    );

endmodule