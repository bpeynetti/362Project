module not_1(x, z);
    input x;
    output z;

    assign z = ~x;
endmodule // not

module not_32(X, Z);
    parameter WIDTH = 32;
    input [0:(WIDTH-1)] X;
    output [0:(WIDTH-1)] Z;
    
    genvar i;
    generate
        for (i=0;i<WIDTH;i=i+1) begin: NOT_32BIT
            //each bit of the output is just the 
            //result of an and on that bit of the two inputs
            not_1 NOT_1 (
                .x(X[i]),
                .z(Z[i]));
        end
    endgenerate

endmodule