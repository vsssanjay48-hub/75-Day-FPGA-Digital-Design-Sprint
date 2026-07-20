/*Case 2: Asynchronous Interruption (Write Mid-Transmission)
This scenario tests the pipeline's ability to handle erratic, real-world data bursts by injecting new data while the transmission hardware is 
heavily occupied. The testbench pre-loads four bytes into the FIFO, allows the Handshake FSM to autonomously initiate the draining sequence,
 and then uses a precise simulation time delay (approximately 2.6 ms) to wait until the slow UART engine is exactly halfway through serializing
 the third byte. 
At that exact microsecond, the testbench fires an asynchronous write pulse to drop a fifth byte (0xE5) directly into the active buffer.

The simulation waveform validates that the FIFO's write control path operates completely independent of the slow read path.
 The internal occupancy counter successfully steps up from two back to three mid-frame, 
 while the UART transmitter finishes serializing the active third byte without a single clock cycle of glitching or timing jitter.
  Once the fourth byte concludes its transmission frame, the FSM instantly detects that the queue is still populated,
   immediately fetching and streaming the newly injected fifth byte to confirm seamless speed-matching under heavy interruption.*/



`timescale 1ns/1ps
`include "project.v"
module tb_project;
    reg clk;
    reg rst;
    reg [7:0]data_in;
    reg wi_en;
    wire tx_out;
    wire empty;
    wire full;
    project uut(
        .rst(rst), .clk(clk), .data_in(data_in), .wi_en(wi_en), .tx_out(tx_out), .empty(empty), .full(full)
    );
    always #10 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_project);
        clk     = 0;
        rst     = 1;
        wi_en   = 0;
        data_in = 8'd0;
        
        #60;
        @(posedge clk);
        rst = 0; 
        

        @(posedge clk);

        $display("[TB STATUS] Pre-loading FIFO with 4 consecutive bytes...");
        
        // Cycle 1: Write 0xDE
        data_in = 8'hDE; wi_en = 1;
        @(posedge clk);
        data_in = 8'hAD; 
        @(posedge clk);
        data_in = 8'hBE; 
        @(posedge clk);
        data_in = 8'hEF; 
        @(posedge clk);
        wi_en   = 0;
        data_in = 8'd0;
        //im inserting 5th bytes while transmiting the 3 of 4th one, 104us for one bit *10 for one input 
        // that is 1.04ms , so 2*1.04 + 1.04/2 that is almost 2.6ms
        #2600000;
        @(posedge clk);
        data_in = 8'hDE; wi_en = 1;
        @(posedge clk);
        
        wi_en   = 0;
        data_in = 8'd0;
        #40000000

        
        $display("[TB SUCCESS] All bytes processed. Open your GTKWave interface to check execution layout!");
        $finish;
    end

endmodule


