module t_flipflop(
    input wire clk,
    input wire rst,
    input wire t,
    output wire q   // Q is a wire here because it is driven by the instantiated D-FF
);

    wire d_in; // The internal wire connecting the XOR gate to the D-FF

    // The logic gate that creates the toggle behavior
    assign d_in = t ^ q; 

    // Stamping down the D flip-flop we built earlier
    d_flipflop inst (
        .clk(clk),
        .rst(rst),
        .d(d_in), 
        .q(q)
    );

endmodule