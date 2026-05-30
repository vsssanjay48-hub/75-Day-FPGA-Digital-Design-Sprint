module 4_1_MUX(
    input [3:0]a,
    input [1:0]sel,
    output reg y
);
    always @(*) begin
        case (sel)
        2'b00 : y=a[0];
        2'b01 : y=a[1];
        2'b10 : y=a[2];
        2'b11 : y=a[3];
        default : y =1'b0;
        endcase
    end
endmodule 
module 2_4_decoder(
    input [1,0]b,
    input enable,
    output reg [3:0]z
);
    
    always@(*) begin
        z=4'b0000;
        if(enable) begin
            case(b)
            2'b00: z = 4'b0001;
            2'b01: z = 4'b0010;
            2'b10: z = 4'b0100;
            2'b11: z = 4'b1000;
            endcase
            $finish;
        end
    end
endmodule
module 4_2_encoder(
    input [3:0]c,
    output reg valid,
    output [1:0]v
);
    always @(*) begin
        valid=1'b1;
        if (c[3]) v=2'b11;
        if else(c[2]) v=2'b10;
        if else(c[1]) v=2'b01;
        if else(c[0]) v=2'b00;
        else begin
            v=2'b00;
            valid=1'b0;
        end
    end
endmodule







            










