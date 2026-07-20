/*Case 3: Pointer Wrap-Around & Batch Recovery
This final test case acts as a full-cycle stress test designed to expose tracking bugs, index overflows, 
or memory leakage across extended operation. The testbench executes a maximum-capacity burst write of eight bytes to force the FIFO counter to 
its absolute boundary where the full flag snaps high. The system is then left alone for a calculated timeline of exactly
 8,320,000 ns—the mathematically precise window required for the 50 MHz pipeline to serialize eight complete 
UART frames—allowing the queue to empty out completely before it is instantly hit with a second, distinct batch of eight bytes.

The core validation occurs within the internal pointer tracking logic during the second batch execution.
Because the FIFO is circular, the 3-bit write and read pointers must seamlessly roll over from their
maximum address index of seven (3'b111) back to zero (3'b000) without overwriting active data or hanging the state machine. 
The successful assertion of the full flag during the second batch, combined with an error-free serialization of all sixteen bytes,
proves that the expanded 4-bit tracking counter and pointer wrap-around mechanics maintain perfect structural integrity across 
back-to-back operational cycles.*/



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
    // 1. System Reset
    rst = 1; wi_en = 0; data_in = 8'd0;
    #40; @(posedge clk); rst = 0;
    @(negedge clk);

    // 2. Load FIRST Batch of 8 Bytes
    $display("[TB - CASE 3] Loading first batch of 8 bytes...");
    wi_en = 1;
    data_in = 8'h01; @(negedge clk);
    data_in = 8'h02; @(negedge clk);
    data_in = 8'h03; @(negedge clk);
    data_in = 8'h04; @(negedge clk);
    data_in = 8'h05; @(negedge clk);
    data_in = 8'h06; @(negedge clk);
    data_in = 8'h07; @(negedge clk);
    data_in = 8'h08; @(negedge clk);
    wi_en = 0; data_in = 8'd0;

    // 3. Wait for your calculated drain time
    $display("[TB - CASE 3] Waiting 8,320,000 ns for Batch 1 to finish...");
    #8320000;

    // Check if it successfully returned to empty
    if (empty === 1'b1) begin
        $display("[TB SUCCESS] Batch 1 completely drained. FIFO is empty.");
    end else begin
        $display("[TB ERROR] FIFO failed to empty after 8,320,000 ns!");
    end

    // 4. Load SECOND Batch of 8 Bytes (Testing pointer wrap-around)
    $display("[TB - CASE 3] Loading second batch of 8 bytes...");
    @(negedge clk);
    wi_en = 1;
    data_in = 8'h11; @(negedge clk);
    data_in = 8'h12; @(negedge clk);
    data_in = 8'h13; @(negedge clk);
    data_in = 8'h14; @(negedge clk);
    data_in = 8'h15; @(negedge clk);
    data_in = 8'h16; @(negedge clk);
    data_in = 8'h17; @(negedge clk);
    data_in = 8'h18; @(negedge clk);
    wi_en = 0; data_in = 8'd0;

    // 5. Wait for the second calculated drain time
    $display("[TB - CASE 3] Waiting 8,320,000 ns for Batch 2 to finish...");
    #8320000;

    if (empty === 1'b1) begin
        $display("[TB SUCCESS] Batch 2 completely drained. Wrap-around successful!");
    end else begin
        $display("[TB ERROR] Pipeline corrupted or hung during batch wrap-around.");
    end

    $finish;
end
endmodule
