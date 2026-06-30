module tb_fifo;
    reg clk;
    reg rst;
    reg [7:0]data_in;
    reg wi_en;
    reg rd_en;
    wire [7:0]data_out;
    fifo uut(
        .rst(rst), .clk(clk), .data_out(data_out), .data_in(data_in), .wi_en(wi_en), .rd_en(rd_en)
    );
    always #5 clk=~clk;
    integer i;
    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_fifo);
        clk     = 0;
        rst     = 1;
        wi_en   = 0;
        rd_en   = 0;
        data_in = 2'd0;
        #10;
        rst=0;#5;
        for(i=0;i<1000;i=i+1)begin
            data_in=$random;
            wi_en=$random%2;
            rd_en=$random%2;
            #2;
        end
        $finish;
    end
endmodule


