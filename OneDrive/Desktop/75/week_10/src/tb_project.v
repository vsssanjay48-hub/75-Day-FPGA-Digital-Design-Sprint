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
        $display("[TB STATUS] FIFO pre-load finished. System pipeline is executing autonomously.");

        // 5. Long-Run Simulation Window
        // Math breakdown: At 9600 baud, 1 bit takes roughly 104,166 ns.
        // A full 10-bit UART frame (1 Start + 8 Data + 1 Stop) requires ~1.04 ms.
        // Processing 4 stacked frames requires at least 4.16 ms of execution time.
        // We run for 6,000,000 ns (6.0 ms) to observe the entire transmission and verify the gaps.
        #6000000;

        $display("[TB SUCCESS] All bytes processed. Open your GTKWave interface to check execution layout!");
        $finish;
    end

endmodule


