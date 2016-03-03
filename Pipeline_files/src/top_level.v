module pipeline_processor(clk,reset,DMEM_BUS_OUT,DMEM_BUS_IN,IMEM_BUS_OUT,IMEM_BUS_IN);

    parameter DMEM_BUS_OUT_SIZE = 65; //this is the input of the memory stage
    parameter DMEM_BUS_IN_SIZE = 32;
    parameter IMEM_BUS_OUT_SIZE = 32;
    parameter IMEM_BUS_IN_SIZE = 32;
    
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
    
    
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       INSTRUCTION FETCH STAGE       //
    //                                     //
    //                                     //
    /////////////////////////////////////////

    //// SIGNALS 


    /////////////////////////////////////////
    //
    //
    //          IF_ID PIPELINE REGISTER
    //
    /////////////////////////////////////////


    wire [0:64] IF_ID_IN,IF_ID_OUT;
    
    assign IF_ID = {
    
    };
    
    
    if_id_reg IF_ID_REG(
        .in(IF_ID_IN),
        .out(IF_ID_OUT),
        .clk(clk),
        .rst(rst),
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
    wire [0:31] nextPC_id, instruction_id;
    assign nextPC_id_in = IF_ID_OUT[0:31];
    assign instruction_id = IF_ID_OUT[32:63];
    
    //these go into the register file (and out of)
    wire [0:4] r1_id,r2_id; 
    wire [0:31] reg1_id,reg2_id; 
    
    assign r1_id = instruction_id[6:10];
    assign r2_id = instruction_id[11:15];

    //these go in and out of the ID stage
    
    wire [0:31] nextPC_id_out;
    wire [0:31] opA_id;
    wire [0:31] opB_id;
    wire [0:25] offset_26_id;
    wire [0:15] offset_16_id;
    wire [0:5] opCode_id;
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
    
    
    
    //here goes the ID module with all its components inside of it
    instruction_decode ID_STAGE(
        .nextPC_in(nextPC_id),
        .instruction_in(instruction_id),
        .clk(clk),
        .reset(reset),
        .busA_in(reg1_id),
        .busB_in(reg2_id),
        //output
        .nextPC_out(nextPC_id_out),
        .PCtoReg_out(PCtoReg_id),
        .RegToPC_out(RegToPC_out),
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
        .destReg(destReg_id)
    );
    
    

    /////////////////////////////////////////
    //
    //
    //          ID_EXEC PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    //wire out of this stage to connecto to pipeline registers
    wire [0:165] ID_EXEC_IN,ID_EXEC_OUT;
    assign ID_EXEC_IN = 
    {
            nextPC_id,
            opA_id,opB_id, offset_16_id, offset_26_id,
            opCode_id,destReg_id,
            PCtoReg_id, RegToPC_id,
            jump_id, branch_id,
            branchZero_id, RType_id, 
            RegWrite_id, MemToReg_id, 
            MemWrite_id, loadSign_id, 
            mul_id, DSize_id, ALUCtrl_id
    };
    
            
    id_ex_reg ID_EX_REG(
        .in(ID_EXEC_IN),
        .clk(clk),
        .reset(reset),
        .out(ID_EXEC_OUT)
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
    wire [0:5] opCode_ex_in;
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
    
    
    //output signals of the execute stage
    wire [0:31] nextPC_ex_out;
    wire [0:31] aluResult_ex_out;
    wire [0:31] leapAddr_ex_out;
    wire [0:4] destReg_ex_out;
    wire leap_ex_out;
    wire PCtoReg_ex_out;
    wire RegToPC_ex_out;
    wire jump_ex_out;
    wire branch_ex_out;
    wire branchZero_ex_out;
    wire RegWrite_ex_out;
    wire MemToReg_ex_out;
    wire MemWrite_ex_out;
    wire loadSign_ex_out;
    wire [0:1] DSize_ex_out;
    
    
    assign [0:31] nextPC_ex_in = ID_EXEC_OUT[0:31];
    assign [0:31] opA_ex_in = ID_EXEC_OUT[32:63];
    assign [0:31] opB_ex_in = ID_EXEC_OUT[64:95];
    assign [0:25] offset_26_ex_in = ID_EXEC_OUT[96:121];
    assign [0:15] offset_16_ex_in = ID_EXEC_OUT[122:137];
    assign [0:5] opCode_ex_in = ID_EXEC_OUT[138:143];
    assign [0:4] destReg_ex_in = ID_EXEC_OUT[144:148];
    assign PCtoReg_ex_in = ID_EXEC_OUT[149];
    assign RegToPC_ex_in = ID_EXEC_OUT[150];
    assign jump_ex_in = ID_EXEC_OUT[151];
    assign branch_ex_in = ID_EXEC_OUT[152];
    assign branchZero_ex_in = ID_EXEC_OUT[153];
    assign RType_ex_in = ID_EXEC_OUT[154];
    assign RegWrite_ex_in = ID_EXEC_OUT[155];
    assign MemToReg_ex_in = ID_EXEC_OUT[156];
    assign MemWrite_ex_in = ID_EXEC_OUT[157];
    assign loadSign_ex_in = ID_EXEC_OUT[158];
    assign mul_ex_in = ID_EXEC_OUT[159];
    assign [0:1] DSize_ex_in = ID_EXEC_OUT[160:161];
    assign [0:3] ALUCtrl_ex_in = ID_EXEC_OUT[162:165];



    execute EXEC_STAGE(
        //inputs 
        .clk(clk),
        .reset(reset),
        .nextPC_in(nextPC_ex_in),
        .opA_in(opA_ex_in),
        .opB_in(opB_ex_in),
        .offset_26_in(offset_26_ex_in),
        .offset_16_in(offset_16_ex_in),
        // .opCode(opCode_ex_in),
        .destReg(destReg_ex_in),
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
        .DSize_out(DSize_ex_out)
    );
    
    wire [0:31] opB_ex_out;
    assign opB_ex_out = opB_ex_in;
    
    /////////////////////////////////////////
    //
    //
    //          EXEC_MEM PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    
    wire [0:111] EXEC_MEM_IN,EXEC_MEM_OUT;
    assign EXEC_MEM_IN = 
    {
           nextPC_ex_out,opB_ex_out,
           destReg_ex_out,aluResult_ex_out,
           PCtoReg_ex_out,RegToPC_ex_out,
           RegWrite_ex_out,MemToReg_ex_out,
           MemWrite_ex_out,loadSign_ex_out,
           DSize_ex_out
    };
    
            
    id_ex_reg EX_MEM_REGISTER(
        .in(EXEC_MEM_IN),
        .clk(clk),
        .reset(reset),
        .out(EXEC_MEM_OUT)
    );
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       MEMORY            STAGE       //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    
    
    //// SIGNALS 


    //DECLARATIONS
    wire [0:31] nextPC_mem_in;
    wire [0:31] opB_mem_in;
    wire [0:4] destReg_mem_in;
    wire [0:31] aluResult_mem_in;
    wire PCtoReg_mem_in;
    wire RegToPC_mem_in;
    wire RegWrite_mem_in;
    wire MemToReg_mem_in;
    wire MemWrite_mem_in;
    wire loadSign_mem_in;
    wire [0:1] DSize_mem_in;
    
    //get signals out of the register file
    wire [0:31] nextPC_mem_in = EXEC_MEM_OUT[0:31];
    wire [0:31] opB_mem_in = EXEC_MEM_OUT[32:63];
    wire [0:4] destReg_mem_in = EXEC_MEM_OUT[64:68];
    wire [0:31] aluResult_mem_in = EXEC_MEM_OUT[69:100]
    wire PCtoReg_mem_in = EXEC_MEM_OUT[101];
    wire RegToPC_mem_in = EXEC_MEM_OUT[102];
    wire RegWrite_mem_in = EXEC_MEM_OUT[103];
    wire MemToReg_mem_in = EXEC_MEM_OUT[104];
    wire MemWrite_mem_in = EXEC_MEM_OUT[105];
    wire loadSign_mem_in = EXEC_MEM_OUT[106];
    wire [0:1] DSize_mem_in = EXEC_MEM_OUT[107:108];
    
    //what we do here:
    ////    get the signals that go to the Memory (MemBus)
    ////    and put those all the way out othe top level pipeline processor
    ////
    wire [0:64] DMEM_BUS_OUT;
    wire [0:31] DMEM_BUS_IN;
    assign DMEM_BUS_OUT = {aluResult_mem_in,opB_mem_in,MemWrite_mem_in};

    //result of this
    assign dataOut = DMEM_BUS_IN;
    
    
    
    ////////////////////////////////
    //////
    /////   WIRE IT INTO THE MEM COMPONENT
    /////
    /////
    ///////////////////////////////////
    
    
    
    /////////////////////////////////////////
    //
    //
    //          MEM_WRITEBACK PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //          WRITE BACK STAGE           //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    //// SIGNALS 

    
    
    
    
    
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //          REGISTER FILE              //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    
    register_file REG_FILE(
            .rd(rd_wb), //destination register number (COMES FROM WB STAGE)
            .ra(r1_id), //source 1 register number (COMES FROM ID STAGE)
            .rb(r2_id), //source 2 register number (COMES FROM ID STAGE)
            .busW(busW_wb), //value to write into rd (COMES FROM WB STAGE)
            .clk(clk), //clock (GENERAL)
            .writeEnable(WriteReg_wb), //1 to write (COMES FROM WB STAGE)
            .reset(reset), //1 for reset (GENERAL)
    
            .busA(reg1_id), //value from register ra (GOES TO ID STAGE)
            .busB(reg2_id) //value from register rb (GOES TO ID STAGE)
    );
    
    
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //         HAZARD DETECTION?           //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    