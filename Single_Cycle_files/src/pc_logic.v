module pc_logic(imm16, imm26, branch, branchOrJmp, regToPC, clk, instruction);
    input [0:15] imm16;
    input [0:25] imm26;
    input branch, branchOrJmp, regToPC; //control signals
    input clk; //clock signal
    output [0:31] instruction;
    
    wire [0:31] imm16_32, imm26_32, imm_final;
    wire [0:31] pc_out, pc_new;
    
    register32 PC_REG(
        .inData(pc_new),
        .clk(clk),
        .writeEnable(1'b1),
        .reset(1'b0),
        .outData(pc_out)
    );
    
    extend_16to32 EXTEND_IMM16(imm16, 1'b1, imm16_32);
    extend_26to32 EXTEND_IMM26(imm26, 1'b1, imm26_32);
    mux2to1_32bit CHOOSE_IMMEDIATE(imm16_32, imm26_32, branchOrJmp, imm_final);
    
    fa_nbit ADD_FOUR(
    
endmodule