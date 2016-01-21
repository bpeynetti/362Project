module testbench;
    reg X;
    reg Y;
    wire Z;

    or_1 OR_1(.x(X), .y(Y), .z(Z));
    
    initial begin
        $monitor("x=%b y=%b z=%b",X,Y,Z);

        #0 X = 1'b0; Y = 1'b0;
        #1 X = 1'b0; Y = 1'b1;
        #1 X = 1'b1; Y = 1'b0;
        #1 X = 1'b1; Y = 1'b1;

    end
endmodule // testbench
