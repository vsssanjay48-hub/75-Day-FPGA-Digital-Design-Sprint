`timescale 1ns/1ps
`include "uart.v"
`include "uart_rx.v"
module tb_rx_tx;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0]tx_data;
    wire tx_active;
    wire tx_out;
    wire tx_done;
    wire [7:0]rx_data;
    wire rx_done;
    wire rx_active;
    uart uut(
        .clk(clk), .rst(rst), .tx_done(tx_done), .tx_out(tx_out), .tx_active(tx_active), .tx_start(tx_start), .tx_data(tx_data)
    );
    uart_rx uut1(
        .clk(clk), .rst(rst), .rx(tx_out), .rx_active(rx_active), .rx_data(rx_data), .rx_done(rx_done)
    );

    always #10 clk=~clk;   //so thime period will be 20ns ,so freq will be 50Mhz
    integer i;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_rx_tx);
        rst=0;clk=0;#20;
        rst=1;#20;
        rst=0;#20;
        
        // 4. Automated Random Loopback Engine
        for(i = 0; i < 20; i = i + 1) begin
            tx_data  = $random;  // Generate a random 8-bit value
            tx_start = 1;        // Pulse tx_start HIGH
            #20;                 // Hold it for exactly 1 clock cycle
            tx_start = 0;        // Release tx_start LOW so it doesn't re-trigger
            
            // The Handshake: Wait right here for ~1.04 milliseconds 
            // until this specific byte is completely transmitted!
            @(posedge tx_done);
            
            #150700; 
            if(tx_data==rx_data)begin
                $display("done");
            end
                      // Small gap delay (40 us) between bytes for visual clarity in GTKWave
        end

        // 5. Wrap up simulation
        #200000;                 // Extra padding to let the RX finish its last stop bit
        $finish;
    end
endmodule
    

