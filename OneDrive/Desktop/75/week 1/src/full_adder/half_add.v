module half_add(
    input wire a,
    input wire b,
    input wire carryin,
    output wire carryint,
    output wire sum
);
    assign sum=a^b || carryin;
    assign carryint =a&b;
endmodule