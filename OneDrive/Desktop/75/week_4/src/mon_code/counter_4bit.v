module counter_4bit(
    input wire rst,
    input wire clk,
    input wire enable,
    input wire updown,
    output reg [3:0]q

);
always @(posedge clk) begin
    if(rst==1) begin
        q<=4'b0000;
    end
    else if(enable==1) begin
        if(updown==1) begin
            q<=q+4'b0001;
        end
        else begin
            q<=q-4'b0001;
        end
    end
    else begin
        q<=q;
    end
end
endmodule
