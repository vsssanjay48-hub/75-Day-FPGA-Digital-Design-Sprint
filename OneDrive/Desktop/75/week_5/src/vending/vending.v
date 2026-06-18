module vending(
    input wire coin_5p,
    input wire coin_10p,
    input wire coin_25p,
    output reg dispenceo,
    input wire rst,
    input wire clk

);
reg [1:0]st;
localparam idle =2'b00;
localparam add =2'b01;
localparam dispense =2'b10;
reg [5:0]balance;
always @(posedge clk) begin
    if(rst) begin
        balance<=6'd0;
        dispenceo<=0;
        st<=idle;
    end
    else begin
    case(st)
        idle:begin
            if(coin_5p||coin_10p||coin_25p) begin
                st<=add;
            end
        end
        add:begin
            if(coin_5p)begin
                balance<=balance+6'd5;
            end
            else if(coin_10p)begin
                balance<=balance+6'd10;
            end
            else if (coin_25p)begin
                balance<=balance+6'd25;
            end
            if(balance>=6'd30) begin
                st<=dispense;
                balance<=6'd0;
            end
        end
        dispense:begin
            dispenceo<=1'b1;
            balance<=6'd0;
            st<=idle;
        end

        default st<=idle;
    endcase
    end

end
endmodule

    



        



