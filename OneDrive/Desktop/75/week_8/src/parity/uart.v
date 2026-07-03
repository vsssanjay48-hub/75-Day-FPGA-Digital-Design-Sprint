module uart #(
    //brg-baud rate generator
    parameter clk_freq=50000000,
    parameter baud_rate=9600,
    parameter DIVISOR=5208,
    parameter parity=0
)(
    input wire rst,
    input wire clk, 
    output reg tx_active,
    input wire tx_start,
    output reg tx_done,
    input wire [7:0]tx_data,
    output reg tx_out
);
reg [12:0]baud_count;
wire baud_tick;
reg [2:0]st;
reg parity_bit;
reg [7:0]tx_shift;
reg [3:0]index;
localparam idle=3'd0;
localparam start=3'd1;
localparam data=3'd2;
localparam PARITY=3'd3;
localparam stop=3'd4;

assign baud_tick=(baud_count==(DIVISOR-1));
always @(posedge clk) begin
    if(rst) begin
        baud_count<=13'd0;
    end
    else if(tx_active)begin
        if(baud_tick)begin
            baud_count<=13'd0;
        end
        else begin
            baud_count<=baud_count+13'd1;
        end
    end
    else begin
        baud_count<=13'd0;
    end
end
always @(posedge clk) begin
    if(rst)begin
        st<=idle;
        index<=4'd0;
        tx_shift<=8'd0;
        tx_active<=0;
        tx_done<=0;
        tx_out<=0;
    end
    else begin
        case (st)
            idle:begin
                tx_out<=1'b1;
                tx_done<=0;
                if(tx_start)begin
                    tx_active<=1;
                    tx_shift<=tx_data;
                    st<=start;
                end
            end
            start:begin
                tx_out<=0;
                if(baud_tick)begin
                    st<=data;
                    index<=4'd0;
                end
            end
            data:begin
                tx_out<=tx_shift[0];
                if(baud_tick)begin
                    if(index==4'd7)begin
                        if(parity==0)begin
                            st<=stop;
                        end
                        else begin
                            st<=PARITY;
                        end
                    end
                    else begin
                        index<=index+4'd1;
                        tx_shift<={1'b1,tx_shift[7:1]};
                    end
                end
            end
            PARITY: begin
                // 1. Drive the parity bit onto tx_out immediately
                if (parity == 1) begin // Even Parity
                    tx_out <= ^tx_data; // Directly uses reduction XOR
                end 
                else if (parity == 2) begin // Odd Parity
                    tx_out <= ~^tx_data; // Directly uses inverted reduction XOR
                end

                // 2. Fixed: Hold the state for 104 µs, then move to stop on the tick9o
                if (baud_tick) begin
                    st <= stop;
                end
            end

            stop:begin
                tx_done<=1;
                tx_out<=1;
                if(baud_tick)begin
                    tx_active=1'b0;
                    tx_done=1'b0;
                    st<=idle;
                end
            end
            default:st<=idle;
        endcase
    end
end
endmodule

//total 8 bits are there so we need to index them from msb to lsb-----index is used