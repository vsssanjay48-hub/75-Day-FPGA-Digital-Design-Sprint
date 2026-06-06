module d_flipflop(
    input wire d,
    input wire rst,
    input wire clk,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if(rst== 1'b1) begin
            q <= 1'b0;
        end 
        else begin
            q<=d;
        end
    end
endmodule
