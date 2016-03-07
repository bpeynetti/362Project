module id_ex_reg(in, out, clk, reset);
    parameter width = 192;
    input [0:width-1] in;
    input clk,reset;
    output [0:width-1] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:31] opA = in[32:63];
    wire [0:31] opB = in[64:95];
    wire [0:25] offset_26 = in[96:121]; 
    wire [0:15] offset_16 = in[122:137];
    // wire [0:5] opCode = in[138:143];
    wire [0:4] destReg = in[138:142];
    wire PCtoReg = in[143];
    wire RegToPC = in[144];
    wire jump = in[145];
    wire branch = in[146];
    wire branchZero = in[147];
    wire RType = in[148];
    wire RegWrite = in[149];
    wire MemToReg = in[150];
    wire MemWrite = in[151];
    wire loadSign = in[152];
    wire mul = in[153];
    wire [0:1] DSize = in[154:155];
    wire [0:3] ALUCtrl = in[156:159];
    wire [0:31] memVal = in[160:191];
    
    PipeCtlRegN #(width) ID_EX_REG (
        .in(in),
        .ctl(1'b0),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule