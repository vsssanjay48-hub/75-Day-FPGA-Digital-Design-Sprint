module gray_code1#(
    parameter bit=16
)(
    output reg [bit-1:0]bin,
    input wire clk,
    input wire rst,
    output wire [bit-1:0]gray

);
always @(posedge clk) begin
    if (rst==1) begin
        bin <= {bit{1'b0}};
    end
    else begin 
        bin <= bin+ {bit{1'b1}};
    end
end

    assign gray = bin ^ (bin >> 1);
endmodule


//this will work independ