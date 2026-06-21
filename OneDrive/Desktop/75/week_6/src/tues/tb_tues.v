module tb_tues;
    reg clk;
    reg [7:0]data_in;
    reg wi;
    wire [7:0]data_out1;
    wire [7:0]data_out2;
    reg [1:0]addr;
    reg [1:0]addr1;
    reg [1:0]addr2;
    tues uut(
        .data_in(data_in), .data_out1(data_out1), .data_out2(data_out2), .wi(wi), .clk(clk), .addr(addr), .addr1(addr1), .addr2(addr2)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_tues);
        clk=0;
        data_in=7'd0;
        addr=2'd0;
        wi=1'b0;
        #10;
        wi=1'b1;addr=2'd0;data_in=8'hAA;#10;
        wi=1;addr=2'd1;data_in=8'hBB;#10;
        wi=1;addr=2'd2;data_in=8'hCC;addr1=2'd2;addr2=2'd2;#10;
        wi=0;addr1=2'd0;addr2=2'd1;#10;
    
        $finish;
    end
endmodule
/*Tuesday's task establishes the fundamental architecture of a 4-entry $\times$ 8-bit multi-port register file, 
highlighting that a true multi-port design relies on a single unified memory array shared across parallel,
 independent read address ports (r_addr1, r_addr2) rather than duplicating independent memory banks or restricting the system to a single shared address line. 
 Architecturally, utilizing combinational asynchronous reading paths naturally enforces a transparent write-through policy, 
 ensuring that during a read-during-write collision at the same register address,
  the output ports instantly propagate the new data stream within the exact same clock cycle. Syntactically,
this implementation resolves a critical Verilog trap by demonstrating that continuous assign statements must exclusively utilize the standard
 assignment operator (=), because nesting a non-blocking arrow (<=) outside of a procedural block mistakenly evaluates as a relational
"less-than-or-equal-to" comparison, 
 yielding an erroneous 1-bit boolean flag instead of the intended 8-bit data byte. 


