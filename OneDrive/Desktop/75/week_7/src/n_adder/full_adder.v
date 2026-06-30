module full_adder#(
    parameter bit=4;
)(
    input wire carryin,
    output reg carryout,
    input wire [bit-1:0]a,
    input wire [bit-1:0]b,
    output reg [bit-1:0]sum
);
assign sum= a^b^carryin;
assign carryout = (a&b) |(b&carryin)|(a&carryin);
endmodule 