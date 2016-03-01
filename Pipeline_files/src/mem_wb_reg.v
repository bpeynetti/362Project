module mem_wb_reg(in, out);
    parameter width = 72;
    input [0:width-1] in;
    output [0:width-1] out;
    
    wire [0:4] destReg = in[0:4];
    wire [0:31] aluResult = in[5:36];
    wire [0:31] dataOut = in[37:68];
    wire PCtoReg = in[69];
    wire RegWrite = in[70];
    wire MemToReg = in[71];
    
    
    
endmodule