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
    mul_out,
    extOp, //0 for unsigned immediate instructions
    LHIOp, //1 for LHI
    jumpNonReg,
    FPRType_out, // 1 if floating point operation, 0 otherwise
    FPRegWrite_out,
    movfp2i_out,
    movi2fp_out //signals to be used in execution stage
);
    input [0:31] instruction;
    output PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul_out, extOp, LHIOp,loadSign,jumpNonReg;
    output [0:1] DSize;
    output [0:3] ALUCtrl;
    output FPRType_out,FPRegWrite_out;
    output movi2fp_out,movfp2i_out;
    
    wire FPRType;
    assign FPRType_out = FPRType;
    wire movi2fp;
    wire movfp2i;

    
    //NOTE: for I-type instructions, rd is located where rs2 is located for R-type instructions
    //This will simply be called rs2 for the purposes of our processor
    wire [0:5] opcode, func;
    wire [0:4] fpfunc;
    wire [0:4] rs1, rs2, rd;
    wire [0:15] imm16;
    wire [0:25] imm26;
    wire jumpNotLink;
    wire mul;
    //wires for ALU controls below
    wire sub; //don't need an add wire, because add has ALU control 0000
    wire slt, sle, sgt, sge, seq, sne;
    wire sra, srl, sll;
    wire andwire, orwire, xorwire;
    wire iz;
    // wire j,jal;
    
    assign opcode = instruction[0:5];
    assign func = instruction[26:31];
    assign fpfunc = instruction[27:31];
    assign rs1 = instruction[6:10];
    assign rs2 = instruction[11:15];
    assign rd = instruction[16:20];
    assign imm16 = instruction[16:31];
    assign imm26 = instruction[6:31];
    assign mul_out = mul;
    
    zero INSTRUCTION_ZERO(
        .X(instruction),
        .z(iz)
    );
    
    assign jumpNonReg = ~(opcode[0] | opcode[1] | opcode[2] | opcode[3] ) & opcode[4]& ~iz;
    
    
    assign PCtoReg = (~opcode[0]) & (~opcode[2]) & (~opcode[3]) & opcode[4] & opcode[5]& ~iz;
    assign regToPC = (~opcode[0]) & opcode[1] & (~opcode[2]) & (~opcode[3]) & opcode[4]&~iz;
    assign jump = (~opcode[0]) & (~opcode[2]) & (~opcode[3]) & opcode[4]&~iz;
    assign branch = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & opcode[3] & (~opcode[4])&~iz;
    assign branchZero = branch & (~opcode[5])&~iz;
    assign jumpNotLink = jump & (~PCtoReg)&~iz;
    assign RType = ((~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & (~opcode[5]))&~iz;
    assign FPRType = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & opcode[5]&~iz; //if opcode ==1
    assign RegWrite = (movfp2i | ((~MemWrite) & (~jumpNotLink) & (~branch)) ) & (~movi2fp) &(~iz);
    assign MemToReg = opcode[0] & (~opcode[1]) & (~opcode[2]) & ((~opcode[4]) | ((~opcode[3]) & opcode[4] & opcode[5]))&~iz;
    assign MemWrite = opcode[0] & (~opcode[1]) & opcode[2] & (~opcode[3]) & ((~opcode[4]) | (opcode[4] & opcode[5]))&~iz;
    assign loadSign = opcode[0] & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4])&~iz;
    assign mul = FPRType & fpfunc[2] & fpfunc[3] & (~fpfunc[4]) & (fpfunc[0] ^ fpfunc[1])&~iz; //it's either 0x0e or 0x16
    assign extOp = opcode[0] | opcode[1] | (~opcode[2]) | opcode[3] | (~opcode[5])&~iz; //the opposite of the opcodes for ADDUI and SUBUI, so that it is zero for these operations
    assign LHIOp = (~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & opcode[5]&~iz;
    
    assign DSize[0] = opcode[0] & (~opcode[1]) & (~opcode[3]) & opcode[4] & opcode[5]&~iz;
    assign DSize[1] = (opcode[0] & (~opcode[1]) & (~opcode[3]) & opcode[5]) | (opcode[0] & (~opcode[1]) & (~opcode[2]) & opcode[3] & (~opcode[4]) & opcode[5])&~iz;
    
    assign sub = ((~opcode[0]) & (~opcode[1]) & opcode[2] & (~opcode[3]) & opcode[4]) | (RType & func[0] & (~func[1]) & (~func[2]) & (~func[3]) & func[4])&~iz;
    assign slt = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & opcode[4] & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & func[4] & (~func[5]))&~iz;
    assign sle = ((~opcode[0]) & opcode[1] & opcode[2] & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & func[3] & (~func[4]) & (~func[5]))&~iz;
    assign sgt = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & opcode[4] & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & func[4] & func[5])&~iz;
    assign sge = ((~opcode[0]) & opcode[1] & opcode[2] & opcode[3] & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & func[3] & (~func[4]) & func[5])&~iz;
    assign seq = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & (~func[4]) & (~func[5]))&~iz;
    assign sne = ((~opcode[0]) & opcode[1] & opcode[2] & (~opcode[3]) & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & func[2] & (~func[3]) & (~func[4]) & func[5])&~iz;
    assign sra = ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & opcode[4] & opcode[5]) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & func[4] & func[5])&~iz;
    assign srl = ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & opcode[4] & (~opcode[5])) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & func[4] & (~func[5]))&~iz;
    assign sll = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & opcode[5]) | ((~opcode[0]) & opcode[1] & (~opcode[2]) & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & (~func[0]) & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & (~func[5]))&~iz;
    assign andwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & (~opcode[4]) & (~opcode[5])) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & (~func[5]))&~iz;
    assign orwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & (~opcode[4]) & opcode[5]) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & (~func[4]) & func[5])&~iz;
    assign xorwire = ((~opcode[0]) & (~opcode[1]) & opcode[2] & opcode[3] & opcode[4] & (~opcode[5])) | (RType & func[0] & (~func[1]) & (~func[2]) & func[3] & func[4] & (~func[5]))&~iz;
    
    assign ALUCtrl[0] = (sll | srl | seq | sne | andwire | orwire | xorwire)&~iz;
    assign ALUCtrl[1] = (sgt | sge | sra | sne | andwire | orwire | xorwire)&~iz;
    assign ALUCtrl[2] = (slt | sle | sra | srl | seq | orwire | xorwire)&~iz;
    assign ALUCtrl[3] = (sub | sle | sge | sra | sll | seq | andwire | xorwire)&~iz;
    
    

    //movi2fp: 11 0101
    // movfp2i:11 0100
    assign movfp2i = RType & (func[0] & func[1] & (~func[2]) & func[3] & (~func[4]) & (~func[5]));
    assign movi2fp = RType & (func[0] & func[1] & (~func[2]) & func[3] & (~func[4]) & func[5]);
    assign movfp2i_out = movfp2i;
    assign movi2fp_out = movi2fp;
    //FPRegWrite happens on mul or movi2fp
    assign FPRegWrite_out =  mul | movi2fp;
    
endmodule