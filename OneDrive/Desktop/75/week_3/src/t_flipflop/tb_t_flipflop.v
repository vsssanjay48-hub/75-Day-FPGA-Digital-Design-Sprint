

module tb_tflipflop;

    reg clk;
    reg rst;
    reg t;     
    wire q;

    // Instantiate your new T flip-flop
    t_flipflop uut(
        .clk(clk),
        .rst(rst),
        .t(t), 
        .q(q)
    );

    // CLOCK GENERATOR: Ticks every 5ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_tflipflop);

        // 1. Initialize everything to zero
        clk = 0; rst = 0; t = 0; 
        
        // 2. Pulse the reset button to clear the red 'X'
        #2 rst = 1; 
        #2 rst = 0; 
        
        // 3. Test Case 1: T = 0 (Memory Hold Mode)
        // Let the clock tick a few times. Q should stay perfectly flat at 0.
        #10; 
        
        // 4. Test Case 2: T = 1 (Toggle Mode)
        // Turn the toggle switch ON, and leave it on for 40 nanoseconds.
        t = 1; 
        #40;
        
        // 5. Test Case 3: Back to T = 0
        // Turn the toggle switch OFF. Q should freeze at whatever its last value was.
        t = 0;
        #20;

        $finish;
    end

endmodule