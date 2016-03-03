module execute (
    //inputs
    nextPC,opA,opB,offset26,offset16,opCode,destReg,PCtoReg,
    RegToPC,jump,branch,branchZero,RType,RegWrite,MemToReg,
    MemWrite,loadSign,mul,DSize,ALUCtrl,clk,reset
    //outputs
    );

    input [0:31] nextPC;
    input [0:31] opA;
    input [0:31] opB;
    input [0:25] offset_26;
    input [0:15] offset_16;
    input [0:5] opCode;
    input [0:4] destReg;
    input PCtoReg;
    input RegToPC;
    input jump;
    input branch;
    input branchZero;
    input RType;
    input RegWrite;
    input MemToReg;
    input MemWrite;
    input loadSign;
    input mul;
    input [0:1] DSize;
    input [0:3] ALUCtrl;
    input clk,reset;