module pipeline_processor(clk,reset);

    input clk,reset;
    
    
    
    
    
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
        .ALUCtrl_out(ALUCtrl_id)
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

    
    /////////////////////////////////////////
    //
    //
    //          EXEC_MEM PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    
    /////////////////////////////////////////
    //                                     //
    //                                     //
    //       MEMORY            STAGE       //
    //                                     //
    //                                     //
    /////////////////////////////////////////
    
    
    
    //// SIGNALS 



    
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
    