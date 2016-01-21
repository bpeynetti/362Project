module testbench;
    reg [0:31] X;
    reg [0:31] Y;
    wire [0:31] Z;

    or_32 OR_32(.X(X), .Y(Y), .Z(Z));
    
    initial begin
        $monitor("x=%h y=%h z=%h",X,Y,Z);

        #0 X = 32'hAAFF12FF; Y = 32'hFF00FF00;
        #1 X = 32'hFF0000FF; Y = 32'hFF00FF00;
        #1 X = 32'h00FF00FF; Y = 32'hFF00FF00;
        #1 X = 32'h0F0F0F0F; Y = 32'hFFFFFFFF;
        #1 X = 32'h0F0F0F0F; Y = 32'h00000000;

    end
endmodule // testbench
