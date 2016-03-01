
module zero(X,z);

    parameter WIDTH=32;
    input [0:(WIDTH-1)] X;
    output z;
    
    wire [0:WIDTH] cascade;
    
    //set to 0
    assign cascade[0] = X[0] & (~X[0]);
    
    
    genvar i;
    generate
        for(i=0; i<WIDTH; i=i+1) begin: CASCADE_ZERO
            or_1 OR_1 (
                .x(X[i]),
                .y(cascade[i]),
                .z(cascade[i+1]));
        end
    endgenerate
    
    assign z = ~cascade[WIDTH];

endmodule