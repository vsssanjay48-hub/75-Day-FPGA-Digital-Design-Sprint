module tb_multi;
    reg clk;
    reg rst;
    wire [6:0]out;
    wire [3:0]inta;
    counter_nbit uut1(
        .clk(clk), .rst(rst), .q(inta)
    );
    hex_7_display uut2(
        .a(inta), .out(out)
    );
    always #5 clk=~clk;
   
   initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_multi);
        
        // Step 1: Initialize values and apply a startup delay
        clk = 0; rst = 0;#200;
        
        // Step 2: Pulse the Reset high to synchronize the counter
        rst = 1;
        #20;
        rst = 0;
        
        // Step 3: Just wait! Let the system cycle from 0 to 9 on its own
        #300;
        
        $finish;
    end
endmodule