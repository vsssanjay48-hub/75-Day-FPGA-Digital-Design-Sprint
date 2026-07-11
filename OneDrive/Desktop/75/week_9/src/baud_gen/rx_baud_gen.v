module rx_baud_gen (
    input wire clk,
    input wire rst,
    output wire baud_tick
);

reg [8:0] baud_count;
assign baud_tick = (baud_count == 9'd325);

always @(posedge clk) begin
    if (rst) begin
        baud_count <= 9'd0;
    end
    else if (baud_tick) begin
        baud_count <= 9'd0;
    end
    else begin
        baud_count <= baud_count + 9'd1;
    end
end
endmodule




