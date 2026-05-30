module ripple_carry_nbit(
    input wire [n-1:0] A,
    input wire [n-1:0] B,
    input wire cin,
    output wire [n-1:0] sum,
    output wire cout
);
    parameter n=8;
    wire [n:0]carry;
    assign carry[0]=cin;
    genvar i;
    generate 

        for(i = 0; i < n; i = i + 1) begin :adder_loop
            full_adder FAN (.a(A[i]), .b(B[i]), .cin(carry[i]), .sum(sum[i]), .cout(carry[i+1]));
        end
        assign cout=carry[n];
    endgenerate
endmodule