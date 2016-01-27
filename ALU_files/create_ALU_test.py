
fileName = "ALU_test.v"

txt = """module testbench;
    
    reg [0:31] A, B;
    reg [0:3] ctrl;
    wire [0:31] ALUout;
    wire zero;
    wire [0:31] correct_out;
    wire correct_zero;
    
    .alu ALU((A, B, ctrl, ALUout, zero);
    
    initial begin
        $monitor("A=%h B=%h ctrl=%h ALUout=%h correct_out=%h correct_zero=%h", A,B,ctrl,ALUout,correct_out,zero,correct_zero);
"""
tabs = 3;


def function(A,B,fn,out):
    
    #shamt = can only shift by 5 bits
    #convert to hex
    #then convert to 
    
    if (fn=='add'):
        return A+B
    if (fn=='sub'):
        return A-B
    if (fn=='sll'):
        
    
    
    
    
ctrl = {}
ctrl['add'] = 0
ctrl['sub'] = 1
ctrl['sll'] = 9
ctrl['srl'] = 10
ctrl['sra'] = 7
ctrl['seq'] = 11
ctrl['sne'] = 12
ctrl['sle'] = 3
ctrl['slt'] = 2
ctrl['sge'] = 5
ctrl['sgt'] = 4
ctrl['and'] = 13
ctrl['or']  = 14
ctrl['xor'] = 15



    
    



txt += """
    end
endmodule //testbench """
