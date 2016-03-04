module outData(rawMemOut,DSize,loadSign,dataOut);


//takes as input the datamemory out, and shifts/aligns it and extends as needed

    input [0:31] rawMemOut;
    input [0:1] DSize;
    input loadSign; 
    output [0:31] dataOut;
    
    
    wire [0:7] lsByte;
    wire [0:15] lsHalf;
    wire [0:31] selByte,selHalf,selWord;
    
    assign selWord = rawMemOut[0:31];
    assign lsByte = rawMemOut[0:7];
    assign lsHalf = rawMemOut[0:15];
    
    //sign extend both of these
    extend_8to32 EXTEND_BYTE (
        .x(lsByte),
        .sign(loadSign),
        .Z(selByte)
    );
    
    extend_16to32 EXTEND_HALF (
        .x(lsHalf),
        .sign(loadSign),
        .Z(selHalf)
    );
    
    mux4to1_32bit SEL_SIGNAL (
        .in0(selByte),
        .in1(selHalf),
        .in2(32'h0),
        .in3(selWord),
        .sel(DSize),
        .Z(dataOut)
    );
    
    
endmodule
    
    
    
    
    
    