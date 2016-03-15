module id_ex_reg (in, flush, out, clk, reset);

    parameter width=277;
    input [0:width-1] in;
    input flush;
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
    wire jumpNonReg = in[192];
    wire [0:4] r1 = in[193:197];
    wire [0:4] r2 = in[198:202];
    wire trap = in[203];
    wire [0:31] f1 = in[204:235];
    wire [0:31] f2 = in[236:267];
    wire [0:4] fDestReg = in[268:272];
    wire fprtype = in[273];
    wire fpregwrite = in[274];
    wire movfp2i = in[275];
    wire movi2fp = in[276];
    
    
    PipeCtlRegN #(width) ID_EX_REG (
        .in(in),
        .ctl(flush),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule