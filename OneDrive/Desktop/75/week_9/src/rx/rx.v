module rx_tick (
    input wire clk,
    input wire rst,
    input wire rx,            // Physical incoming RX serial line
    input wire rx_tick,       // The 326-cycle oversampling tick from yesterday
    output reg rx_active      // Status flag showing the receiver is busy
);
wire [8:0]count ;
localparam IDLE =2'b00;
localparam START =2'b01;
wire [1:0]st;
always @(posedge clk) begin
    case(st)
        IDLE:begin
            count<=9'd0;
            rx_active<=0;
            if(rx==0)begin
                st<=START;
            end
        end
        START:begin
            if(rx_tick)begin
                if(count==9'd8)begin
                    if(rx==0)begin
                        rx_active<=1;
                    end
                    else begin
                        st<=IDLE;
                    end

                end
                else begin
                    count<=count+9'd1;
                end
            end
        end
        default:st<=IDLE;
    endcase
end
endmodule
