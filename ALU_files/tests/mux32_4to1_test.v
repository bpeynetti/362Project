module testbench;
    reg [0:31] in0;
    reg [0:31] in1;
    reg [0:31] in2;
    reg [0:31] in3;

    reg [0:1] SEL;
    wire [0:31] Z;

    mux4to1_32bit MUX4TO1_32BIT (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(SEL),
        .Z(Z)
    );
    
    initial begin
        $monitor("in0=%h in1=%h in2=%h in3=%h sel=%h Z=%h",in0,in1,in2,in3,SEL,Z);

        #0 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; SEL=2'h0;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; SEL=2'h1;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; SEL=2'h2;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; SEL=2'h3;

    end
endmodule // testbench