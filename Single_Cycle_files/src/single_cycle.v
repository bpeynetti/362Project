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
    wire [0:4] r2OrRd,rw;
    //mux with selector which is rType=1, else=0
    mux2to1_5bit r2_rd(
        .X(r2),
        .Y(rd),
        .sel(rType),
        .Z(r2OrRd)
    );
    
    //now the one that works with jar/jal (save pc to register 31)
    mux2to1_5bit SAVE_PC(
        .X(r2OrRd),
        .Y(5'd31),
        .sel(pcToReg),
        .Z(rw)
    );
    
    //mux to determine if it's busW or the current PC going into as busW
    wire [0:31] busWin;
    mux2to1_32bit DETERMINE_BUSW(
        .X(busW),
        .Y(instructionAddr),
        .sel(pcToReg),
        .Z(busWin)
    );
    
    //now wire things into and out of the register file
    register_file REGFILE(
        .rd(rw), //destination register number
        .rs(rs), //source 1 register number (goes to busA)
        .rt(rt), //source 2 register number (goes to busB)
        .busW(busWin), //value to write into rd
        .clk(clk), //clock
        .writeEnable(regWrite), //1 to write
        .reset(reset), //1 for reset
        .busA(busA), //value from register rs
        .busB(busB) //value from register rt
    );
        
        
        
    
    
    
    
    
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