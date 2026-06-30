module n_adder #(
    parameter bit =4
)(
    input wire carryin,
    output reg carryout,
    input wire [bit-1:0]a,
    input wire [bit-1:0]b,
    output reg [bit-1:0]sum
);
genvar i;
wire [bit:0]c;
assign c[0]=carryin;
assign c[bit] =carryout;
generate 
    for(i=0;i<bit;i=i+1)begin:adder_loop
        full_adder ai(
            .carryin(c[i]),
            .carryout(c[i+1]),
            .a(a[i]),
            .b(b[i]),
            .sum(sum[i])

        );
    end
endgenerate
endmodule