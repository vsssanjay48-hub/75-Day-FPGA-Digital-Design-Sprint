module bit4 (
    input wire [3:0]parallel_in,
    input wire load,
    input wire rst,
    input wire clk,

    output reg [3:0]q
);
always @(posedge clk) begin
    if (rst==1'b1) begin
        q=4'b0000;
    end
    else if (load==1'b0) begin
        q<=q;
    end
    else begin
        q<=parallel_in;
    end
end
endmodule 

