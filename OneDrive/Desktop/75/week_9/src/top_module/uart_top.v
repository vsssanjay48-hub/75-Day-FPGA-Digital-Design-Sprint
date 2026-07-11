`include "uart.v"
`include "uart_rx.v"
module uart_top(
    input wire clk,
    input wire rst,
    input wire rx,
    output wire [7:0]rx_data,
    input wire [7:0]tx_data,
    input wire send,
    output wire tx_done,
    output wire rx_done,
    output wire tx_active,
    output wire rx_active
);
uart tx_inst(
    .rst(rst), .clk(clk), .tx_start(send), .tx_active(tx_active), .tx_data(tx_data), .tx_done(tx_done)
);
uart_rx rx_inst(
    .rst(rst), .clk(clk), .rx_data(rx_data), .rx_done(rx_done), .rx(rx), .rx_active(rx_active)

);
endmodule

