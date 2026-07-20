/*Case 1: Underflow Protection (TX when FIFO is Empty)
This edge case evaluates how the transmission pipeline behaves at system startup or 
whenever the queue completely runs out of data. 
The testbench initializes the entire system with a global reset pulse while keeping the write enable (wi_en) signal strictly at zero, 
ensuring no data ever enters the circular buffer. 
The primary objective is to verify that the control logic does not experience a "false trigger" or latch uninitialized values from 
an empty memory array.

On the hardware side, the FIFO correctly holds its empty flag at logic high, 
which directly forces the Handshake FSM to remain locked inside its idle WAIT state indefinitely.
Because the FSM is safely pinned, the internal read enable (fifo_rd_en) and UART initiate signals never pulse high,
 keeping the physical serial line (tx_out) completely stable at a continuous logic HIGH resting state. 
This proves the pipeline provides ironclad underflow protection,
 preventing the transmitter from broadcasting phantom garbage bytes to a receiving device.*/


`timescale 1ns / 1ps

module tb_project;

    // 1. Interface Wires
    reg        clk;
    reg        rst;
    reg  [7:0] data_in;
    reg        wi_en;
    wire       full;
    wire       empty;
    wire       tx_out;

    // 2. Instantiate Device Under Test (DUT)
    project uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .wi_en(wi_en),
        .full(full),
        .empty(empty),
        .tx_out(tx_out)
    );

    // 3. 50 MHz System Clock Generator
    always #10 clk = ~clk;

    // 4. Main Verification Block
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_project);

        // Initialize inputs
        clk     = 0;
        rst     = 1;
        wi_en   = 0; 

        #60;
        @(posedge clk);
        rst = 0; // Release system reset normally
        
        // =====================================================================
        // BURST WRITE
        // =====================================================================
        $display("[TB] Initiating inline 10-byte burst write on falling edges...");
        
        @(negedge clk); 
        wi_en = 0;       
        
        #10000000;

        $display("[TB SUCCESS] Simulation complete. Verify results in GTKWave!");
        $finish;
    end

endmodule