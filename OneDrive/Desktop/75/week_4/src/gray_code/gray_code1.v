module gray_code1(
    output reg [3:0]bin,
    input wire clk,
    input wire rst,
    output wire [3:0]gray

);
always @(posedge clk) begin
    if (rst==1) begin
        bin <= 4'b0000;
    end
    else begin 
        bin <= bin+ 4'b0001;
    end
end

    assign gray = bin ^ (bin >> 1);
endmodule


//this will work independ