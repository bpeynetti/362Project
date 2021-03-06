module if_id_reg(in, flush, out, clk, reset,we);
    parameter width = 64;
    input [0:width-1] in;
    input flush;
    input clk,reset,we;
    output [0:width-1] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:31] instruction = in[32:63];
    // wire PCtoReg = in[64];
    // wire RegToPC = in[65];
    // wire jump = in[66];
    // wire branch = in[67];
    // wire branchZero = in[68];
    // wire RType = in[69];
    // wire RegWrite = in[70];
    // wire MemToReg = in[71];
    // wire MemWrite = in[72];
    // wire loadSign = in[73];
    // wire mul = in[74];
    // wire extOp = in[75];
    // wire LHIOp = in[76];
    // wire [0:1] DSize = in[77:78];
    // wire [0:3] ALUCtrl = in[79:82];
    
    PipeCtlRegN1 #(width) IF_ID_REG (
        .in(in),
        .ctl(flush),
        .we(~we),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
    
endmodule