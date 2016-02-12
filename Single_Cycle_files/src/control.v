module control(
    instruction, //input
    //PC Logic Controls
    PCtoReg, 
    regToPC, 
    jump, 
    branch,
    branchZero, 
    //Register Controls
    RType, //inclues all RType instructions, replaces RegDst and ALUSrc in Datapath
    RegWrite, //all RTypes are included, plus JAL, JALR, LB, LH, LW, LBU, LHU
    //Data Memory Controls
    DSize,
    MemToReg, //all loads
    MemWrite, //all stores
    //ALU/Execution Stage Controls
    ALUCtrl,
    mul,
    extOp, //0 for unsigned immediate instructions
    LHIOp //1 for LHI
);
    input [0:31] instruction;
    output PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul, extOp, LHIOp;
    output [0:1] DSize;
    output [0:4] ALUCtrl;
    
    //NOTE: for I-type instructions, rd is located where rs2 is located for R-type instructions
    //This will simply be called rs2 for the purposes of our processor
    wire [0:5] opcode, func;
    wire [0:4] rs1, rs2, rd;
    wire [0:15] imm16;
    wire [0:25] imm26;
    assign opcode = instruction[0:5];
    assign func = instruction[26:31];
    assign rs1 = instruction[6:10];
    assign rs2 = instruction[11:15];
    assign rd = instruction[16:20];
    assign imm16 = instruction[16:31];
    assign imm26 = instruction[6:31];
    
    assign PCtoReg = (~opcode[0]) & (~opcode[2]) & (~opcode[3]) & opcode[4] & opcode[5];
    assign regToPC = (~opcode[0]) & opcode[1] & (~opcode[2]) & (~opcode[3]) & opcode[4];
    assign jump = (~opcode[0]) & (~opcode[2]) & (~opcode[3]) & opcode[4];
    assign branch = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & opcode[3] & (~opcode[4]);
    assign branchZero = branch & (~opcode[5]);
    assign RType = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & (~opcode[5]);
    assign RegWrite = 
    assign MemToReg = opcode[0] & (~opcode[1]) & (~opcode[2]) & 
    assign MemWrite = 
    assign mul = 
    assign extOp = 
    assign LHIOp = 
    
    assign DSize[0] = 
    assign DSize[1] = 
    
    assign ALUCtrl[0] = 
    assign ALUCtrl[1] = 
    assign ALUCtrl[2] = 
    assign ALUCtrl[3] = 
    assign ALUCtrl[4] = 