module testbench;
    reg [0:31] A;
    reg [0:31] B;
    wire seq, sne, sle, slt, sge, sgt;

    setter SETTER(.A(A),.B(B),.seq(seq),.sne(sne),.sle(sle),.slt(slt),.sge(sge),.sgt(sgt));
    
    initial begin
        $monitor("A=%h B=%h seq=%b sne=%b sle=%b slt=%b sge=%b sgt=%b",A,B,seq,sne,sle,slt,sge,sgt);

        #0 A = 32'h00000022; B = 32'h00000022; 
        #1 A = 32'h00000022; B = 32'h00000021;
        #1 A = 32'h00000022; B = 32'h000A0021;
        #1 A = 32'hA0000022; B = 32'h00000021;
        #1 A = 32'h7FFFFFFF; B = 32'hFFFFFFFF;
        #1 A = 32'hFFFFFFFF; B = 32'h7FFFFFFF;
    end
endmodule // testbench

