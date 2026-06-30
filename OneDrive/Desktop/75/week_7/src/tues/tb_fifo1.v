module tb_fifo1;
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
    task write_byte;
        input [1:0]test_data;
        begin
            @(negedge clk); // neg-edge of clk
            data_in=test_data;
            wi_en=1;
            @(posedge clk);
            @(negedge clk);
            wi_en=0;
        end
    endtask


    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_fifo1);
        clk     = 0;
        rst     = 1;
        wi_en   = 0;
        rd_en   = 0;
        data_in = 2'd0;
        #10;
        rst=0;#5;
        write_byte(2'b01);
        #6;
        write_byte(2'b11);
        #6;

        
        $finish;
    end
endmodule


