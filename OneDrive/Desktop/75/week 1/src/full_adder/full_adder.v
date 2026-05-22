
module full_adder(
    input wire carryint,
    input wire sum,
    output wire sumout,
    output wire carryout

);
    assign sumout= sum;
    assign carryout=carryint;
endmodule
    