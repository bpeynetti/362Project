module mem_wb_reg (in, flush, out,clk,reset);
    
    parameter width=179;
    input [0:width-1] in;
    input flush;
    input clk, reset;
    output [0:width-1] out;
    
    wire [0:31] nextPC = in[0:31];
    wire [0:4] destReg = in[32:36];
    wire [0:31] aluResult = in[37:68];
    wire [0:31] dataOut = in[69:100];
    wire PCtoReg = in[101];
    wire RegWrite = in[102];
    wire MemToReg = in[103];
    wire loadSign = in[104];
    wire [0:1] DSize = in[105:106];
    wire trap = in[107];
    wire [0:4] fDestReg = in[108:112];
    wire [0:63] fbusW = in[113:176];
    wire FPRegWrite = in[177];
    wire mul = in[178];
    
    PipeCtlRegN #(width) MEM_WB_REG(
        .in(in),
        .ctl(1'b0),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule