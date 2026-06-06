module pipo(
    input wire [7:0]parallel_in,
    input wire [7:0]enable,
    input wire rst,
    input wire clk,
    output reg [7:0]q
    
);
integer i;
always @(posedge clk) begin
    if (rst==1'b1) begin
        q<=8'b00000000;
    end
    else begin 
        for(i=0;i<8;i=i+1) begin
            if(enable[i]==1'b1) begin
                q[i]<=parallel_in[i];
            end
            else begin
            q[i]<=q[i];
            end

        end
    end
end

endmodule 
