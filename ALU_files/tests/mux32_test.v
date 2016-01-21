module testbench;
    reg [0:31] X;
    reg [0:31] Y;
    reg SEL;
    wire [0:31] Z;

    mux2to1_32bit MUX2TO1_32BIT (.X(X), .Y(Y), .sel(SEL), .Z(Z));
    
    initial begin
        $monitor("x=%h y=%h sel=%b z=%h",X,Y,SEL,Z);

        #0 X = 32'hAABBCCDD; Y = 32'h00112233; SEL = 1'b0;
        #1 X = 32'h12312344; Y = 32'h67890ABC; SEL = 1'b1;
        #1 X = 32'hAABBCCDD; Y = 32'h00112233; SEL = 1'b0;
        #1 X = 32'hAABBCCDD; Y = 32'hACADBCCC; SEL = 1'b1;


    end
endmodule // testbench