module clk(
    input wire clk,
    input wire [7:0]data_in,
    input wire [3:0]addr,
    output wire[7:0] data_out,
    input wire wi_en

);
reg [7:0] mem[0:15];
always@(posedge clk) begin
    if (wi_en==1'b1)begin
        mem[addr] <=data_in;
    end
end
//here data will enter in exact same time when adder got value 
assign data_out=mem[addr];
endmodule
