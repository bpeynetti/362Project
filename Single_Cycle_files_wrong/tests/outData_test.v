module testbench;

    reg [0:31] rawMemOut;
    reg [0:1] DSize;
    reg loadSign;
    
    wire [0:31] dataOut;
    
    outData TEST_WIRE(
        .rawMemOut(rawMemOut),
        .DSize(DSize),
        .loadSign(loadSign),
        .dataOut(dataOut)
    );
    
    initial
    begin
    
        //set all as 0 at start of test
        rawMemOut = 32'h0;
        DSize = 2'd0;
        loadSign = 1'b0;
        
        #1;
        rawMemOut = 32'hf1234567;
        
        #1;
        //flip sign
        loadSign = 1'b1;
        
        #1;
        //load half
        loadSign = 1'b0;
        DSize = 2'd1;
        
        #1;
        //flip sign
        loadSign = 1'b1;
        #1;
        
        //load word
        loadSign = ~loadSign;
        DSize = 2'd3;
        #1;
        //flip sign 
        loadSign = ~loadSign;
        #1;
        
        
        
    end
    
    initial 
    begin
        $monitor("rawMemOut=%h DSize=%h loadSign=%b dataOut=%h",rawMemOut,DSize,loadSign,dataOut);    
    end
endmodule
