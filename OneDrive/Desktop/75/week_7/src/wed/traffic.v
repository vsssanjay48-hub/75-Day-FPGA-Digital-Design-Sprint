module traffic (
    output reg o_red,
    output reg o_yellow,
    output reg o_green,
    input wire rst,
    input wire clk
);
reg [1:0]st;
localparam red=2'b00;
localparam yellow=2'b01;
localparam green=2'b10;
reg [4:0]timer_limit;
reg [4:0]baud_count;
always @(posedge clk) begin
    if (rst) begin
        baud_count <= 5'd0;
    end
    else begin
        if (baud_count == timer_limit - 5'd1) begin
            baud_count <= 5'd0; 
        end
        else begin
            baud_count <= baud_count + 5'd1;
        end
    end
end
always @(posedge clk) begin
    if(rst) begin
        timer_limit<=1'b0;
        o_green<=1'b0;
        o_red<=1'b0;
        o_yellow<=1'b0;
        st<=red;
    end
    else begin
        case(st)
            red:begin
                timer_limit<=5'd30;
                o_red<=1'b1;
                o_green<=1'b0;
                o_yellow<=1'b0;
                if(baud_count==timer_limit-1) begin
                    st<=yellow;
                end
            end
            yellow:begin
                timer_limit<=5'd5;
                o_red<=1'b0;
                o_green<=1'b0;
                o_yellow<=1'b1;
                if(baud_count==timer_limit-1) begin
                    st<=green;
                
                end
            end
            green:begin
                timer_limit<=5'd25;
                o_red<=1'b0;
                o_green<=1'b1;
                o_yellow<=1'b0;
                if(baud_count==timer_limit-1) begin
                    st<=red;
                
                end
            end
        endcase
    end
end
endmodule
            


//removed default


