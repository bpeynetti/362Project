module write_back(
    //inputs
    nextPC_in, destReg_in, aluResult_in, dataOut_in,
    PCtoReg_in, RegWrite_in, MemToReg_in, loadSign_in,
    DSize_in, fDestReg_in, fbusW_in, FPRegWrite_in, mul_in,
    //outputs
    destReg_out, RegWrite_out, RegWriteVal_out,
    fDestReg_out, fbusW_out, FPRegWrite_out, mul_out
    );
    
    input [0:31] nextPC_in;
    input [0:4] destReg_in;
    input [0:31] aluResult_in;
    input [0:31] dataOut_in;
    input PCtoReg_in;
    input RegWrite_in;
    input MemToReg_in;
    input loadSign_in;
    input [0:1] DSize_in;
    input [0:4] fDestReg_in;
    input [0:63] fbusW_in;
    input FPRegWrite_in, mul_in;
    
    output [0:4] destReg_out;
    output RegWrite_out;
    output [0:31] RegWriteVal_out;
    output [0:4] fDestReg_out;
    output [0:63] fbusW_out;
    output FPRegWrite_out, mul_out;
    
    wire [0:31] dataOutSized;
    wire [0:31] regWriteNonJump;
    
    assign RegWrite_out = RegWrite_in;
    assign fDestReg_out = fDestReg_in;
    assign fbusW_out = fbusW_in;
    assign FPRegWrite_out = FPRegWrite_in;
    assign mul_out = mul_in;
    assign destReg_out = destReg_in;

    
    outData SET_LOAD_SIZE(
        .rawMemOut(dataOut_in),
        .DSize(DSize_in),
        .loadSign(loadSign_in),
        .dataOut(dataOutSized)
    );
    
    mux2to1_32bit MEM_OR_ALU(
        .X(aluResult_in),
        .Y(dataOutSized),
        .sel(MemToReg_in),
        .Z(regWriteNonJump)
    );
    
    mux2to1_32bit JUMP_OR_NOT(
        .X(regWriteNonJump),
        .Y(nextPC_in),
        .sel(PCtoReg_in),
        .Z(RegWriteVal_out)
    );
    
endmodule