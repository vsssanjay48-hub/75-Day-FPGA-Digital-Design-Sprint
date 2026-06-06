module tb_bit_flipflop;
    reg clk;
    reg rst;
    wire serial_out;
    reg serial_in;
    
    bit_flipflop uut(
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .serial_out(serial_out)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_bit_flipflop);
        clk=0;rst=0;serial_in=0;
        #2;
        rst=1;
        #2;
        rst=0;
        #6;
        serial_in = 1; #10; // Cycle 1 (Target bit: 1)
        serial_in = 0; #10; // Cycle 2 (Target bit: 0)
        serial_in = 1; #10; // Cycle 3 (Target bit: 1)
        serial_in = 1; #10; // Cycle 4 (Target bit: 1)
        serial_in = 0; #10; // Cycle 5 (Target bit: 0)
        serial_in = 1; #10; // Cycle 6 (Target bit: 1)
        serial_in = 0; #10; // Cycle 7 (Target bit: 0)
        serial_in = 0; #10; // Cycle 8 (Target bit: 0)

        // Stop feeding data, just feed 0s and let the clock run
        serial_in = 0;
        #50;

        $finish;
    end
endmodule




