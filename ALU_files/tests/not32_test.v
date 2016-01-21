module testbench;
    reg [0:31] X;
    wire [0:31] Z;

    not_32 NOT_32(.X(X),.Z(Z));
    
    initial begin
        $monitor("x=%h z=%h",X,Z);

        #0 X = 32'hAAFF12FF; 
        #1 X = 32'hFF0000FF;
        #1 X = 32'h00FF00FF; 


    end
endmodule // testbench
