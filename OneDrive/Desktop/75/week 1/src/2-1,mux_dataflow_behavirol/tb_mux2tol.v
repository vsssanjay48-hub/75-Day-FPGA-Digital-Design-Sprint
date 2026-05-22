module tb_mux2tol;
    reg d0;
    reg d1;
    reg sel;
    wire y_dataflow;
    wire y_behavioral;

    mux2tol_dataflow uut1(
        .d1(d1) , .d0(d0) , .sel(sel) , .y(y_dataflow)
    );
    
    mux2tol_behavioral  uut2(
        .d1(d1) , .d0(d0) , .sel(sel) , .y(y_behavioral)
    );
    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_mux2tol);
        d0 = 0; d1 = 0; sel = 0; #10;
        d0 = 1; d1 = 0; sel = 0; #10; 
        d0 = 0; d1 = 1; sel = 0; #10;
        d0 = 0; d1 = 1; sel = 1; #10;
        d0 = 1; d1 = 0; sel = 1; #10; 
        
        $finish;
    end

endmodule

