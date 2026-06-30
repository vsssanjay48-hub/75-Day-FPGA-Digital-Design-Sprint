module fifo(
    //depth here is 4 (the slotsss)
    //width here is 2 bit ,ean sthe size of data
    input wire [1:0]data_in,
    output wire [1:0]data_out,
    input wire clk,
    input wire rst,
    input wire wi_en,
    input wire rd_en
);
reg [1:0]mem[0:3];
wire empty;
wire full;
reg [1:0]rd_ptr;
reg [1:0]wr_ptr;
reg[2:0]count;
wire do_write =wi_en&&(!full||rd_en);
wire do_read=rd_en&&(!empty||wi_en);
assign empty=(count==3'd0);
assign full=(count==3'd4);
always @(posedge clk)begin
    if(rst)begin
        rd_ptr=2'd0;
        wr_ptr=2'd0;
        count=3'd0;
    end
    else begin
        if (do_write) begin
        wr_ptr<=wr_ptr+1;
        mem[wr_ptr]<=data_in;
        end
        if (do_read) begin
        rd_ptr<=rd_ptr+1;
        end
        case({do_write, do_read})
        2'd1:count<=count+3'd1;
        2'd2:count<=count-3'd1;
        default:count<=count;
        endcase
    end
end
assign data_out = (empty && wi_en) ? data_in : mem[rd_ptr];
endmodule



        


