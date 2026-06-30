module tb_fifo2;
    reg clk;
    reg rst;
    reg [1:0]data_in;
    reg wi_en;
    reg rd_en;
    wire [1:0]data_out;
    fifo uut(
        .rst(rst), .clk(clk), .data_out(data_out), .data_in(data_in), .wi_en(wi_en), .rd_en(rd_en)
    );
    always #5 clk=~clk;
    task read_byte;
        begin
            @(negedge clk); // neg-edge of clk
            rd_en=1;
            @(posedge clk);
            @(negedge clk);
            rd_en=0;
        end
    endtask


    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_fifo2);
        clk     = 0;
        rst     = 1;
        wi_en   = 0;
        rd_en   = 0;
        data_in = 2'd0;
        #10;
        rst=0;#5;
        data_in=2'b01;wi_en=1;
        #6;
        data_in=2'b11;wi_en=1;
        #6;
        read_byte;
        $finish;
    end
endmodule


