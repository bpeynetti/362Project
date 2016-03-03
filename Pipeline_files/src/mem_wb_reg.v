module mem_wb_reg(in, out,clk,reset);
    parameter width = 72;
    input [0:width-1] in;
    input clk, rst;
    output [0:width-1] out;
    
    wire [0:4] destReg = in[0:4];
    wire [0:31] aluResult = in[5:36];
    wire [0:31] dataOut = in[37:68];
    wire PCtoReg = in[69];
    wire RegWrite = in[70];
    wire MemToReg = in[71];
    
    PipeCtlRegN #(72) (
        .in(in),
        .ctl(flush),
        .clk(clk),
        .reset(reset),
        .out(out)
    );
    
endmodule