module testbench;
    reg [0:31] X;
    reg [0:4] SHAMT;
    reg ARITH;
    reg RIGHT;
    wire [0:31] Z;

    shift SHIFT (.X(X), .shamt(SHAMT), .arith(ARITH), .right(RIGHT), .Z(Z));
    
    initial begin
        $monitor("x=%h shamt=%h arith=%h right=%h z=%h",X,SHAMT,ARITH,RIGHT,Z);

        #0 X = 32'haa001100; SHAMT=5'h0; ARITH=1'b0; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h1; ARITH=1'b0; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h2; ARITH=1'b0; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h4; ARITH=1'b0; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h8; ARITH=1'b0; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h10; ARITH=1'b0; RIGHT=1'b0;
        
        #1 X = 32'hAABBCCDD; SHAMT=5'h0; ARITH=1'b1; RIGHT=1'b0;
        #1 X = 32'hAABBCCDD; SHAMT=5'h2; ARITH=1'b1; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h4; ARITH=1'b1; RIGHT=1'b0;
        #1 X = 32'hAABBCCDD; SHAMT=5'h8; ARITH=1'b1; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'ha; ARITH=1'b1; RIGHT=1'b0;
        #1 X = 32'haa001100; SHAMT=5'h5; ARITH=1'b1; RIGHT=1'b0;

        #1 X = 32'haa001100; SHAMT=5'h0; ARITH=1'b1; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h1; ARITH=1'b1; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h2; ARITH=1'b1; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h3; ARITH=1'b1; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h4; ARITH=1'b1; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h5; ARITH=1'b1; RIGHT=1'b1;
        
        #0 X = 32'haa001100; SHAMT=5'h0; ARITH=1'b0; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h1; ARITH=1'b0; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h2; ARITH=1'b0; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h3; ARITH=1'b0; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h4; ARITH=1'b0; RIGHT=1'b1;
        #1 X = 32'haa001100; SHAMT=5'h5; ARITH=1'b0; RIGHT=1'b1;
        


    end
endmodule // testbench