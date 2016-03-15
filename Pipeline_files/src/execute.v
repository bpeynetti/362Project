module execute (
    //inputs
    nextPC_in,opA_in,opB_in,offset26_in,offset16_in,destReg_in,PCtoReg_in,
    RegToPC_in,jump_in,branch_in,branchZero_in,RType_in,RegWrite_in,MemToReg_in,
    MemWrite_in,loadSign_in,mul_in,DSize_in,ALUCtrl_in, memVal_in, f1_in, f2_in, fDestReg_in,
    FPRType_in, FPRegWrite_in, movfp2i_in, movi2fp_in,
    //basic clk, reset input
    clk,reset,
    //outputs
    nextPC_out, aluResult_out, leapAddr_out, destReg_out, leap_out,
    PCtoReg_out, RegToPC_out, 
    RegWrite_out, MemToReg_out, MemWrite_out, loadSign_out, DSize_out, memVal_out,
    stall_out, fDestReg_out, fbusW, FPRegWrite_out, mul_out
    );
    
    input [0:31] nextPC_in;
    input [0:31] opA_in;
    input [0:31] opB_in;
    input [0:25] offset26_in;
    input [0:15] offset16_in;
    input [0:4] destReg_in;
    input PCtoReg_in;
    input RegToPC_in;
    input jump_in;
    input branch_in;
    input branchZero_in;
    input RType_in;
    input RegWrite_in;
    input MemToReg_in;
    input MemWrite_in;
    input loadSign_in;
    input mul_in;
    input [0:1] DSize_in;
    input [0:3] ALUCtrl_in;
    input [0:31] memVal_in;
    //FLOATING POINT INPUTS
    input [0:31] f1_in, f2_in;
    input [0:4] fDestReg_in;
    input FPRType_in, FPRegWrite_in, movfp2i_in, movi2fp_in;
    input clk,reset;
    
    output [0:31] nextPC_out;
    output [0:31] aluResult_out;
    output [0:31] leapAddr_out;
    output [0:4] destReg_out;
    output leap_out;
    output PCtoReg_out;
    output RegToPC_out;
    output RegWrite_out;
    output MemToReg_out;
    output MemWrite_out;
    output loadSign_out;
    output [0:1] DSize_out;
    output [0:31] memVal_out;
    output stall_out;
    //FLOATING POINT OUTPUTS
    output [0:4] fDestReg_out;
    output [0:63] fbusW;
    output FPRegWrite_out, mul_out;
    
    wire [0:31] imm16_32, imm26_32, imm_final;
    wire sum_cout, sum_of;
    wire zero, of;
    wire [0:31] not_mul_result;
    wire [0:31] mul_result_short;
    wire [0:63] mul_result_long;
    wire [0:31] pc_nonreg;
    wire [0:63] opA_long;
    
    
    assign PCtoReg_out = PCtoReg_in;
    assign RegToPC_out = RegToPC_in; //not needed?
    assign RegWrite_out = RegWrite_in;
    assign MemToReg_out = MemToReg_in;
    assign MemWrite_out = MemWrite_in;
    assign loadSign_out = loadSign_in;
    assign DSize_out = DSize_in;
    assign nextPC_out = nextPC_in;
    assign destReg_out = destReg_in;
    assign memVal_out = memVal_in;
    assign fDestReg_out = fDestReg_in;
    assign mul_out = mul_in;
    assign FPRegWrite_out = FPRegWrite_in;
    
    alu alu_ex(
       .A(opA_in),
       .B(opB_in),
       .ctrl(ALUCtrl_in),
       .ALUout(not_mul_result),
       .zero(zero),
       .of(of)
    );
    
    
    //choose whether to take f1 or mul_result
    mux2to1_32bit CHOOSE_FP_OR_NOTMUL(
        .X(not_mul_result),
        .Y(f1_in),
        .sel(movfp2i_in),
        .Z(aluResult_out)
    );
    

    multiplier mul_ex(
        .clk(clk),
        .reset(reset),
        .mul(mul_in),
        .a(f1_in),
        .b(f2_in),
        .done(mul_done),
        .result(mul_result_long)
    );
    
    assign opA_long = {32'd0,opA_in};
    
    //choose to take an input from the i register file (opA) or multiplier result
    mux2to1_64bit CHOOSE_MULT_OR_INT(
        .X(mul_result_long),
        .Y(opA_long),
        .sel(movi2fp_in),
        .Z(fbusW)
    );

    assign stall_out = mul_in & (~mul_done);
    
    // mux2to1_32bit choose_result(
    //     .X(not_mul_result),
    //     .Y(mul_result),
    //     .sel(mul_in),
    //     .Z(aluResult_out)
    // );
    
    
    
    
    
    
    check_branch decide_if_leap(
        .busA(opA_in),
        .aluZero(zero),
        .branchZero(branchZero_in),
        .branch(branch_in),
        .jump(jump_in),
        .leap(leap_out)
    );
    
    extend_16to32 EXTEND_IMM16(offset16_in, 1'b1, imm16_32);
    extend_26to32 EXTEND_IMM26(offset26_in, 1'b1, imm26_32);
    mux2to1_32bit CHOOSE_IMMEDIATE(imm26_32, imm16_32, branch_in, imm_final);
    
    fa_nbit ADD_IMM(imm_final, nextPC_in, 1'b0, pc_nonreg, sum_cout, sum_of);
    mux2to1_32bit IMM_OR_REG(pc_nonreg, opA_in, RegToPC_in, leapAddr_out);
        
    // assign stall_out = 1'b0;
        
    // pc_nonreg ????
endmodule