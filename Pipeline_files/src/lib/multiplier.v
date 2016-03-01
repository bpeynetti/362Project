module multiplier(X, Y, Z);
    
    input [0:31] X, Y;
    output [0:31] Z;
    
    assign Z = X * Y;
    
endmodule