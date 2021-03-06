module ex_mem_reg (in, flush, out,clk, reset,we);

    parameter width=283;
    input [0:(width-1)] in;
    input flush;
    input clk,reset,we;
    output [0:(width-1)] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:31] opB = in[32:63];
    wire [0:4] destReg = in[64:68];
    wire [0:31] aluResult = in[69:100];
    wire PCtoReg = in[101];
    wire RegToPC = in[102]; //not needed?
    wire RegWrite = in[103];
    wire MemToReg = in[104];
    wire MemWrite = in[105];
    wire loadSign = in[106];
    wire [0:1] DSize = in[107:108];
    wire [0:31] leapAddr = in[109:140];
    wire leap = in[141];
    wire [0:31] memVal = in[142:173];
    wire [0:4] rs2 = in[174:178];
    wire trap = in[179];
    wire [0:4] fDestReg = in[180:184];
    wire [0:63] fbusW = in[185:248];
    wire FPRegWrite = in[249];
    wire mul = in[250];
    wire opA = in[251:282];

    
    // wire flush;
    // assign flush = 1'b0;
    
    PipeCtlRegN1 #(width) EX_MEM_REG(
        .in(in),
        .ctl(flush),
        .we(~we),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule