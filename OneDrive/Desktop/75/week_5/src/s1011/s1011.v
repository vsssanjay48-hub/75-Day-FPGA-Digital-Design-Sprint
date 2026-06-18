module s1011(
    input wire data,
    output reg out,
    input wire clk,
    input wire rst
);
reg [1:0]st;
localparam g1=2'b00;
localparam g10=2'b01;
localparam g101=2'b10;
localparam idle=2'b11;

always @(posedge clk) begin
    if(rst) begin
        out=1'b0;
        st<=idle;
    end
    else begin
        case(st)
            idle:begin
                out<=1'b0;
                if(data==1'b1)begin
                    st<=g1;
                end
            end
            g1:begin
                out<=1'b0;
                if(data==1'b0)begin
                    st<=g10;
                end
                else begin
                    out<=1'b0;
                end
            end
            g10:begin
                if(data==1'b1)begin
                    st<=g101;
                end
                else begin
                    st<=idle;
                    out<=1'b0;
                end
            end
            g101:begin
                if(data==1'b1)begin
                    st<=g1;
                end
                else begin
                    st<=g10;
                end
            end
        endcase
    end
end
always @* begin
    if (st == g101 && data == 1'b1)
        out = 1'b1;
    else
        out = 1'b0;
end

endmodule





           
