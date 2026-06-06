
module tb_dflipflop;
    reg clk;
    reg d;
    reg rst;
    wire q;
    d_flipflop uut(
        .clk(clk),
        .rst(rst),
        .d(d), 
        .q(q)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_dflipflop); 
       clk = 0; d = 0; rst = 0; 
        
        // ==========================================
        // SCENARIO 1: Reset during clock (Kill the X)
        // ==========================================
        // Fire the reset button at 2ns, before the first clock tick at 5ns!
        #2 rst = 1; 
        #2 rst = 0; // Release it at 4ns. 'q' should now safely be 0, not red 'X'.

        // ==========================================
        // SCENARIO 2: Data changes between clock edges
        // ==========================================
        // The clock is ticking. Let's make D go crazy while the clock is low.
        #6  d = 1;  // Time = 10ns
        #2  d = 0;  // Time = 12ns
        #2  d = 1;  // Time = 14ns. (Notice Q ignores all of this until 15ns!)
        
        // Wait for the dust to settle
        #10; 

        // ==========================================
        // SCENARIO 3: Setup Time Violation (The Race Condition)
        // ==========================================
        // The next rising edge is at exactly 35ns.
        // Let's change D at the exact same nanosecond!
        #11 d = 0; // 14ns + 10ns + 11ns = exactly 35ns!

        #20;
        $finish;
    end

endmodule
