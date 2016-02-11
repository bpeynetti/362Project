// --------------------
// Single Cycle processor file
// EECS 362 
// --------------------


module single_cycle(clk,busWout,instructionOut);
    parameter WIDTH=32;
    //only input is the clock
    input clk;
    
    //output (for testing purposes) is busW and instruction
    output [0:(WIDTH-1)] busW,instruction;
    
    //
    //
    // all intermediate signals
    //
    //
    
    // Signals directly from the instruction
    wire [0:(WIDTH-1)] instructionAddr;
    wire [0:(WIDTH-1)] instruction;
    wire [0:5] r1,r2,rd;
    wire [0:15] imm16;
    wire [0:25] imm26;
    
    
    //pc logic related
    wire leap;
    
    
    //control signals
    
    
    
    //out of reg file
    wire [0:(WIDTH-1)] regA,regB;
    
    
    //pc logic
    pc_logic PCLOGIC (
        .imm16(imm16),
        .imm26(imm26),
        .reg_out(reg_out),
        .branch(branch),
        .leap(leap),
        .regToPC(regToPC),
        .clk(clk),
        .reset(reset),
        .instruction(instructionAddr)
    );
        
    
    
    //wiring pclogic to instruction memory
    
    
    
    
    //input to the register file 
    
    
    
    
    
    //extender stuff
    //we signextend imm16
    wire [0:31] imm16Extended;
    wire [0:31] busBImmediate;
    
    extend_16to32 EXTEND_IMM(
        .x(imm16),
        .sign(extOp),
        .Z(imm16Extended)
    );

        //and now put it through a mux that takes 16 as the alternative
    
    mux2to1_32bit EXTEND_16(
        .X(imm16Extended),
        .Y(32'h00000010),
        .sel(LhiOp),
        .Z(busBImmediate)
    );
    
    
    
    //execution (out of register file and into alu)
    wire [0:(WIDTH-1)] aluA,aluB;
    
    //put bus B through a mux that selects 1 if it's rtype instruction
    mux2to1_32bit WIRE_ALU_B(
        .X(busBImmediate),
        .Y(regB),
        .sel(rType),
        .Z(aluB)
    );
    
    //put bus A into a mux that selects imm16 extended or not (for lhi)
    wire [0:31] imm16_aluA;
    extend_16to32 EXTEND_IMM_A(
        .x(imm16),
        .sign(1'b0),
        .Z(imm16_aluA)
    );
    
    mux2to1_32bit WIRE_ALU_A(
        .X(busA),
        .Y(imm16_aluA),
        .sel(LhiOp),
        .Z(aluA)
    );
    
    wire [0:31] aluOut;
    //wire into the alu
    alu ALU(
        .A(aluA),
        .B(aluB),
        .ctrl(AluCtrl),
        .ALUout(aluOut)
    );
        
    
    


endmodule;