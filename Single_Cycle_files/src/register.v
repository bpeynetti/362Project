module register1(inData, clk, writeEnable, reset, outData);
    
    input inData, clk, writeEnable;
    output outData;
    
    wire ffOut;
    wire muxOut;
    
    mux_1 CHECK_WRITE(ffOut, inData, writeEnable, muxOut);
    dff STORE_DATA(muxOut, clk, reset, ffOut);
    assign outData = ffOut;

endmodule

module register32(inData, clk, writeEnable, reset, outData);

    input clk, writeEnable, reset;
    input [0:31] inData;
    output [0:31] outData;
    
    genvar i;
    generate
        for (i=0; i<32; i=i+1) begin: 32BIT_REGISTER
            register1 REGISTER1 (
                .inData(inData[i]),
                .clk(clk),
                .writeEnable(writeEnable),
                .reset(reset),
                .outData(outData[i]);
        end
    endgenerate

endmodule
    