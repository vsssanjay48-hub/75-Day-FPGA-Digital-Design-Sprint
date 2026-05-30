module tb_hex_7_display;
    reg [3:0]a;
    wire [6:0]out;
    hex_7_display uut(
        .a(a), .out(out)
    );
    integer i;
    initial begin
        for(i=0;i<16;i=i+1) begin
            a=i[3:0];
            #5;
            $display("Time=%0t | Hex Input = %h -> 7-Seg Output (gfedcba) = %b", $time, a, out);
        end
        $finish;


    end
endmodule
