module half_adder(
    input wire a,
    input wire b,
    output wire carry,
    output wire sum
);
    assign sum=a^b;
    assign carry =a&b;
endmodule