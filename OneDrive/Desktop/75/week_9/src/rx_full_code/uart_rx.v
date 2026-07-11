module uart_rx(
    input wire       clk,
    input wire       rst,
    input wire       rx,     
    output reg       rx_done,
    output reg [7:0] rx_data,
    output reg       rx_active  // Changed from wire to reg
);

    // 1. Micro Clock Divider (Ticks every 326 clock cycles / 6.52 us)
    reg [8:0] baud_count;
    wire      rx_tick;
    
    assign rx_tick = (baud_count == 9'd325);
    
    always @(posedge clk) begin
        if (rst||rx_tick) begin
            baud_count <= 9'd0;
        end
        else begin
            baud_count <= baud_count + 9'd1;
        end
    end

    // 2. Macro Sequence Counter (Counts how many 16x ticks have passed)
    reg [7:0] tick_seq;

    // FSM States
    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;
    
    reg [1:0] st; // Changed from wire to reg

    // 3. Receiver State Machine Logic
    always @(posedge clk) begin
        if (rst) begin
            st        <= IDLE;
            tick_seq  <= 8'd0;
            rx_active <= 1'b0;
            rx_done   <= 1'b0;
            rx_data   <= 8'd0;
        end 
        else begin
            case(st)
                IDLE: begin
                    rx_done  <= 1'b0;
                    tick_seq <= 8'd0;
                    // Wait for the falling edge of the start bit
                    if (rx == 1'b0) begin
                        rx_active <= 1'b1;
                        st        <= START;
                    end
                    else begin
                        rx_active <= 1'b0;
                    end
                end

                START: begin
                    if (rx_tick) begin
                        if (tick_seq == 8'd8) begin // Mid-point of start bit
                            if (rx == 1'b0) begin
                                st <= DATA; // Confirmed real start bit! Move to data
                            end
                            else begin
                                st <= IDLE; // Glitch detected, abort!
                            end
                        end
                        else begin
                            tick_seq <= tick_seq + 8'd1;
                        end
                    end
                end

                DATA: begin
                    if (rx_tick) begin
                        tick_seq <= tick_seq + 8'd1;
                        
                        // Shift in the rx serial line at your exact mid-bit counts!
                        case (tick_seq)
                            8'd24:  rx_data <= {rx, rx_data[7:1]}; // Bit 0
                            8'd40:  rx_data <= {rx, rx_data[7:1]}; // Bit 1
                            8'd56:  rx_data <= {rx, rx_data[7:1]}; // Bit 2
                            8'd72:  rx_data <= {rx, rx_data[7:1]}; // Bit 3
                            8'd88:  rx_data <= {rx, rx_data[7:1]}; // Bit 4
                            8'd104: rx_data <= {rx, rx_data[7:1]}; // Bit 5
                            8'd120: rx_data <= {rx, rx_data[7:1]}; // Bit 6
                            8'd136: begin
                                    rx_data <= {rx, rx_data[7:1]}; // Bit 7
                                    st      <= STOP;               // Move to stop bit phase
                            end
                        endcase
                    end
                end

                STOP: begin
                    if (rx_tick) begin
                        // 136 + 16 = 152 (The mid-point of the stop bit)
                        if (tick_seq == 8'd152) begin
                            rx_done   <= 1'b1;
                            rx_active <= 1'b0;
                            st        <= IDLE; // Return back home to wait for next byte
                        end
                        else begin
                            tick_seq <= tick_seq + 8'd1;
                        end
                    end
                end

                default: st <= IDLE;
            endcase
        end
    end
endmodule
