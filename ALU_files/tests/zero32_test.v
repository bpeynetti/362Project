module testbench;
    reg [0:31] X;
    wire z;

    zero ZERO_32(.X(X),.z(z));
    
    initial begin
        $monitor("x=%h z=%h",X,z);

        #0 X = 32'hAAFF12FF; 
        #1 X = 32'hFF0000FF;
        #1 X = 32'h00FF00FF; 
        #1 X = 32'h00000000;
        #1 X = 32'h80000000;
    end
endmodule // testbench
