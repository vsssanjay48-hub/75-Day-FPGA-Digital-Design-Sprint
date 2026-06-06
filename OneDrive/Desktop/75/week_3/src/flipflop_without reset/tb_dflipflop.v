
module tb_dflipflop;
    reg clk;
    reg d;
    wire q;
    d_flipflop uut(
        .clk(clk),
        .d(d), 
        .q(q)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_dflipflop); 
        clk=0;
        d = 0; 
        #10;
        d = 1; 
        #10;
        
        $finish; // Stop the simulation (otherwise the clock generator runs forever!)
    end

endmodule
