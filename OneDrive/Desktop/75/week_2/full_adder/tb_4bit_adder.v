
module tb_4bit_adder;

    reg [3:0] A;
    reg [3:0] B;
    reg cin;
    
    wire [3:0] sum;
    wire cout;

    // Instantiate the 4-bit adder system
    ripple_carry_4bit uut (
        .A(A), 
        .B(B), 
        .cin(cin), 
        .sum(sum), 
        .cout(cout)
    );

    integer i, j;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_4bit_adder);

        cin = 0; // Lock cin to 0 for this test

        // Your exact nested loop logic - this is perfect!
        for(i = 0; i < 16; i = i + 1) begin
            A = i;
            for(j = 0; j < 16; j = j + 1) begin
                B = j; 
                #10;
            end
        end

        $finish;
    end

endmodule