module pc_logic(imm16, imm26, reg_out, branch,leap, regToPC, clk,reset, instruction,save_addr);
    input [0:15] imm16;
    input [0:25] imm26;
    input [0:31] reg_out;
    input branch, regToPC; //control signals
    input leap; //when you need to branch or jump and the branching condition is true 
    input clk; //clock signal
    input reset; //reset signal
    output [0:31] instruction,save_addr;
    
    wire [0:31] imm16_32, imm26_32, imm_final;
    wire [0:31] pc_out, pc_new, pc_nonreg;
    wire [0:31] pc_plus4, jmp_address;
    wire branch_cond;
    
    wire sum1_cout, sum2_cout, sum1_of, sum2_of;
    assign save_addr = pc_plus4;

    register32 PC_REG(
        .inData(pc_new),
        .clk(clk),
        .writeEnable(1'b1),
        .reset(reset),
        .outData(pc_out)
    );
    
    extend_16to32 EXTEND_IMM16(imm16, 1'b0, imm16_32);
    extend_26to32 EXTEND_IMM26(imm26, 1'b0, imm26_32);
    mux2to1_32bit CHOOSE_IMMEDIATE(imm26_32, imm16_32, branch, imm_final);
    
    fa_nbit ADD_FOUR(pc_out, 32'h0004, 1'b0, pc_plus4, sum1_cout, sum1_of);
    fa_nbit ADD_IMM(imm_final, pc_plus4, 1'b0, jmp_address, sum2_cout, sum2_of);
    
    //THINK THIS MIGHT BE WRONG, the second line specifically (first mux)
    mux2to1_32bit LEAP_OR_PLUS_FOUR(pc_plus4, jmp_address, leap, pc_nonreg);
    mux2to1_32bit IMM_OR_REG(pc_nonreg, reg_out, regToPC, pc_new);

    //changed to pc_out since it's before you calculate the new address
    assign instruction = pc_out;
    
    
endmodule