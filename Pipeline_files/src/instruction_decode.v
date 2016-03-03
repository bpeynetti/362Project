module instruction_decode(
    parameter SIZE = 32;
    //input ports 
    nextPC_in, instruction_in,
    clk,reset,
    busA_in,busB_in,
    //output ports
    nextPC_out, 
    PCtoReg_out,
    RegToPC_out,
    jump_out,
    branch_out,
    branchZero_out,
    RType_out,
    RegWrite_out,
    MemToReg_out,
    MemWrite_out,
    loadSign_out,
    mul_out,
    extOp_out,
    LHIOp_out,
    DSize_out,
    ALUCtrl_out
    );
    
    //inputs 
    input [0:SIZE-1] nextPC_in,instruction_in,busA_in,busB_in;
    input clk,reset;
    
    //outputs 
    output [0:SIZE-1] nextPC_out;
    output PCtoReg_out,RegToPC_out,jump_out,branch_out,branchZero_out;
    output RType_out,RegWrite_out,MemToReg_out,MemWrite_out,
    output loadSign_out,mul_out,extOp_out,LHIOp_out;
    output [0:1] DSize_out;
    output [0:3] ALUCtrl_out;
    
    //what happens in here:
    
    //instruction and nextPC come as inputs
    // register file output comes in here for processing
    // //we perform the MUX with Imm16, sign extenders, and other muxes to determine 
    //      what signals go directly into the ALU
    
    
    ////////////////////////////
    ////
    ////
    ////    ALL SIGNALS THAT GET IGNORED AND SIMPLY PASSED ALONG IN=OUT
    ////
    ////////////////////////////
    
    
    
    ////////////////////////////
    //////
    //////
    /////       CONTROL SIGNALS  
    /////
    /////
    /////////////////////////////
    
    control CONTROL_ID_STAGE(
        .instruction(instruction_in),
        .PCtoReg_out
    
    
    
    );
    
    /////////////////////////
    /////
    ////
    ////    FIGURE OUT ALU inputs A and B
    ////
    /////////////////////////
    
    
    
endmodule