module xor_1(x, y, z);
    input x, y;
    output z;

    assign z = x ^ y;
endmodule // xor

module xor_32(X, Y, Z);
    parameter WIDTH = 32;
    input [0:(WIDTH-1)] X, Y;
    output [0:(WIDTH-1)] Z;
    
    genvar i;
    generate
        for (i=0;i<WIDTH;i=i+1) begin: XOR_32BIT
            //each bit of the output is just the 
            //result of an and on that bit of the two inputs
            xor_1 XOR_1 (
                .x(X[i]),
                .y(Y[i]),
                .z(Z[i]));
        end
    endgenerate

endmodule