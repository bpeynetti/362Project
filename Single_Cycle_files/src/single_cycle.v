// --------------------
// Single Cycle processor file
// EECS 362 
// --------------------


module single_cycle(clk,busWout,instructionOut);
    parameter WIDTH=32;
    //only input is the clock
    input clk;
    
    //output (for testing purposes) is busW and instruction
    output [0:(WIDTH-1)] busW,instruction;
    
    // all intermediate signals
    
    //pc logic related
    wire [0:(WIDTH-1)] alu_out;
    wire [0:15] imm16;
    wire [0:25] imm26;
    wire [0:(WIDTH-1)] instructionAddr;
    wire [0:(WIDTH-1)] instruction;
    
    
    //control signals
    
    
    
    //out of reg file
    wire [0:(WIDTH-1)] regA,regB;
    
    
    //into ALU and execution stage
    wire [0:(WIDTH-1)] aluA,aluB;
    wire [0:(WIDTH-1)] extender
    

    
    
    //pc logic
    pc_logic(
        .imm16(imm16),
        .imm26(imm26),
        .alu_out(alu_out),
        .reg_out(reg_out),
        .branch(branch),
        .branchOrJmp(branchOrJmp),
        .regToPC(regToPC),
        .clk(clk),
        .reset(reset),
        .instruction(instructionAddr)
    );
        
    
    
    //wiring pclogic to instruction memory
    
    


endmodule;