module testbench;
    reg X;
    reg Y;
    reg SEL;
    wire Z;

    mux_1 AND_1(.x(X), .y(Y), .sel(SEL), .z(Z));
    
    initial begin
        $monitor("x=%b y=%b sel=%b z=%b",X,Y,SEL,Z);

        #0 X = 1'b0; Y = 1'b0; SEL = 1'b0;
        #1 X = 1'b0; Y = 1'b0; SEL = 1'b1;
        #1 X = 1'b0; Y = 1'b1; SEL = 1'b0;
        #1 X = 1'b0; Y = 1'b1; SEL = 1'b1;
        
        #1 X = 1'b1; Y = 1'b0; SEL = 1'b0;
        #1 X = 1'b1; Y = 1'b0; SEL = 1'b1;
        #1 X = 1'b1; Y = 1'b1; SEL = 1'b0;
        #1 X = 1'b1; Y = 1'b1; SEL = 1'b1;

    end
endmodule // testbench
