module ex_mem_reg(in, out,clk, reset);

    parameter width = 142;
    input [0:(width-1)] in;
    input clk,reset;
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
    
    wire flush;
    assign flush = 1'b0;
    
    PipeCtlRegN #(width) EX_MEM_REG(
        .in(in),
        .ctl(1'b0),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule