module execute (
    //inputs
    nextPC,opA,opB,offset26,offset16,opCode,destReg,PCtoReg,
    RegToPC,jump,branch,branchZero,RType,RegWrite,MemToReg,
    MemWrite,loadSign,mul,DSize,ALUCtrl,clk,reset,
    //outputs
    aluResult, leapAddr, leap
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
    output [0:31] aluResult;
    output [0:31] leapAddr;
    output leap;
    
    wire [0:31] imm16_32, imm26_32, imm_final;
    wire sum_cout, sum_of;
    wire zero, of;
    wire not_mul_result, mul_result;
    
    alu alu_ex(
       .A(opA),
       .B(opB),
       .ctrl(ALUCtrl),
       .ALUout(not_mul_result),
       .zero(zero),
       .of(of)
    );
    
    multiplier mul_ex(
        .X(opA),
        .Y(opB),
        .Z(mul_result)
    );
    
    mux2to1_32bit choose_result(
        .X(not_mul_result),
        .Y(mul_result),
        .sel(mul),
        .Z(aluResult)
    );
    
    check_branch decide_if_leap(
        .busA(not_mul_result),
        .branchZero(branchZero),
        .branch(branch),
        .jump(jump),
        .leap(leap)
    );
    
    //SHOULDN'T THESE BY SIGN EXTEND? RIGHT NOW THEY ARE BOTH ZERO EXTEND (taken from PC LOGIC)
    extend_16to32 EXTEND_IMM16(offset16, 1'b0, imm16_32);
    extend_26to32 EXTEND_IMM26(offset26, 1'b0, imm26_32);
    mux2to1_32bit CHOOSE_IMMEDIATE(imm26_32, imm16_32, branch, imm_final);
    
    fa_nbit ADD_IMM(imm_final, nextPC, 1'b0, leapAddr, sum_cout, sum_of);
    //WHERE DOES THE MUX BELOW COME IN (from PC LOGIC, don't know where we need it)
    //mux2to1_32bit IMM_OR_REG(pc_nonreg, reg_out, regToPC, pc_new);
        
endmodule