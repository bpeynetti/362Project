
module top_level(clk,reset);
    input clk,reset;
    
    
    wire [0:66] BUS_PIPE_TO_DMEM;
    wire [0:31] BUS_DMEM_TO_PIPE;
    wire [0:31] BUS_PIPE_TO_IMEM;
    wire [0:31] BUS_IMEM_TO_PIPE;
    
    wire [0:31] dmem_addr;
    wire [0:31] dmem_read;
    wire [0:31] dmem_write;
    wire dmem_writeEnable;
    wire [0:1] dmem_dSize;
    wire [0:31] imem_addr,imem_out;
    wire dmem_we;
    
    //  {aluResult_mem_in,opB_mem_in,MemWrite_mem_in,DSize_mem_in};
    assign dmem_addr = BUS_PIPE_TO_DMEM[0:31];
    assign dmem_write = BUS_PIPE_TO_DMEM[32:63];
    assign dmem_writeEnable = BUS_PIPE_TO_DMEM[64];
    assign dmem_dSize = BUS_PIPE_TO_DMEM[65:66];
    assign BUS_DMEM_TO_PIPE = dmem_read;
    
    assign dmem_we = dmem_writeEnable & reset;
    
    assign imem_addr = BUS_PIPE_TO_IMEM;
    assign BUS_IMEM_TO_PIPE = imem_out;
    
    dmem DATA_MEM(
        .addr(dmem_addr),
        .rData(dmem_read),
        .wData(dmem_write),
        .writeEnable(dmem_writeEnable),
        .dsize(dmem_dSize),
        .clk(clk)
    );
    
    imem INSTRUCTION_MEM(
        .addr(imem_addr),
        .instr(imem_out)
    );
    

    pipeline_processor PIPELINE(
        .clk(clk),
        .reset(reset),
        .DMEM_BUS_OUT(BUS_PIPE_TO_DMEM),
        .DMEM_BUS_IN(BUS_DMEM_TO_PIPE),
        .IMEM_BUS_OUT(BUS_PIPE_TO_IMEM),
        .IMEM_BUS_IN(BUS_IMEM_TO_PIPE)
    );
endmodule



module pipeline_processor(clk,reset,DMEM_BUS_OUT,DMEM_BUS_IN,IMEM_BUS_OUT,IMEM_BUS_IN);

    parameter DMEM_BUS_OUT_SIZE = 67; //this is the input of the memory stage
    parameter DMEM_BUS_IN_SIZE = 32;
    parameter IMEM_BUS_OUT_SIZE = 32;
    parameter IMEM_BUS_IN_SIZE = 32;
    
    parameter ID_EXEC_WIDTH = 277;
    parameter EXEC_MEM_WIDTH = 251;
    parameter MEM_WB_WIDTH = 179;
    
    input clk,reset;
    input [0:DMEM_BUS_IN_SIZE-1] DMEM_BUS_IN; //this is data coming in from memory
    input [0:IMEM_BUS_IN_SIZE-1] IMEM_BUS_IN; //this is the data coming in from imem
    
    output [0:DMEM_BUS_OUT_SIZE-1] DMEM_BUS_OUT; //this carries the data/address to be stored (and writeEnable)
    output [0:IMEM_BUS_OUT_SIZE-1] IMEM_BUS_OUT; //this carries the address of next instruction
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       SIGNAL DECLARATIONS           //
    //  holds all signals that go from one //
    //  stage of execution to another      //
    //                                     //
    //                                     //
    /////////////////////////////////////////    
  

    //HAZARD SIGNALS
    wire rs1_mem_ex_hazard,rs2_mem_ex_hazard;
    wire store_mem_ex_hazard,store_wb_ex_hazard;
    wire rs1_wb_ex_hazard,rs2_wb_ex_hazard;
    wire [0:31] aluResult_mem_in,aluResult_wb_in; //note, we don't use aluResult_wb for hazard
    wire [0:31] RegWriteVal_wb_out;
    wire load_stall_id_if;

    wire wb_mem_hazard;

    wire [0:31] leapAddr_ex_out;
    wire [0:31] leapAddr_mem_in;

    wire leap_ex_out;
    wire leap_mem_in;


    wire trap_id;
    wire trap_ex;
    wire trap_mem;
    wire trap_wb;

    ////STALL SIGNALS (INTO REGISTERS)

    wire [0:63] IF_ID_CORRECT_IN;
    wire [0:203] ID_EXEC_CORRECT_IN;
    wire [0:179] EXEC_MEM_CORRECT_IN;
    wire [0:107] MEM_WB_CORRECT_IN;
    wire stall_ex_out;
    //assign stall_ex_out = stall_in_test;



    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       INSTRUCTION FETCH STAGE       //
    //                                     //
    //                                     //
    /////////////////////////////////////////

    //// SIGNALS 
    wire [0:31] pcplus4_if_out, instruction_if_out;
    wire [0:31] pc_out;
    wire pc_we;
    assign pc_we = ~load_stall_id_if & ~stall_ex_out;
    ///////
    ///     GO TO IMEM BY SETTING IMEM_BUS IN/OUT
    // mux2to1_32bit SEL_CORRECT_PC(
    //     .X(pc_out),
    //     .Y(leapAddr_mem_in),
    //     .sel(leap_mem_in),
    //     .Z(IMEM_BUS_OUT)
    //     );
    assign IMEM_BUS_OUT = pc_out;

    // assign IMEM_BUS_OUT = pc_out;
    
    
    //// wire the IF_STAGE
    instruction_fetch IF_STAGE(
        .leap_addr(leapAddr_mem_in),
        .leap(leap_mem_in),
        .pc_we(pc_we),
        .clk(clk),
        .reset(reset),
        .pcplus4(pcplus4_if_out),
        .pc_out_(pc_out)
    );
    
    assign instruction_if_out = IMEM_BUS_IN;
    
    /////////////////////////////////////////
    //
    //
    //          IF_ID PIPELINE REGISTER
    //
    /////////////////////////////////////////

    wire [0:63] IF_ID_IN,IF_ID_OUT;
    
    assign IF_ID_IN = {pcplus4_if_out,instruction_if_out};
    

    wire if_id_flush;

    assign if_id_flush = leap_mem_in | load_stall_id_if;

    if_id_reg IF_ID_REG(
        .in(IF_ID_CORRECT_IN),
        .flush(load_stall_id_if),
        .out(IF_ID_OUT),
        .clk(clk),
        .reset(reset)
    );
    
    //assign from IF_ID_out to the instruction decode stage

    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       INSTRUCTION DECODE STAGE      //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    //// SIGNALS 
    
    // signals coming in from the pipeline register output (IF_ID)
    wire [0:31] nextPC_id_in, instruction_id_in;
    wire [0:4] r1_id,r2_id; 
    wire [0:31] reg1_id,reg2_id; 
    //these go in and out of the ID stage

    wire [0:31] nextPC_id_out;
    wire [0:31] opA_id;
    wire [0:31] opB_id;
    wire [0:25] offset_26_id;
    wire [0:15] offset_16_id;
    // wire [0:5] opCode_id;
    wire [0:4] destReg_id;
    wire PCtoReg_id;
    wire RegToPC_id;
    wire jump_id;
    wire branch_id;
    wire branchZero_id;
    wire RType_id;
    wire RegWrite_id;
    wire MemToReg_id;
    wire MemWrite_id;
    wire loadSign_id;
    wire mul_id;
    wire extOp_id;
    wire LHIOp_id;
    wire [0:1] DSize_id;
    wire [0:3] ALUCtrl_id;
    wire [0:25] imm26_id;
    wire [0:15] imm16_id;
    wire [0:31] memVal_id;
    wire jumpNonReg_id;
    wire FPRType_id;
    wire FPRegWrite_id;
    wire movfp2i_id,movi2fp_id;

    assign nextPC_id_in = IF_ID_OUT[0:31];
    assign instruction_id_in = IF_ID_OUT[32:63];
    
    //these go into the register file (and out of)

    
    assign r1_id = instruction_id_in[6:10];
    assign r2_id = instruction_id_in[11:15];

    

    
    //here goes the ID module with all its components inside of it
    instruction_decode ID_STAGE(
        .nextPC_in(nextPC_id_in),
        .instruction_in(instruction_id_in),
        .clk(clk),
        .reset(reset),
        .busA_in(reg1_id),
        .busB_in(reg2_id),
        //output
        .nextPC_out(nextPC_id_out),
        .PCtoReg_out(PCtoReg_id),
        .RegToPC_out(RegToPC_id),
        .jump_out(jump_id),
        .branch_out(branch_id),
        .branchZero_out(branchZero_id),
        .RType_out(RType_id),
        .RegWrite_out(RegWrite_id),
        .MemToReg_out(MemToReg_id),
        .MemWrite_out(MemWrite_id),
        .loadSign_out(loadSign_id),
        .mul_out(mul_id),
        .extOp_out(extOp_id),
        .LHIOp_out(LHIOp_id),
        .DSize_out(DSize_id),
        .ALUCtrl_out(ALUCtrl_id),
        .busA_out(opA_id),
        .busB_out(opB_id),
        .imm16_out(offset_16_id),
        .imm26_out(offset_26_id),
        .destReg(destReg_id),
        .memVal_out(memVal_id),
        .jumpNonReg_out(jumpNonReg_id),
        .trap_out(trap_id),
        .FPRType_out(FPRType_id),
        .FPRegWrite_out(FPRegWrite_id),
        .movfp2i_out(movfp2i_id),
        .movi2fp_out(movi2fp_id)
    );
    
    
    /////////////////////////////////////////
    //
    //
    //          ID_EXEC PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    //wire out of this stage to connecto to pipeline registers
    wire [0:ID_EXEC_WIDTH-1] ID_EXEC_IN,ID_EXEC_OUT;
    assign ID_EXEC_IN = 
    {
            nextPC_id_in,
            opA_id,opB_id, offset_16_id, offset_26_id,
            //took out opcode
            destReg_id,
            PCtoReg_id, RegToPC_id,
            jump_id, branch_id,
            branchZero_id, RType_id, 
            RegWrite_id, MemToReg_id, 
            MemWrite_id, loadSign_id, 
            mul_id, DSize_id, ALUCtrl_id,
            memVal_id,
            jumpNonReg_id,
            r1_id,r2_id,
            trap_id,
            f1_id,f2_id,destFReg_id,
            FPRType_id,FPRegWrite_id,
            movfp2i_id,movi2fp_id
    };
    
    wire id_ex_flush;
    assign id_ex_flush = leap_mem_in;

    id_ex_reg #(ID_EXEC_WIDTH) ID_EX_REG(
        .in(ID_EXEC_CORRECT_IN),
        .clk(clk),
        .reset(reset),
        .out(ID_EXEC_OUT),
        .flush(id_ex_flush)
    );
    
    
    //////////////////////////////////////////
    //                                      //
    //                                      //
    //       EXECUTION           STAGE      //
    //                                      //
    //                                      //
    //////////////////////////////////////////

    //// SIGNALS 
    wire [0:31] nextPC_ex_in,nextPC_ex_out;
    wire [0:31] opA_ex_in;
    wire [0:31] opB_ex_in;
    wire [0:25] offset_26_ex_in;
    wire [0:15] offset_16_ex_in;
    // wire [0:5] opCode_ex_in;
    wire [0:4] destReg_ex_in;
    wire PCtoReg_ex_in;
    wire RegToPC_ex_in;
    wire jump_ex_in;
    wire branch_ex_in;
    wire branchZero_ex_in;
    wire RType_ex_in;
    wire RegWrite_ex_in;
    wire MemToReg_ex_in;
    wire MemWrite_ex_in;
    wire loadSign_ex_in;
    wire mul_ex_in;
    wire [0:1] DSize_ex_in;
    wire [0:3] ALUCtrl_ex_in;
    wire [0:31] memVal_ex_in;
    wire jumpNonReg_ex_in;
    wire [0:4] r1_ex_in,r2_ex_in;
    
    wire [0:31] f1_ex_in,f2_ex_in;
    wire [0:4] fDestReg_ex_in;
    wire FPRType_ex_in,FPRegWrite_ex_in,movfp2i_ex_in,movi2fp_ex_in;
    
    
    //output signals of the execute stage
    // wire [0:31] nextPC_ex_out;
    wire [0:31] aluResult_ex_out;
    wire [0:4] destReg_ex_out;
    wire PCtoReg_ex_out;
    wire RegToPC_ex_out;
    // wire jump_ex_out;
    // wire branch_ex_out;
    // wire branchZero_ex_out;
    wire RegWrite_ex_out;
    wire MemToReg_ex_out;
    wire MemWrite_ex_out;
    wire loadSign_ex_out;
    wire [0:1] DSize_ex_out;
    wire [0:31] memVal_ex_out;
    
    wire [0:4] fDestReg_ex_out;
    wire [0:63] fbusW_ex_out;
    wire FPRegWrite_ex_out;//.FPRegWrite_ou(FPRegWrite_ex_out),
    wire mul_ex_out; //   .mul_out(mul_ex_out)
    
    

    wire [0:31] opA_id_ex_out,opB_id_ex_out;
    
    assign nextPC_ex_in = ID_EXEC_OUT[0:31];
    assign opA_id_ex_out = ID_EXEC_OUT[32:63];
    assign opB_id_ex_out = ID_EXEC_OUT[64:95];
    assign offset_26_ex_in = ID_EXEC_OUT[96:121];
    assign offset_16_ex_in = ID_EXEC_OUT[122:137];
    // assign [0:5] opCode_ex_in = ID_EXEC_OUT[138:143];
    assign destReg_ex_in = ID_EXEC_OUT[138:142];
    assign PCtoReg_ex_in = ID_EXEC_OUT[143];
    assign RegToPC_ex_in = ID_EXEC_OUT[144];
    assign jump_ex_in = ID_EXEC_OUT[145];
    assign branch_ex_in = ID_EXEC_OUT[146];
    assign branchZero_ex_in = ID_EXEC_OUT[147];
    assign RType_ex_in = ID_EXEC_OUT[148];
    assign RegWrite_ex_in = ID_EXEC_OUT[149];
    assign MemToReg_ex_in = ID_EXEC_OUT[150];
    assign MemWrite_ex_in = ID_EXEC_OUT[151];
    assign loadSign_ex_in = ID_EXEC_OUT[152];
    assign mul_ex_in = ID_EXEC_OUT[153];
    assign DSize_ex_in = ID_EXEC_OUT[154:155];
    assign ALUCtrl_ex_in = ID_EXEC_OUT[156:159];
    assign memVal_ex_in = ID_EXEC_OUT[160:191];
    assign jumpNonReg_ex_in = ID_EXEC_OUT[192];
    assign r1_ex_in = ID_EXEC_OUT[193:197];
    assign r2_ex_in = ID_EXEC_OUT[198:202];
    assign trap_ex = ID_EXEC_OUT[203];
    
    //wire [0:31] f1_ex_in,f2_ex_in;
    //wire [0:4] fDestReg_ex_in;
    //wire FPRType_ex_in,FPRegWrite_ex_in,movfp2i_ex_in,movi2fp_ex_in;
    assign f1_ex_in = ID_EXEC_OUT[204:235];
    assign f2_ex_in = ID_EXEC_OUT[236:267];
    assign fDestReg_ex_in = ID_EXEC_OUT[268:272];
    assign FPRType_ex_in = ID_EXEC_OUT[273];
    assign FPRegWrite_ex_in = ID_EXEC_OUT[274];
    assign movfp2i_ex_in = ID_EXEC_OUT[275];
    assign movi2fp_ex_in = ID_EXEC_OUT[276];

    wire [0:31] opA_ex_mem_hzd,opB_ex_mem_hzd;
    wire [0:31] opA_wb_ex_hzd, opB_wb_ex_hzd;

    // DATA HAZARD WB_EX
    mux2to1_32bit OPA_WB_EX_HAZARD(
        .X(opA_id_ex_out),
        .Y(RegWriteVal_wb_out),
        .sel(rs1_wb_ex_hazard),
        .Z(opA_wb_ex_hzd)
    );

    mux2to1_32bit OPB_WB_EX_HAZARD(
        .X(opB_id_ex_out),
        .Y(RegWriteVal_wb_out),
        .sel(rs2_wb_ex_hazard),
        .Z(opB_wb_ex_hzd)
    );

    //DATA HAZARD MEM_EX
    mux2to1_32bit OPA_MEM_EX_HAZARD(
        .X(opA_wb_ex_hzd),
        .Y(aluResult_mem_in),
        .sel(rs1_mem_ex_hazard),
        .Z(opA_ex_in)
    );

    mux2to1_32bit OPB_MEM_EX_HAZARD(
        .X(opB_wb_ex_hzd),
        .Y(aluResult_mem_in),
        .sel(rs2_mem_ex_hazard),
        .Z(opB_ex_in)
    );



    wire [0:31] memVal_partial_ex_in;
    wire [0:31] memVal_correct_ex_in;
    
    mux2to1_32bit WB_EX_STORE_HAZARD(
        .X(memVal_ex_in),
        .Y(aluResult_wb_in),
        .sel(store_wb_ex_hazard),
        .Z(memVal_partial_ex_in)
    );
    
    mux2to1_32bit MEM_EX_STORE_HAZARD(
        .X(memVal_partial_ex_in),
        .Y(aluResult_mem_in),
        .sel(store_mem_ex_hazard),
        .Z(memVal_correct_ex_in)
    );
    // memVal_ex_in


    execute EXEC_STAGE(
        //inputs 
        .clk(clk),
        .reset(reset),
        .nextPC_in(nextPC_ex_in),
        .opA_in(opA_ex_in),
        .opB_in(opB_ex_in),
        .offset26_in(offset_26_ex_in),
        .offset16_in(offset_16_ex_in),
        // .opCode(opCode_ex_in),
        .destReg_in(destReg_ex_in),
        .PCtoReg_in(PCtoReg_ex_in),
        .RegToPC_in(RegToPC_ex_in),
        .jump_in(jump_ex_in),
        .branch_in(branch_ex_in),
        .branchZero_in(branchZero_ex_in),
        .RType_in(RType_ex_in),
        .RegWrite_in(RegWrite_ex_in),
        .MemToReg_in(MemToReg_ex_in),
        .MemWrite_in(MemWrite_ex_in),
        .loadSign_in(loadSign_ex_in),
        .mul_in(mul_ex_in),
        .DSize_in(DSize_ex_in),
        .ALUCtrl_in(ALUCtrl_ex_in),
        .memVal_in(memVal_correct_ex_in),
        
        //floating point stuff inputs
        .f1_in(f1_ex_in), //32
        .f2_in(f2_ex_in), //32 
        .fDestReg_in(fDestReg_ex_in), //5
        .FPRType_in(FPRType_ex_in), //1
        .FPRegWrite_in(FPRegWrite_ex_in), //1
        .movfp2i_in(movfp2i_ex_in), //1
        .movi2fp_in(movi2fp_ex_in), //1
        
        // outputs 
        .nextPC_out(nextPC_ex_out),
        .aluResult_out(aluResult_ex_out),
        .leapAddr_out(leapAddr_ex_out),
        .destReg_out(destReg_ex_out),
        .PCtoReg_out(PCtoReg_ex_out),
        .RegToPC_out(RegToPC_ex_out),
        .RegWrite_out(RegWrite_ex_out),
        .MemToReg_out(MemToReg_ex_out),
        .MemWrite_out(MemWrite_ex_out),
        .loadSign_out(loadSign_ex_out),
        .DSize_out(DSize_ex_out),
        .leap_out(leap_ex_out),
        .memVal_out(memVal_ex_out),
        .stall_out(stall_ex_out)
        
        //floating point stuff outputs
        .fDestReg_out(fDestReg_ex_out),
        .fbusW(fbusW_ex_out),
        .FPRegWrite_out(FPRegWrite_ex_out),
        .mul_out(mul_ex_out)
        
    );
    
    wire [0:31] opB_ex_out;
    assign opB_ex_out = opB_ex_in;
    
    /////////////////////////////////////////
    //
    //
    //          EXEC_MEM PIPELINE REGISTER
    //
    /////////////////////////////////////////
    wire [0:4] rs2_ex_out;
    assign rs2_ex_out = r2_ex_in;
    
    wire [0:EXEC_MEM_WIDTH-1] EXEC_MEM_IN,EXEC_MEM_OUT;
    assign EXEC_MEM_IN = 
    {
           nextPC_ex_out,opB_ex_out,
           destReg_ex_out,aluResult_ex_out,
           PCtoReg_ex_out,RegToPC_ex_out,
           RegWrite_ex_out,MemToReg_ex_out,
           MemWrite_ex_out,loadSign_ex_out,
           DSize_ex_out,
           leapAddr_ex_out, leap_ex_out,
           memVal_ex_out,
           rs2_ex_out,
           trap_ex,
           fDestReg_ex_out,fbusW_ex_out,
           FPRegWrite_ex_out,mul_ex_out
    };

    wire ex_mem_flush;
    assign ex_mem_flush = leap_mem_in;
    
    ex_mem_reg #(EXEC_MEM_WIDTH) EX_MEM_REGISTER(
        .in(EXEC_MEM_CORRECT_IN),
        .clk(clk),
        .reset(reset),
        .out(EXEC_MEM_OUT),
        .flush(ex_mem_flush)
    );
    

    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       MEMORY            STAGE       //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
        //// SIGNALS 
    ///
    /// SIGNALS THAT GO TO THE IF STAGE -> LEAP_ADDR and LEAP


    //DECLARATIONS
    wire [0:31] nextPC_mem_in;
    wire [0:31] opB_mem_in;
    wire [0:4] destReg_mem_in;
    wire PCtoReg_mem_in;
    wire RegToPC_mem_in;
    wire RegWrite_mem_in;
    wire MemToReg_mem_in;
    wire MemWrite_mem_in;
    wire loadSign_mem_in;
    wire [0:1] DSize_mem_in;
    wire [0:31] memVal_mem_in;
    
    wire [0:4] fDestReg_mem_in,fDestReg_mem_out;
    wire [0:63] fbusW_mem_in,fbusW_mem_out;
    wire FPRegWrite_mem_in, FPRegWrite_mem_out;
    wire mul_mem_in,mul_mem_out;
    
    //outputs of MEMORY stage
    wire [0:31] nextPC_mem_out;
    wire [0:4] destReg_mem_out;
    wire [0:31] aluResult_mem_out;
    wire [0:31] dataOut_mem_out;
    wire PCtoReg_mem_out, RegToPC_mem_out, RegWrite_mem_out, MemToReg_mem_out;
    wire loadSign_mem_out;
    wire [0:1] DSize_mem_out;
    wire [0:4] rs2_mem_in;
    
    //get signals out of the register file
    assign nextPC_mem_in = EXEC_MEM_OUT[0:31];
    assign opB_mem_in = EXEC_MEM_OUT[32:63];
    assign destReg_mem_in = EXEC_MEM_OUT[64:68];
    assign aluResult_mem_in = EXEC_MEM_OUT[69:100];
    assign PCtoReg_mem_in = EXEC_MEM_OUT[101];
    assign RegToPC_mem_in = EXEC_MEM_OUT[102];
    assign RegWrite_mem_in = EXEC_MEM_OUT[103];
    assign MemToReg_mem_in = EXEC_MEM_OUT[104];
    assign MemWrite_mem_in = EXEC_MEM_OUT[105];
    assign loadSign_mem_in = EXEC_MEM_OUT[106];
    assign DSize_mem_in = EXEC_MEM_OUT[107:108];
    assign leapAddr_mem_in = EXEC_MEM_OUT[109:140];
    assign leap_mem_in = EXEC_MEM_OUT[141];
    assign memVal_mem_in = EXEC_MEM_OUT[142:173];
    assign rs2_mem_in = EXEC_MEM_OUT[174:178];
    assign trap_mem = EXEC_MEM_OUT[179];
    
    //floating point stuff
    assign fDestReg_mem_in = EXEC_MEM_OUT[180:184];
    assign fbusW_mem_in = EXEC_MEM_OUT[185:248];
    assign FPRegWrite_mem_in = EXEC_MEM_OUT[249];
    assign mul_mem_in = EXEC_MEM_OUT[250];
    
    //bypassing the memory stage for simplicity (nothing would be done there)
    assign fDestReg_mem_out = fDestReg_mem_in;
    assign fbusW_mem_out = fbusW_mem_in;
    assign FPRegWrite_mem_out = FPRegWrite_mem_in;
    assign mul_mem_out = mul_mem_in;
    
    
    //what we do here:
    ////    get the signals that go to the Memory (MemBus)
    ////    and put those all the way out othe top level pipeline processor
    ////
    
    //this is directly to the input/output of the module, so not as wire
    // wire [0:64] DMEM_BUS_OUT;
    // wire [0:31] DMEM_BUS_IN;
    
    // TOOK THIS OUT AND ADDED TO MEM_EX HAZARD
                //MEM_WB (store) HAZARD
                // wire [0:31] memVal_correct_in;
                
                // mux2to1_32bit STORE_HAZARD_MUX(
                //     .X(memVal_mem_in),
                //     .Y(RegWriteVal_wb_out),
                //     .sel(wb_mem_hazard),
                //     .Z(memVal_correct_in)
                // );
    ///////////////
    
    assign DMEM_BUS_OUT = {aluResult_mem_in,memVal_mem_in,MemWrite_mem_in,DSize_mem_in};

    //result of this
    wire [0:31] dataOut;
    assign dataOut = DMEM_BUS_IN;
    
    
    ////////////////////////////////
    //////
    /////   WIRE IT INTO THE MEM COMPONENT
    /////
    /////
    ///////////////////////////////////
    
    memory_stage MEM_STAGE(
        .clk(clk),
        .reset(reset),
        //inputs
        .nextPC_in(nextPC_mem_in),
        .opB_in(opB_mem_in),
        .destReg_in(destReg_mem_in),
        .aluResult_in(aluResult_mem_in),
        .PCtoReg_in(PCtoReg_mem_in),
        .RegWrite_in(RegWrite_mem_in),
        .MemToReg_in(MemToReg_mem_in),
        .loadSign_in(loadSign_mem_in),
        .DSize_in(DSize_mem_in),
        .dMemValue_in(dataOut),
        // outputs
        .nextPC_out(nextPC_mem_out),
        .destReg_out(destReg_mem_out),
        .aluResult_out(aluResult_mem_out),
        .dataOut_out(dataOut_mem_out),
        .PCtoReg_out(PCtoReg_mem_out),
        .RegWrite_out(RegWrite_mem_out),
        .MemToReg_out(MemToReg_mem_out),
        .loadSign_out(loadSign_mem_out),
        .DSize_out(DSize_mem_out)
    );
    
    /////////////////////////////////////////
    //
    //
    //          MEM_WRITEBACK PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    wire[0:MEM_WB_WIDTH-1] MEM_WB_IN, MEM_WB_OUT;
    
    assign MEM_WB_IN = {
        nextPC_mem_out,destReg_mem_out,
        aluResult_mem_out,dataOut_mem_out,
        PCtoReg_mem_out, RegWrite_mem_out,
        MemToReg_mem_out, loadSign_mem_out,
        DSize_mem_out,
        trap_mem,
        fDestReg_mem_out,fbusW_mem_out,
        FPRegWrite_mem_out,mul_mem_out
    };

    mem_wb_reg #(MEM_WB_WIDTH) MEM_WB_REG(
        .in(MEM_WB_CORRECT_IN),
        .clk(clk),
        .reset(reset),
        .out(MEM_WB_OUT)
    );
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //          WRITE BACK STAGE           //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    //// SIGNALS 
    
    //INPUTS
    wire [0:31] nextPC_wb_in; 
    wire [0:4] destReg_wb_in; 
    // wire [0:31] aluResult_wb_in;
    wire [0:31] dataOut_wb_in; 
    wire PCtoReg_wb_in; 
    wire RegWrite_wb_in;
    wire MemToReg_wb_in;
    wire loadSign_wb_in;
    wire [0:1] DSize_wb_in;
    // OUTPUTS
    wire [0:4] destReg_wb_out;
    wire RegWrite_wb_out;
    
    wire [0:4] fDestReg_wb_in;
    wire [0:63] fbusW_wb_in;
    wire FPRegWrite_wb_in;
    wire mul_wb_in;
    
    assign nextPC_wb_in = MEM_WB_OUT[0:31];
    assign destReg_wb_in = MEM_WB_OUT[32:36];
    assign aluResult_wb_in = MEM_WB_OUT[37:68];
    assign dataOut_wb_in = MEM_WB_OUT[69:100];
    assign PCtoReg_wb_in = MEM_WB_OUT[101];
    assign RegWrite_wb_in = MEM_WB_OUT[102];
    assign MemToReg_wb_in = MEM_WB_OUT[103];
    assign loadSign_wb_in = MEM_WB_OUT[104];
    assign DSize_wb_in = MEM_WB_OUT[105:106];
    assign trap_wb = MEM_WB_OUT[107];
    
    assign fDestReg_wb_in = MEM_WB_OUT[108:112];
    assign fbusW_wb_in = MEM_WB_OUT[113:176];
    assign FPRegWrite_wb_in = MEM_WB_OUT[177];
    assign mul_wb_in = MEM_WB_OUT[178];
        
        
        
    write_back WRITE_BACK_STAGE(
        .nextPC_in(nextPC_wb_in),
        .destReg_in(destReg_wb_in),
        .aluResult_in(aluResult_wb_in),
        .dataOut_in(dataOut_wb_in),
        .PCtoReg_in(PCtoReg_wb_in),
        .RegWrite_in(RegWrite_wb_in),
        .MemToReg_in(MemToReg_wb_in),
        .loadSign_in(loadSign_wb_in),
        .DSize_in(DSize_wb_in),
        // outputs
        .destReg_out(destReg_wb_out),
        .RegWrite_out(RegWrite_wb_out),
        .RegWriteVal_out(RegWriteVal_wb_out)
    );
    
    //now wire the values directly into the register file

    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //          REGISTER FILE              //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    wire [0:31] r1_reg_file,r2_reg_file;
    
    register_file REG_FILE(
            .rd(destReg_wb_out), //destination register number (COMES FROM WB STAGE)
            .ra(r1_id), //source 1 register number (COMES FROM ID STAGE)
            .rb(r2_id), //source 2 register number (COMES FROM ID STAGE)
            .busW(RegWriteVal_wb_out), //value to write into rd (COMES FROM WB STAGE)
            .clk(clk), //clock (GENERAL)
            .writeEnable(RegWrite_wb_out), //1 to write (COMES FROM WB STAGE)
            .reset(reset), //1 for reset (GENERAL)
    
            .busA(r1_reg_file), //value from register ra (GOES TO HAZARD DETECT)
            .busB(r2_reg_file) //value from register rb (GOES TO HAZARD DETECT)
    );
    
    
    wire wb_id_hazard_rs1, wb_id_hazard_rs2;
    wire [0:31] busW;
    assign busW = RegWriteVal_wb_out;
    
    wb_id_hazard WB_ID_HAZARD(
        .rs1_id(r1_id),
        .rs2_id(r2_id),
        .rd_wb(destReg_wb_out),
        .we_wb(RegWrite_wb_out),
        .wb_id_hazard_rs1(wb_id_hazard_rs1),
        .wb_id_hazard_rs2(wb_id_hazard_rs2)
    );
    
    mux2to1_32bit HAZARD_BUS_A_ID(
        .X(r1_reg_file),
        .Y(busW),
        .sel(wb_id_hazard_rs1),
        .Z(reg1_id)
    );
    
    mux2to1_32bit HAZARD_BUS_B_ID(
        .X(r2_reg_file),
        .Y(busW),
        .sel(wb_id_hazard_rs2),
        .Z(reg2_id)
    );
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //         HAZARD DETECTION?           //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    
    /// EX_MEM DATA HAZARD
    
    mem_ex_hazard MEM_EX_HAZARD(
        .regWrite_mem(RegWrite_mem_in),
        .rd_mem(destReg_mem_in),
        .load_mem(MemToReg_mem_in),
        .jumpNonReg_ex(jumpNonReg_ex_in),
        .RType_ex(RType_ex_in),
        .store_ex(MemWrite_ex_in),
        .rs1_ex(r1_ex_in),
        .rs2_ex(r2_ex_in),
        .rs1_hazard(rs1_mem_ex_hazard),
        .rs2_hazard(rs2_mem_ex_hazard),
        .store_hazard(store_mem_ex_hazard)
    );


    wb_ex_hazard WB_EX_HAZARD(
        .regWrite_wb(RegWrite_wb_in),
        .rd_wb(destReg_wb_in),
        // .load_mem(MemToReg_wb_in),
        .jumpNonReg_ex(jumpNonReg_ex_in),
        .RType_ex(RType_ex_in),
        .store_ex(MemWrite_ex_in),
        .rs1_ex(r1_ex_in),
        .rs2_ex(r2_ex_in),
        .rs1_hazard(rs1_wb_ex_hazard),
        .rs2_hazard(rs2_wb_ex_hazard),
        .store_hazard(store_wb_ex_hazard)
    );
    
    load_stall LOAD_STALL(
        .MemToReg_id(MemToReg_id),
        .rd_id(destReg_id),
        .instruction_if(instruction_if_out),
        .stall(load_stall_id_if)
    );
    
    // wb_mem_hazard WB_MEM_HAZARD(
    //     .regWrite_wb(RegWrite_wb_in),
    //     .rd_wb(destReg_wb_in),
    //     .store_mem(MemWrite_mem_in),
    //     .rs_mem(rs2_mem_in),
    //     .store_hazard(wb_mem_hazard)
    // );


    //////////////////////////////////
    /////
    ////
    /////   MULTIPLY AND STALL LOGIC 
    ////
    ////
    ////
    /////////////////////////////////
    
    ////MUXES TO THE CORRECT INPUT AT REGISTERS

    mux2to1_nbit #(64) MUX_IF_ID(
        .X(IF_ID_IN),
        .Y(IF_ID_OUT),
        .sel(stall_ex_out),
        .Z(IF_ID_CORRECT_IN)
    );

    mux2to1_nbit #(ID_EXEC_WIDTH) MUX_ID_EXEC(
        .X(ID_EXEC_IN),
        .Y(ID_EXEC_OUT),
        .sel(stall_ex_out),
        .Z(ID_EXEC_CORRECT_IN)
    );

    mux2to1_nbit #(EXEC_MEM_WIDTH) MUX_EXEC_MEM(
        .X(EXEC_MEM_IN),
        .Y(EXEC_MEM_OUT),
        .sel(stall_ex_out),
        .Z(EXEC_MEM_CORRECT_IN)
    );

    mux2to1_nbit #(MEM_WB_WIDTH) MUX_MEM_WB(
        .X(MEM_WB_IN),
        .Y(MEM_WB_OUT),
        .sel(stall_ex_out),
        .Z(MEM_WB_CORRECT_IN)
    );


endmodule