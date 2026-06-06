module bit_flipflop(
    input wire rst,
    input wire clk,
    input wire serial_in,
    output wire serial_out
    
);
reg [7:0]shift_reg;
assign serial_out=shift_reg[7];
always @(posedge clk) begin
    if(rst==1'b1) begin
        shift_reg <= 8'b00000000;
    end else begin
        shift_reg<={shift_reg[6:0],serial_in};
    end
end
endmodule

