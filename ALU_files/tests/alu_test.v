module testbench;
    
    reg [0:31] A, B;
    reg [0:3] ctrl;
    wire [0:31] ALUout,correctOut,of;
    wire zero,correctZero;

    
    alu ALU(A, B, ctrl, ALUout, zero,of);
    
    initial begin
        $monitor("%h,%h,%b,%h,%h", A,B,ctrl,ALUout,zero,of);
        
        #0 A=32'h00000000; B=32'h00000001; ctrl=32'b0000;  
        #1 A=32'h00000001; B=32'h00000001; ctrl=32'b0001;
        #1 A=32'h12341234; B=32'h11111111; ctrl=32'b0001;
        #1 A=32'h12341234; B=32'h11111111; ctrl=32'b0001;
        #1 A=32'hF2341234; B=32'h01111111; ctrl=32'b0000;
        #1 A=32'h10101010; B=32'h00000004; ctrl=32'b0111; //sra
        #1 A=32'hf0101010; B=32'h00000004; ctrl=32'b0111;
        #1 A=32'h10101010; B=32'h00000004; ctrl=32'b1010; //srl
        #1 A=32'hf0101010; B=32'h00000004; ctrl=32'b1010;
        #1 A=32'h10101010; B=32'h00000004; ctrl=32'b1001; //sll
        #1 A=32'hf0101010; B=32'h00000004; ctrl=32'b1001;
        #1 A=32'h01010101; B=32'h20202020; ctrl=32'b1101; //and
        #1 A=32'hf0f0f0f0; B=32'h20202020; ctrl=32'b1101;
        #1 A=32'h01010101; B=32'hffffffff; ctrl=32'b1101;
        #1 A=32'h12341234; B=32'hffffffff; ctrl=32'b1110; //or
        #1 A=32'h43214321; B=32'h00000000; ctrl=32'b1110;
        #1 A=32'h01010101; B=32'h12341234; ctrl=32'b1110;
        #1 A=32'h12341234; B=32'hffffffff; ctrl=32'b1110; //xor
        #1 A=32'h43214321; B=32'h00000000; ctrl=32'b1110;
        #1 A=32'h12121212; B=32'h12121212; ctrl=32'b1110;
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b1011; //seq
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b1011;
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b1100; //sne
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b1100;
        //slt 
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b0010;
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b0010;        
        //sle 
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b0011;
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b0011;       
        //sgt 
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b0100;
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b0100;
        //sge 
        #1 A=32'h12341234; B=32'h12341234; ctrl=32'b0101;
        #1 A=32'hffffffff; B=32'h00000001; ctrl=32'b0101;
        //

    end
endmodule
