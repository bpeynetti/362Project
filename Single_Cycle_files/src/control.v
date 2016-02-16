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
    loadSign, //1 for LB and LH (for sign extend)
    //ALU/Execution Stage Controls
    ALUCtrl,
    mul,
    extOp, //0 for unsigned immediate instructions
    LHIOp //1 for LHI
);
    input [0:31] instruction;
    output PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul, extOp, LHIOp,loadSign;
    output [0:1] DSize;
    output [0:3] ALUCtrl;
    
    //NOTE: for I-type instructions, rd is located where rs2 is located for R-type instructions
    //This will simply be called rs2 for the purposes of our processor
    wire [0:5] opcode, func;
    wire [0:4] fpfunc;
    wire [0:4] rs1, rs2, rd;
    wire [0:15] imm16;
    wire [0:25] imm26;
    wire FPRType, jumpNotLink;
    //wires for ALU controls below
    wire sub; //don't need an add wire, because add has ALU control 0000
    wire slt, sle, sgt, sge, seq, sne;
    wire sra, srl, sll;
    wire andwire, orwire, xorwire;
    
    assign opcode = instruction[0:5];
    assign func = instruction[26:31];
    assign fpfunc = instruction[27:31];
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
    assign jumpNotLink = jump & (~PCtoReg);
    assign RType = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & (~opcode[5]);
    assign FPRType = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & opcode[5]; //if opcode ==1
    assign RegWrite = (~MemWrite) & (~jumpNotLink) & (~branch);
    assign MemToReg = opcode[0] & (~opcode[1]) & (~opcode[2]) & ((~opcode[4]) | ((~opcode[3]) & opcode[4] & opcode[5]));
    assign MemWrite = opcode[0] & (~opcode[1]) & opcode[2] & (~opcode[3]) & ((~opcode[4]) | (opcode[4] & opcode[5]));
    assign loadSign = opcode[0] & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]);
    assign mul = FPRType & fpfunc[2] & fpfunc[3] & (~fpfunc[4]) & (fpfunc[0] ^ fpfunc[1]); //it's either 0x0e or 0x16
    assign extOp = opcode[0] | opcode[1] | (~opcode[2]) | opcode[3] | (~opcode[5]); //the opposite of the opcodes for ADDUI and SUBUI, so that it is zero for these operations
    assign LHIOp = (~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & opcode[5];
    
    assign DSize[0] = opcode[0] & (~opcode[1]) & (~opcode[3]) & opcode[4] & opcode[5];
    assign DSize[1] = (opcode[0] & (~opcode[1]) & (~opcode[3]) & opcode[5]) | (opcode[0] & (~opcode[1]) & (~opcode[2]) & opcode[3] & (~opcode[4]) & opcode[5]);
    
    assign sub = ((~opcode[0]) & (~opcode[1]) & opcode[2] & (~opcode[3]) & opcode[4]) | (RType & func[0] & (~func[1]) & (~func[2]) & (~func[3]) & func[4]);
    assign slt = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & opcode[4] & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & func[4] & (~func[5]));
    assign sle = ((~opcode[0]) & opcode[1] & opcode[2] & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & func[3] & (~func[4]) & (~func[5]));
    assign sgt = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & opcode[4] & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & func[4] & func[5]);
    assign sge = ((~opcode[0]) & opcode[1] & opcode[2] & opcode[3] & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & func[3] & (~func[4]) & func[5]);
    assign seq = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & (~func[4]) & (~func[5]));
    assign sne = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & (~func[4]) & func[5]);
    assign sra = ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & opcode[4] & opcode[5]) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & func[4] & func[5]);
    assign srl = ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & opcode[4] & (~opcode[5])) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & func[4] & (~func[5]));
    assign sll = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & opcode[5]) | ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & (~func[5]));
    assign andwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & (~func[5]));
    assign orwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & func[5]);
    assign xorwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & (~opcode[5])) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & func[4] & (~func[5]));
    
    assign ALUCtrl[0] = sll | srl | seq | sne | andwire | orwire | xorwire;
    assign ALUCtrl[1] = sgt | sge | sra | sne | andwire | orwire | xorwire;
    assign ALUCtrl[2] = slt | sle | sra | srl | seq | orwire | xorwire;
    assign ALUCtrl[3] = sub | sle | sge | sra | sll | seq | andwire | xorwire;
    
endmodule