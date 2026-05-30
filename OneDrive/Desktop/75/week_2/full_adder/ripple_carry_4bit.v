module ripple_carry_4bit(
    input wire [3:0] A,
    input wire [3:0] B,
    input wire cin,
    output wire [3:0] sum,
    output wire cout
);

    wire carry1, carry2, carry3;
    full_adder FA0 (.a(A[0]), .b(B[0]), .cin(cin),    .sum(sum[0]), .cout(carry1));
    full_adder FA1 (.a(A[1]), .b(B[1]), .cin(carry1), .sum(sum[1]), .cout(carry2));
    full_adder FA2 (.a(A[2]), .b(B[2]), .cin(carry2), .sum(sum[2]), .cout(carry3));
    full_adder FA3 (.a(A[3]), .b(B[3]), .cin(carry3), .sum(sum[3]), .cout(cout));

endmodule