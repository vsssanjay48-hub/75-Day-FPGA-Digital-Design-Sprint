module brg #(
    //brg-baud rate generator
    parameter clk_freq=50000000,
    parameter baud_rate=9600,
    parameter DIVISOR=5208
)(
    input wire rst,
    input wire clk, 
    input wire tx_active
);
reg [12:0]baud_count;
wire baud_tick;
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
endmodule

// not complete beacuse i didnot added the fsm of it 

