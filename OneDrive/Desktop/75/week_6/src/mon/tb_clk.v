module tb_clk;
    reg clk;
    reg [7:0]data_in;
    reg wi_en;
    wire [7:0]data_out;
    reg [3:0]addr;
    clk uut(
        .data_in(data_in), .data_out(data_out), .wi_en(wi_en), .clk(clk), .addr(addr)
    );
    always #5 clk=~clk;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_clk);
        clk=0;
        data_in=7'd0;
        addr=4'd0;
        wi_en=1'b0;
        #10;
        wi_en=1'b1;addr=4'd4;data_in=8'hAA;#10;
        addr=4'd3;data_in=8'hBB;#10;
        addr=4'd2;data_in=8'hCC;#10;
        wi_en=1'b0;addr=4'd2;#10;
        addr=4'd3;#10;
        addr=4'd4;#10;
        $finish;
    end
endmodule





