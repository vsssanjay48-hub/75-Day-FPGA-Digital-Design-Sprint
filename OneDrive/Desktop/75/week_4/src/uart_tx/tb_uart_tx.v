module tb_uart_tx;
    reg rst;
    reg clk;
    reg tx_start;
    reg [7:0]tx_data;
    wire tx_active;
    wire tx_done;
    wire tx_out;
    uart_tx uut(

        .rst(rst), .clk(clk), .tx_start(tx_start), .tx_data(tx_data), .tx_done(tx_done), .tx_active(tx_active), .tx_out(tx_out)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_uart_tx);
        
        // 1. Initialize everything to a safe starting state
        clk = 0; 
        rst = 0; 
        tx_start = 0;
        tx_data = 8'h41; // Load the letter 'A' (8'b01000001) into the engine
        #2;
        
        // 2. Fire the Reset cycle
        rst = 1;
        #10;
        rst = 0;
        #10; // Wait a cycle for the chip to settle
        
        // 3. Press the "Start Transmission" button for exactly 1 clock cycle (10ns)
        tx_start = 1;
        #10;
        tx_start = 0;
        
        // 4. Let the simulation run long enough to watch all 10 bits transmit
        // 5208 ticks per bit * 10 bits * 10ns per tick = roughly 520,000ns!
        #600000; 
        
        $finish;
    end
endmodule
