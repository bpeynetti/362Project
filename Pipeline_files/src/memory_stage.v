module memory_stage(
    //inputs from ex_mem register
    nextPC_in, opB_in, destReg_in, aluResult_in,
    PCtoReg_in,
    RegToPC_in, //not needed?
    
    RegWrite_in, MemToReg_in, MemWrite_in, loadSign_in,
    DSize_in, fDestReg_in, fbusW_in, FPRegWrite_in, mul_in,
    //std clk/reset
    clk, reset,
    //input from data memory
    dMemValue_in,
    //outputs for mem_wb register
    nextPC_out, destReg_out, aluResult_out, dataOut_out,
    PCtoReg_out, RegWrite_out, MemToReg_out, loadSign_out,
    DSize_out, fDestReg_out, fbusW_out, FPRegWrite_out, mul_out
    );
    
    input [0:31] nextPC_in;
    input [0:4] destReg_in;
    input [0:31] aluResult_in;
    input [0:31] opB_in;
    input PCtoReg_in;
    input RegToPC_in;
    input RegWrite_in;
    input MemToReg_in;
    input MemWrite_in;
    input loadSign_in;
    input [0:1] DSize_in;
    input [0:4] fDestReg_in;
    input [0:63] fbusW_in;
    input FPRegWrite_in, mul_in;
    input clk, reset;
    input [0:31] dMemValue_in;
    
    output [0:31] nextPC_out;
    output [0:4] destReg_out;
    output [0:31] aluResult_out;
    output [0:31] dataOut_out;
    output PCtoReg_out;
    output RegWrite_out;
    output MemToReg_out;
    output loadSign_out;
    output [0:1] DSize_out;
    output [0:4] fDestReg_out;
    output [0:63] fbusW_out;
    output FPRegWrite_out, mul_out;
    
    assign nextPC_out = nextPC_in;
    assign destReg_out = destReg_in;
    assign aluResult_out = aluResult_in;
    assign PCtoReg_out = PCtoReg_in;
    assign RegWrite_out = RegWrite_in;
    assign MemToReg_out = MemToReg_in;
    assign loadSign_out = loadSign_in;
    assign DSize_out = DSize_in;
    assign fDestReg_out = fDestReg_in;
    assign fbusW_out = fbusW_in;
    assign FPRegWrite_out = FPRegWrite_in;
    assign mul_out = mul_in;
    
    assign dataOut_out = dMemValue_in;
    
    
endmodule