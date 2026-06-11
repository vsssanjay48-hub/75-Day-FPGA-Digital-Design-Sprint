module counter_nbit(
    input wire rst,
    input wire clk,
    output reg [3:0]q

);
always @(posedge clk) begin
    if(rst==1) begin
        q<=4'b0000;
    end
    else if(q==4'b1001) begin
        q<=4'b0000;
    end
    else begin
        q<=q+4'b0001;
    end
    
end
endmodule
//	Modulo-6 counter: reset at count==5 (not 6!). Modulo-10 counter. 
//Modulo-5208 counter (your future UART baud generator). Verify each resets at exactly the right value. Off-by-one is a real and common bug here.
//for 5208 13 bits needed