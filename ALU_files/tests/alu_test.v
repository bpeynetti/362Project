module testbench;
    
    reg [0:31] A, B;
    reg [0:3] ctrl;
    wire [0:31] ALUout;
    wire zero;

    
    alu ALU(A, B, ctrl, ALUout, zero);
    
    initial begin
        $monitor("A=%h B=%h ctrl=%h ALUout=%h ", A,B,ctrl,ALUout);
        
        #0 A=32'h00000000; B=32'h00000001; ctrl=32'b0000; 
        #1 A=32'h00000000; B=32'h00000001; ctrl=32'b0001;
        #1 A=32'h00000000; B=32'h00000001; ctrl=32'b0000;
        #1 A=32'h00000000; B=32'h00000001; ctrl=32'b0000;
        #1 A=32'h00000000; B=32'h00000001; ctrl=32'b0000;

    end
endmodule
