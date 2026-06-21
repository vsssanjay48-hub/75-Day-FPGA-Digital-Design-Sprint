module tues(
    input wire clk,
    input wire [7:0]data_in,
    output wire [7:0]data_out1,
    output wire [7:0]data_out2,
    input wire [1:0]addr,//address spec
    input wire [1:0]addr1,
    input wire [1:0]addr2,
    input wire wi

);
reg [7:0]mem1[0:3];
reg [7:0]mem2[0:3];
always @(posedge clk) begin
    if(wi==1'b1)begin
        mem1[addr]<=data_in;
    end
end
assign data_out1= mem1[addr1];
assign data_out2= mem2[addr2];
endmodule

