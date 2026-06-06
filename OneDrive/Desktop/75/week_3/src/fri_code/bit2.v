module bit2 (
    input wire [3:0]parallel_in,
    input wire [1:0]load,
    input wire rst,
    input wire clk,

    output reg [3:0]q
);
always @(posedge clk) begin
    if (rst==1'b1) begin
        q<=4'b0000;
    end
    else if (load==2'b00) begin
        q<=q;
    end
    else if(load==2'b01) begin
        q<={1'b0, q[3:1]};
    end
    else if(load==2'b10) begin
        q<={q[2:0], 1'b0};
    end
    else if(load==2'b11) begin
        q<=parallel_in;
    end
end
endmodule 

