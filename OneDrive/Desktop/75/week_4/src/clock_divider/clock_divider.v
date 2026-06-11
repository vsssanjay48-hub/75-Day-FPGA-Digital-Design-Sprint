module clock_divider #(parameter DIVISOR =4
)(
    input wire clk_in,
    output reg clk_out,
    input wire rst
);
reg [3:0] count;
always @(posedge clk_in) begin
    if(rst==1) begin
        count<=4'b0000;
        clk_out<=1'b0;
    end
    else begin
        if(count==(DIVISOR/2)-1) begin
            count<=4'b0000;
            clk_out<=~clk_out;
        end
        else begin
            count<=count +4'b0001;
        end
    end
end
endmodule


