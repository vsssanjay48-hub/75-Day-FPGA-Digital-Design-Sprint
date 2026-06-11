module uart_tx #(
    parameter clk_freq=50000000,//local clk speed
    parameter baud_click=9600,//speed of tarmmiter we need
    parameter DIVISOR=5208
)(
    input wire rst,
    input wire clk,
    input wire tx_start,//signals when to start 
    input wire [7:0]tx_data,
    output reg tx_out,//one bit physical tx wire
    output reg tx_active,//high when tarnsmition is running 
    output reg tx_done //pulses high when one cycle is done 
);
localparam IDLE=2'b00;
localparam START=2'b01;
localparam DATA=2'b10;
localparam STOP=2'b11;
reg [1:0] state;//look the above four shitts to hold those things 
reg [7:0] tx_shift;
reg [12:0] baud_count;//to check with cycle which are going up to 5207
reg [2:0]bits_ind;//track which bit is going
wire baud_tick;
assign baud_tick=(baud_count==(DIVISOR-1));

always @(posedge clk) begin
    if(rst) begin
        baud_count <= 13'd0;
    end
    else if (tx_active) begin
        if (baud_tick) begin 
            baud_count<=13'd0;
        end
        else begin
            baud_count= baud_count +13'd1;
        end
    end
    else begin
        baud_count <= 13'd0;
    end
end
always @(posedge clk) begin
    if (rst) begin
        state <=IDLE;
        tx_out<=1'b1;
        tx_done<=1'b0;
        tx_active<=1'b0;
        tx_shift <=8'd0;
        bits_ind<=4'd0;
    end
    else begin
        case(state)

            IDLE:begin
                tx_out<=1'b1;
                tx_done<=1'b0;
                if(tx_start) begin
                    tx_shift<=tx_data;
                    tx_active<=1'b1;
                    state<=START;
                end
            end
            START:begin
                tx_out=1'b0;
                if(baud_tick) begin
                    state<=DATA;
                    bits_ind<=3'b0;
                end
            end
            DATA:begin
                tx_out<=tx_shift[0];
                if(baud_tick) begin
                    if(bits_ind==3'd7) begin
                        state<=STOP;
                    end
                    else begin
                        bits_ind<= bits_ind +3'd1;
                        tx_shift<={1'b1,tx_shift[7:1]};
                    end
                end
            end
            STOP:begin
                tx_out<=1'b1;
                if(baud_tick) begin
                    tx_active=1'b0;
                    tx_done=1'b0;
                    state<=IDLE;
                end
            end
            default:state<=IDLE;
        endcase

    end
end
endmodule





        









