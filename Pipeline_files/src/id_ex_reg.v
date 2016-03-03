module id_ex_reg(in, out, clk, reset);
    parameter width = 166;
    input [0:width-1] in;
    output [0:width-1] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:31] opA = in[32:63];
    wire [0:31] opB = in[64:95];
    wire [0:25] offset_26 = in[96:121];
    wire [0:15] offset_16 = in[122:137];
    wire [0:5] opCode = in[138:143];
    wire [0:4] destReg = in[144:148];
    wire PCtoReg = in[149];
    wire RegToPC = in[150];
    wire jump = in[151];
    wire branch = in[152];
    wire branchZero = in[153];
    wire RType = in[154];
    wire RegWrite = in[155];
    wire MemToReg = in[156];
    wire MemWrite = in[157];
    wire loadSign = in[158];
    wire mul = in[159];
    wire [0:1] DSize = in[160:161];
    wire [0:3] ALUCtrl = in[162:165];
    
    PipeCtlRegN #(166) (
        .in(in),
        .ctl(flush),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule