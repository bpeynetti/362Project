module testbench;
    reg [0:31] in0;
    reg [0:31] in1;
    reg [0:31] in2;
    reg [0:31] in3;
    reg [0:31] in4;
    reg [0:31] in5;
    reg [0:31] in6;
    reg [0:31] in7;
    reg [0:31] in8;
    reg [0:31] in9;
    reg [0:31] in10;
    reg [0:31] in11;
    reg [0:31] in12;
    reg [0:31] in13;
    reg [0:31] in14;
    reg [0:31] in15;

    reg [0:3] SEL;
    wire [0:31] Z;

    mux16to1_32bit MUX16TO1_32BIT (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        
        .in8(in8),
        .in9(in9),
        .in10(in10),
        .in11(in11),
        .in12(in12),
        .in13(in13),
        .in14(in14),
        .in15(in15),
        .sel(SEL),
        .Z(Z)
    );
    
    initial begin
        $monitor("in0=%h in1=%h in2=%h in3=%h in4=%h in5=%h in6=%h in7=%h in8=%h in9=%h in10=%h in11=%h in12=%h in13=%h in14=%h in15=%h sel=%h Z=%h",in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,SEL,Z);

        #0 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h0;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h1;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h2;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h3;
        
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h4;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h5;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h6;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h7;

        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h8;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'h9;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'ha;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'hb;

        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'hc;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'hd;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'he;
        #1 in0 = 32'h00000000; in1 = 32'h11111111; in2 = 32'h22222222; in3 = 32'h33333333; in4 = 32'h44444444; in5 = 32'h55555555; in6 = 32'h66666666; in7 = 32'h77777777; in8 = 32'h88888888; in9 = 32'h99999999; in10 = 32'haaaaaaaa; in11 = 32'hbbbbbbbb; in12 = 32'hcccccccc; in13 = 32'hdddddddd; in14 = 32'heeeeeeee; in15 = 32'hffffffff; SEL=4'hf;

 
    end
endmodule // testbench