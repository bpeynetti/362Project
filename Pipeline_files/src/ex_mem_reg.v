module ex_mem_reg(in, out clk, reset);
    parameter width = 112;
    input [0:width-1] in;
    output [0:width-1] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:31] opB = in[32:63];
    wire [0:4] destReg = in[64:68];
    wire [0:31] aluResult = in[69:100]
    wire PCtoReg = in[101];
    wire RegToPC = in[102];
    wire RegWrite = in[103];
    wire MemToReg = in[104];
    wire MemWrite = in[105];
    wire loadSign = in[106];
    wire [0:1] DSize = in[107:108];
    
    PipeCtlRegN #(width) (
        .in(in),
        .ctl(flush),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule