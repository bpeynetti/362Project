
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
    
    //  {aluResult_mem_in,opB_mem_in,MemWrite_mem_in,DSize_mem_in};
    assign dmem_addr = BUS_PIPE_TO_DMEM[0:31];
    assign dmem_write = BUS_PIPE_TO_DMEM[32:63];
    assign dmem_writeEnable = BUS_PIPE_TO_DMEM[64];
    assign dmem_dSize = BUS_PIPE_TO_DMEM[65:66];
    assign BUS_DMEM_TO_PIPE = dmem_read;
    
    
    wire [0:31] imem_addr,imem_out;
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
    wire [0:31] pcplus4_if_out, instruction_if_out;
    wire [0:31] pc_out;
    ///////
    ///     GO TO IMEM BY SETTING IMEM_BUS IN/OUT
    assign IMEM_BUS_OUT = pc_out;
    
    wire leap_mem_in;
    wire [0:31] leapAddr_mem_in;
    
    //// wire the IF_STAGE
    instruction_fetch IF_STAGE(
        .leap_addr(leapAddr_mem_in),
        .leap(leap_mem_in),
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
    
    if_id_reg IF_ID_REG(
        .in(IF_ID_IN),
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
    assign nextPC_id_in = IF_ID_OUT[0:31];
    assign instruction_id_in = IF_ID_OUT[32:63];
    
    //these go into the register file (and out of)
    wire [0:4] r1_id,r2_id; 
    wire [0:31] reg1_id,reg2_id; 
    
    assign r1_id = instruction_id_in[6:10];
    assign r2_id = instruction_id_in[11:15];

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
        .destReg(destReg_id)
    );
    
    
    /////////////////////////////////////////
    //
    //
    //          ID_EXEC PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    //wire out of this stage to connecto to pipeline registers
    wire [0:159] ID_EXEC_IN,ID_EXEC_OUT;
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
    
    
    //output signals of the execute stage
    // wire [0:31] nextPC_ex_out;
    wire [0:31] aluResult_ex_out;
    wire [0:31] leapAddr_ex_out;
    wire [0:4] destReg_ex_out;
    wire leap_ex_out;
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
    
    
    assign nextPC_ex_in = ID_EXEC_OUT[0:31];
    assign opA_ex_in = ID_EXEC_OUT[32:63];
    assign opB_ex_in = ID_EXEC_OUT[64:95];
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
        // .jump_in(jump_ex_in),
        // .branch_in(branch_ex_in),
        // .branchZero_in(branchZero_ex_in),
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
        .DSize_out(DSize_ex_out),
        .leap_out(leap_ex_out)
    );
    
    wire [0:31] opB_ex_out;
    assign opB_ex_out = opB_ex_in;
    
    /////////////////////////////////////////
    //
    //
    //          EXEC_MEM PIPELINE REGISTER
    //
    /////////////////////////////////////////
    
    
    wire [0:141] EXEC_MEM_IN,EXEC_MEM_OUT;
    assign EXEC_MEM_IN = 
    {
           nextPC_ex_out,opB_ex_out,
           destReg_ex_out,aluResult_ex_out,
           PCtoReg_ex_out,RegToPC_ex_out,
           RegWrite_ex_out,MemToReg_ex_out,
           MemWrite_ex_out,loadSign_ex_out,
           DSize_ex_out,
           leapAddr_ex_out, leap_ex_out
    };
    
    ex_mem_reg EX_MEM_REGISTER(
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
    ///
    /// SIGNALS THAT GO TO THE IF STAGE -> LEAP_ADDR and LEAP

    assign leapAddr_mem_in = EXEC_MEM_OUT[109:140];
    assign leap_mem_in = EXEC_MEM_OUT[141];


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
    
    //outputs of MEMORY stage
    wire [0:31] nextPC_mem_out;
    wire [0:4] destReg_mem_out;
    wire [0:31] aluResult_mem_out;
    wire [0:31] dataOut_mem_out;
    wire PCtoReg_mem_out, RegToPC_mem_out, RegWrite_mem_out, MemToReg_mem_out;
    wire loadSign_mem_out;
    wire [0:1] DSize_mem_out;
    
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
    
    //what we do here:
    ////    get the signals that go to the Memory (MemBus)
    ////    and put those all the way out othe top level pipeline processor
    ////
    
    //this is directly to the input/output of the module, so not as wire
    // wire [0:64] DMEM_BUS_OUT;
    // wire [0:31] DMEM_BUS_IN;
    assign DMEM_BUS_OUT = {aluResult_mem_in,opB_mem_in,MemWrite_mem_in,DSize_mem_in};

    //result of this
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
        .dMemValue_in(data_out),
        // outputs
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
    
    wire[0:106] MEM_WB_IN, MEM_WB_OUT;
    
    assign MEM_WB_IN = {
        nextPC_mem_out,destReg_mem_out,
        aluResult_mem_out,dataOut_mem_out,
        PCtoReg_mem_out, RegWrite_mem_out,
        MemToReg_mem_out, loadSign_mem_out,
        DSize_mem_out
    };
    
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
    wire [0:31] aluResult_wb_in;
    wire [0:31] dataOut_wb_in; 
    wire PCtoReg_wb_in; 
    wire RegWrite_wb_in;
    wire MemToReg_wb_in;
    wire loadSign_wb_in;
    wire [0:1] DSize_wb_in;
    // OUTPUTS
    wire [0:4] destReg_wb_out;
    wire RegWrite_wb_out;
    wire [0:31] RegWriteVal_wb_out;
    
    assign nextPC_wb_in = MEM_WB_OUT[0:31];
    assign destReg_wb_in = MEM_WB_OUT[32:36];
    assign aluResult_wb_in = MEM_WB_OUT[37:68];
    assign dataOut_wb_in = MEM_WB_OUT[69:100];
    assign PCtoReg_wb_in = MEM_WB_OUT[101];
    assign RegWrite_wb_in = MEM_WB_OUT[102];
    assign MemToReg_wb_in = MEM_WB_OUT[103];
    assign loadSign_wb_in = MEM_WB_OUT[104];
    assign DSize_wb_in = MEM_WB_OUT[105:106];

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
    
    
    register_file REG_FILE(
            .rd(destReg_wb_out), //destination register number (COMES FROM WB STAGE)
            .ra(r1_id), //source 1 register number (COMES FROM ID STAGE)
            .rb(r2_id), //source 2 register number (COMES FROM ID STAGE)
            .busW(RegWriteVal_wb_out), //value to write into rd (COMES FROM WB STAGE)
            .clk(clk), //clock (GENERAL)
            .writeEnable(RegWrite_wb_out), //1 to write (COMES FROM WB STAGE)
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
    
endmodule