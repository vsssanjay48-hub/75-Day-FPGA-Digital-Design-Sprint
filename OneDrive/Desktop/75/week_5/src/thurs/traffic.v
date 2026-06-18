module traffic (
    output reg o_red,
    output reg o_yellow,
    output reg o_green,
    input wire rst,
    input wire clk
);

    // 1. Internal Registers & One-Hot Parameters
    reg [2:0] st;
    localparam red    = 3'b001; // Bit 0 is hot
    localparam yellow = 3'b010; // Bit 1 is hot
    localparam green  = 3'b100; // Bit 2 is hot

    // timer_limit is a wire to support instantaneous combinational state changes
    wire [4:0] timer_limit; 
    reg  [4:0] baud_count;

    // 2. BLOCK 1: Protected Counter Engine (Manages baud_count)
    always @(posedge clk) begin
        if (rst) begin
            baud_count <= 5'd0;
        end
        else begin
            if (baud_count == timer_limit - 5'd1) begin
                baud_count <= 5'd0; // Settle perfectly back to 0 when limit is hit
            end
            else begin
                baud_count <= baud_count + 5'd1;
            end
        end
    end

    // 3. BLOCK 2: Clocked One-Hot State Machine & Output Drivers
    always @(posedge clk) begin
        if (rst) begin
            o_green  <= 1'b0;
            o_red    <= 1'b0;
            o_yellow <= 1'b0;
            st       <= red; // Core requirement: Boot up safely with bit 0 hot!
        end
        else begin
            case (st)
                red: begin
                    o_red    <= 1'b1;   // Explicit cleanly mapped outputs
                    o_yellow <= 1'b0;
                    o_green  <= 1'b0;
                    
                    if (baud_count == timer_limit - 5'd1) begin
                        st <= yellow;
                    end
                end

                yellow: begin
                    o_red    <= 1'b0;
                    o_yellow <= 1'b1;   // Explicit cleanly mapped outputs
                    o_green  <= 1'b0;
                    
                    if (baud_count == timer_limit - 5'd1) begin
                        st <= green;
                    end
                end

                green: begin
                    o_red    <= 1'b0;
                    o_yellow <= 1'b0;
                    o_green  <= 1'b1;   // Explicit cleanly mapped outputs
                    
                    if (baud_count == timer_limit - 5'd1) begin
                        st <= red;
                    end
                end

                default: st <= red;
            endcase
        end
    end

    // 4. Combinational Look-Ahead Timer Fix
    // Changes the limit instantly in 0ns when 'st' switches, removing the 1-cycle delay bug
    assign timer_limit = (st == red)    ? 5'd30 :
                         (st == yellow) ? 5'd5  :
                         (st == green)  ? 5'd25 : 5'd0;

endmodule