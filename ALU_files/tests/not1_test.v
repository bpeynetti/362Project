module testbench;
    reg X;
    wire Z;

    not_1 NOT_1(.x(X), .z(Z));
    
    initial begin
        $monitor("x=%b z=%b",X,Z);

        #0 X = 1'b0; 
        #1 X = 1'b1; 

    end
endmodule // testbench
