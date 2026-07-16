`timescale 1ns / 1ps

module tb_project;

    reg        clk;
    reg        rst;
    reg  [7:0]data_in;
    reg        wi_en;
    wire       full;
    wire       empty;
    wire       tx_out;

    // Instantiate Device Under Test
    project uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .wi_en(wi_en),
        .full(full),
        .empty(empty),
        .tx_out(tx_out)
    );

    // 50 MHz System Clock (20 ns period)
    always #10 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_project);

        // Initialize
        clk     = 0;
        rst     = 1;
        wi_en   = 0;
        data_in = 8'd0;
        
        // --- THE DEVELOPER TRICK ---
        // Hold only the Handshake FSM in reset. This keeps the FSM frozen
        // so it cannot read the FIFO while we execute our overflow test.
        force uut.insttt.rst = 1'b1;

        #60;
        @(posedge clk);
        rst = 0; // Release top-level/FIFO reset
        @(posedge clk);

        // --- Burst Write 10 Bytes ---
        $display("[TB] Initiating 10-byte write burst into 8-deep FIFO...");
        
        // Bytes 1 to 8: Should fill the FIFO perfectly
        write_byte(8'h01);
        write_byte(8'h02);
        write_byte(8'h03);
        write_byte(8'h04);
        write_byte(8'h05);
        write_byte(8'h06);
        write_byte(8'h07);
        write_byte(8'h08); // FIFO count reaches 8. 'full' flag must go HIGH here.

        // Bytes 9 and 10: Attempted writes while FULL (should be silently ignored)
        write_byte(8'h09);
        write_byte(8'h0A);

        wi_en   = 0;
        data_in = 8'd0;
        #40;

        // Verify boundary behavior
        if (full === 1'b1) begin
            $display("[TB SUCCESS] FIFO full flag is successfully asserted!");
        end else begin
            $display("[TB ERROR] FIFO is not reporting FULL after 8 writes.");
        end

        // --- Release the FSM ---
        $display("[TB] Releasing FSM reset. Draining pipeline starting...");
        release uut.insttt.rst;

        // Drain window: 8 frames @ 9600 baud takes roughly 8.4 ms.
        // We will simulate for 10 ms (10,000,000 ns) to see them all finish.
        #10000000;

        $display("[TB SUCCESS] Simulation complete. Verify results in GTKWave!");
        $finish;
    end

    // Helper task to handle synchronous single-cycle writes
    task write_byte;
        input [7:0] val;
        begin
            data_in = val;
            wi_en   = 1;
            @(posedge clk);
            wi_en   = 0;
        end
    endtask

endmodule