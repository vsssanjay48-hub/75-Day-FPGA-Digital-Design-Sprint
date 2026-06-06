

module tb_jk_flipflop;

    reg clk;
    reg rst;
    reg j;
    reg k;
    wire q;

    // Instantiate the JK Flip-Flop
    jk_flipflop uut(
        .clk(clk),
        .rst(rst),
        .j(j),
        .k(k),
        .q(q)
    );

    // Clock generator: Ticks every 5ns (10ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_jk_flipflop);

        // 1. Initialize everything to zero
        clk = 0; rst = 0; j = 0; k = 0; 

        // 2. Pulse the Asynchronous Reset to clear the red 'X'
        #2 rst = 1; 
        #2 rst = 0; 
        
        // Wait for the first clock edge to pass
        #10; 

        // ==========================================
        // THE 4 TRUTH TABLE TEST CASES
        // ==========================================

        // Test Case 1: RESET (J=0, K=1) -> Q becomes 0
        j = 0; k = 1; 
        #10;

        // Test Case 2: SET (J=1, K=0) -> Q becomes 1
        j = 1; k = 0; 
        #10;  

        // Test Case 3: HOLD (J=0, K=0) -> Q stays 1
        j = 0; k = 0; 
        #10;  

        // Test Case 4: TOGGLE (J=1, K=1) -> Q alternates 0 and 1
        j = 1; k = 1; 
        #40;  // Let the clock run for a while to prove it toggles!

        // ==========================================
        
        $finish; // End simulation safely here
    end

endmodule