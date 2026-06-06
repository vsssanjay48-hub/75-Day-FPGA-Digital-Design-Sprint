module pipelinebug(
    input wire clk,
    input wire rst,
    input wire d,
    output reg q1,
    output reg q2
); 
   always@(posedge clk) begin
    q1=d;
    q2=q1;
   end
endmodule

    