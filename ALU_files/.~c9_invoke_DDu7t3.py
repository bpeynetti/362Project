import random

fileName = "ALU_test.v"

txt = """module testbench;
    
    reg [0:31] A, B;
    reg [0:3] ctrl;
    wire [0:31] ALUout;
    wire zero;
    
    alu ALU((A, B, ctrl, ALUout, zero);
    
    initial begin
        $monitor("A=%h, B=%h, ctrl=%h, ALUout=%h, zero=%h",A,B,ctrl,ALUout,zero);
"""
tabs = 2



for i in range(100):
    
    bit32 = pow(2,32)-1
    bit4 = pow(2,4)-1
    
    A = hex(random.randrange(bit32))[2:]
    A = '0'*(8-len(A)) + A
    B = hex(random.randrange(bit32))[2:]
    B = '0'*(8-len(B)) + B
    ctrl = bin(random.randrange(bit4))[2:]
    ctrl = '0'*(4-len(ctrl)) + ctrl
    
    
#    print A,B,ctrl
    if (i==0):
        txt+= '\n'+'\t'*tabs+"#0 A=32'h"+A+"; B=32'h"+B+"; ctrl=32'b"+ctrl+";"
    else:
        txt+= '\n'+'\t'*tabs+"#1 A=32'h"+A+"; B=32'h"+B+"; ctrl=32'b"+ctrl+";"
    
txt+= '\n'
    
    



txt += """
    end
endmodule //testbench """


print txt










































p