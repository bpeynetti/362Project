module instruction_decode(
    //input ports 
    nextPC_in, instruction_in,clk,reset,busA_in,busB_in,
    //output ports
    nextPC_out, PCtoReg_out,RegToPC_out,jump_out,branch_out,branchZero_out,
    RType_out,RegWrite_out,MemToReg_out,MemWrite_out,loadSign_out,mul_out,
    extOp_out,LHIOp_out,DSize_out,ALUCtrl_out,
    // and instruction decoded
    imm16_out,imm26_out,busA_out,busB_out,destReg,
    memVal_out,
    jumpNonReg_out,
    r1_out, r2_out,trap_out
    );
    
    parameter SIZE = 32;

    //inputs 
    input [0:SIZE-1] nextPC_in,instruction_in,busA_in,busB_in;
    input clk,reset;
    
    //outputs 
    output [0:SIZE-1] nextPC_out;
    output PCtoReg_out,RegToPC_out,jump_out,branch_out,branchZero_out;
    output RType_out,RegWrite_out,MemToReg_out,MemWrite_out;
    output loadSign_out,mul_out,extOp_out,LHIOp_out;
    output [0:1] DSize_out;
    output [0:3] ALUCtrl_out;
    
    output [0:SIZE-1] busA_out,busB_out;
    output [0:15] imm16_out;
    output [0:25] imm26_out;
    output [0:4] destReg;
    output [0:31] memVal_out;
    output jumpNonReg_out;
    output [0:4] r1_out,r2_out;
    output trap_out;


    wire [0:31] trap_xor;

    xor_32 XOR_TRAP(
        .X(instruction_in),
        .Y(32'h44000300),
        .Z(trap_xor)
    );
    
    zero CHECK_TRAP_INSTRUCTION(
        .X(trap_xor),
        .z(trap_out)
    );
    //what happens in here:
    
    //instruction and nextPC come as inputs
    // register file output comes in here for processing
    // //we perform the MUX with Imm16, sign extenders, and other muxes to determine 
    //      what signals go directly into the ALU
    
    
    ////////////////////////////
    ////
    ////
    ////    ALL SIGNALS THAT ARE USED IN THIS MODULE, AND ALSO ONES PASSED TO THE NEXT MODULE
    ////
    ////////////////////////////
    
    assign nexPC_out = nextPC_in;
    wire extOp;
    wire LHIOp;
    wire RType;
    
    wire PCtoReg;
    
    
    ////////////////////////////
    //////
    //////
    /////       CONTROL SIGNALS  
    /////
    /////
    /////////////////////////////
    
    control CONTROL_ID_STAGE(
        .instruction(instruction_in),
        .PCtoReg(PCtoReg),
        .regToPC(RegToPC_out),
        .jump(jump_out),
        .branch(branch_out),
        .branchZero(branchZero_out),
        .RType(RType),
        .RegWrite(RegWrite_out),
        .DSize(DSize_out),
        .MemToReg(MemToReg_out),
        .MemWrite(MemWrite_out),
        .loadSign(loadSign_out),
        .ALUCtrl(ALUCtrl_out),
        .mul(mul_out),
        .extOp(extOp),
        .LHIOp(LHIOp),
        .jumpNonReg(jumpNonReg_out)
    );
    assign PCtoReg_out = PCtoReg;
    
    /////////////////////////
    /////
    ////
    ////    Split up the instruction into all necessary signals
    ////
    /////////////////////////
    
    wire [0:31] opA;
    wire [0:31] opB;
    wire [0:15] imm16;
    wire [0:25] imm26;
    wire [0:25] imm26_32;
    wire [0:SIZE-1] imm16Extended;
    wire [0:SIZE-1] busBImmediate;
    
    assign opA = busA_in;
    assign opB = busB_in;
    assign imm16 = instruction_in[16:31];
    assign imm16_out = imm16;
    assign imm26 = instruction_in[6:31];
    assign imm26_out = imm26;
    assign destReg = rw;
    assign memVal_out = busB_in;
    
    /////////////
    ///
    ///     FIGURE OUT THE CORRECT OPB (based on imm16, control signals, etc)
    ///
    ///////////////

    assign extOp_out = extOp;
    assign LHIOp_out = LHIOp;
    assign RType_out = RType;
    
    extend_16to32 EXTEND_IMM(
        .x(imm16),
        .sign(extOp),
        .Z(imm16Extended)
    );
    
    //and now put it through a mux that takes 16 as the alternative
    
    mux2to1_32bit EXTEND_16(
        .X(imm16Extended),
        .Y(32'h00000010), //x10 = 16
        .sel(LHIOp),
        .Z(busBImmediate)
    );
    
    mux2to1_32bit WIRE_ALU_B(
        .X(busBImmediate),
        .Y(busB_in),
        .sel(RType),
        .Z(busB_out)
    );
    
    
    wire [0:31] imm16_aluA;
    extend_16to32 EXTEND_IMM_A(
        .x(imm16),
        .sign(1'b0),
        .Z(imm16_aluA)
    );

    mux2to1_32bit WIRE_ALU_A(
        .X(opA),
        .Y(imm16_aluA),
        .sel(LHIOp),
        .Z(busA_out)
    );
    
    
    ///
    /// figure out how to choose the correct destination register
    /// this is a simple RType thing:
        //input to the register file 
    wire [0:4] rd,r1,r2;
    wire [0:4] r2OrRd,rw;
    assign r1 = instruction_in[6:10];
    assign r2 = instruction_in[11:15];
    assign rd = instruction_in[16:20];    //mux with selector which is rType=1, else=0
    
    assign r1_out = r1;
    assign r2_out = r2;
    
    mux2to1_5bit R2_OR_RD(
        .X(r2),
        .Y(rd),
        .sel(RType),
        .Z(r2OrRd)
    );
    // assign rw = r2OrRd;
    
    // now the one that works with jar/jal (save pc to register 31)
    // THIS IS DONE IN THE LAST STAGE
    mux2to1_5bit SAVE_TO_PC(
        .X(r2OrRd),
        .Y(5'd31),
        .sel(PCtoReg),
        .Z(rw)
    );
    
    
endmodule