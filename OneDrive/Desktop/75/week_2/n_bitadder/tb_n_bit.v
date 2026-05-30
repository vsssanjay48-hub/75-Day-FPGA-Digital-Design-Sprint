
module tb_nbit;
    parameter n=8;

    reg [n-1:0] A;
    reg [n-1:0] B;
    reg cin; 
    wire [n-1:0] sum;
    wire cout;
    ripple_carry_nbit uut (
        .A(A), 
        .B(B), 
        .cin(cin), 
        .sum(sum), 
        .cout(cout)
    );
    integer i;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_nbit);
        for(i = 0; i < 10; i = i + 1) begin
            A = $random;
            B= $random;
            cin= $random % 2;
            #10;
            end
        $finish;
    end
endmodule