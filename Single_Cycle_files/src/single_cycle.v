// --------------------
// Single Cycle processor file
// EECS 362 
// --------------------


module single_cycle(clk,reset,busWout,instructionOut);
    parameter WIDTH=32;
    //only input is the clock
    input clk;
    input reset;
    
    //output (for testing purposes) is busW and instruction
    output [0:(WIDTH-1)] busWout,instructionOut;
    
    // Signals directly from the instruction
    wire [0:(WIDTH-1)] instructionAddr;
    wire [0:(WIDTH-1)] instruction;
    wire [0:4] r1,r2,rd;
    wire [0:15] imm16;
    wire [0:25] imm26;
    //and assign these as needed
    assign r1 = instruction[6:10];
    assign r2 = instruction[11:15];
    assign rd = instruction[16:20];
    assign imm16 = instruction[16:31];
    assign imm26 = instruction[6:31];
    
    
    wire [0:31] busW;
    wire [0:31] busA,busB;
    
    wire leap;
    
    
    //control signals
    wire PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul, extOp, LHIOp;
    wire [0:1] DSize;
    wire [0:3] ALUCtrl;
    
    //wire control signals
    control CONTROL(
            .instruction(instruction), //input
            .PCtoReg(PCtoReg), 
            .regToPC(regToPC), 
            .jump(jump), 
            .branch(branch),
            .branchZero(branchZero), 
            //Register Controls
            .RType(RType), //inclues all RType instructions, replaces RegDst and ALUSrc in Datapath
            .RegWrite(RegWrite), //all RTypes are included, plus JAL, JALR, LB, LH, LW, LBU, LHU
            //Data Memory Controls
            .DSize(DSize),
            .MemToReg(MemToReg), //all loads
            .MemWrite(MemWrite), //all stores
            .loadSign(loadSign), //1 for LB and LH (for sign extend)
            //ALU/Execution Stage Controls
            .ALUCtrl(ALUCtrl),
            .mul(mul),
            .extOp(extOp), //0 for unsigned immediate instructions
            .LHIOp(LHIOp) //1 for LHI
    );
    
    //out of reg file
    wire [0:(WIDTH-1)] regA,regB;
    
    
    //check_branch to see if we need to branch/jump or not
    check_branch CHECK_BRNCH_JMP (
        .busA(busA),
        .branchZero(branchZero),
        .branch(branch),
        .jump(jump),
        .leap(leap)
    );
    
    wire [0:31] save_addr; //pc+4 to be saved in  a register
    wire [0:31] reg_out;
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
        .instruction(instructionAddr),
        .save_addr(save_addr)
    );
    
    //wiring pclogic to instruction memory
    imem I_MEM (.addr(instructionAddr),.instr(instruction));
    
    
    //input to the register file 
    wire [0:4] r2OrRd,rw;
    //mux with selector which is rType=1, else=0
    mux2to1_5bit R2_OR_RD(
        .X(r2),
        .Y(rd),
        .sel(RType),
        .Z(r2OrRd)
    );
    
    //now the one that works with jar/jal (save pc to register 31)
    mux2to1_5bit SAVE_TO_PC(
        .X(r2OrRd),
        .Y(5'd31),
        .sel(PCtoReg),
        .Z(rw)
    );
    
    //mux to determine if it's busW or the current PC going into as busW
    wire [0:31] busWin;
    mux2to1_32bit DETERMINE_BUSW(
        .X(busW),
        .Y(save_addr),
        .sel(PCtoReg),
        .Z(busWin)
    );
    assign busWout = busWin;
    //now wire things into and out of the register file
    register_file REGFILE(
        .rd(rw), //destination register number
        .ra(r1), //source 1 register number (goes to busA)
        .rb(r2), //source 2 register number (goes to busB)
        .busW(busWin), //value to write into rd
        .clk(clk), //clock
        .writeEnable(RegWrite), //1 to write
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
        .sel(LHIOp),
        .Z(busBImmediate)
    );
    
    
    
    //execution (out of register file and into alu)
    wire [0:(WIDTH-1)] aluA,aluB;
    
    //put bus B through a mux that selects 1 if it's rtype instruction
    mux2to1_32bit WIRE_ALU_B(
        .X(busBImmediate),
        .Y(busB),
        .sel(RType),
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
        .sel(LHIOp),
        .Z(aluA)
    );
    assign reg_out = aluA;
    
    wire [0:31] aluOut;
    //wire into the alu
    alu ALU(
        .A(aluA),
        .B(aluB),
        .ctrl(ALUCtrl),
        .ALUout(aluOut)
    );
    
    wire [0:31] multOut;
    multiplier MULT(
        .X(aluA),
        .Y(aluB),
        .Z(multOut)
    );
    
    //and mux the output to either an alu or a multiplier
    wire [0:31] aluOrMultOut;
    mux2to1_32bit MULT_OR_ALU (
        .X(aluOut),
        .Y(multOut),
        .sel(mul),
        .Z(aluOrMultOut)
    );
    
    //this should be wired now to the address for data  memory
    
    //
    wire [0:31] rawMemOut;
    wire [0:31] dataOut;
    wire [0:31] dataIn;
    
    assign dataIn = busB;
    
    //add extenders for data in?
    
    //wire data memory
    dmem DATA_MEM (
        .addr(aluOrMultOut),
        .rData(rawMemOut),
        .wData(dataIn),
        .writeEnable(MemWrite),
        .dsize(DSize),
        .clk(clk)
    );
        
    //extender/shifter here to load correct data
    outData SELECT_CORRECT_SEGMENTS (
        .rawMemOut(rawMemOut),
        .DSize(DSize),
        .loadSign(loadSign),
        .dataOut(dataOut)
    );
    
    
    //mem to register (if writing or not to register)
    mux2to1_32bit ALU_MEMORY(
        .X(aluOrMultOut),
        .Y(dataOut),
        .sel(MemToReg),
        .Z(busW)
    );
    


endmodule