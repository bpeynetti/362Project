module register1(inData, clk, writeEnable, outData);
    
    input inData, clk, writeEnable;
    output outData;
    
    wire ffOut;
    wire muxOut;
    
    mux_1 CHECK_WRITE(ffOut, inData, writeEnable, muxOut);
    dff STORE_DATA(muxOut, clk, 1'b1, ffOut);
    assign outData = ffOut;

endmodule

