//-- MUX
    
// Design: mux using structural

module mux_1(x,y,sel,z);

    input x,y,sel;
    output z;
    
    assign z = x&(~sel) | y&sel;

endmodule

// a simple 2-1 32bit mux
module mux2to1_32bit(X,Y,sel,Z);
    
    parameter WIDTH=32;
    input [0:(WIDTH-1)] X, Y;
    input sel;
    output [0:(WIDTH-1)] Z;
    
    genvar i;
    generate
        for (i=0; i<WIDTH; i=i+1) begin: MUX2TO1_32BIT
            // Do a mux 2 to 1 for given width in generate loop
            mux_1 MUX (
                .x(X[i]),
                .y(Y[i]),
                .sel(sel),
                .z(Z[i]));
        end
    endgenerate
endmodule

// a 4:1 32bit mux
module mux4to1_32bit(in0,in1,in2,in3,sel,Z);

    parameter WIDTH=32;
    parameter SEL=2;
    input [0:(WIDTH-1)] in0,in1,in2,in3;
    input [0:(SEL-1)] sel;
    output [0:(WIDTH-1)] Z;
    
    //now route in1 and in2 through one mux, and in3,in4 through another mux
    
    //need a wire to carry signals into 3rd mux
    wire [0:(WIDTH-1)] bus1;
    wire [0:(WIDTH-1)] bus2;
    
    mux2to1_32bit MUX_BUS1 (
        .X(in0),
        .Y(in1),
        .sel(sel[1]),
        .Z(bus1)
    );
    
    mux2to1_32bit MUX_BUS2 (
        .X(in2),
        .Y(in3),
        .sel(sel[1]),
        .Z(bus2)
    );
    
    //now route it through mux with select sel[1]
    
    mux2to1_32bit MUX_OUT (
        .X(bus1),
        .Y(bus2),
        .sel(sel[0]),
        .Z(Z)
    );

endmodule



// a 8:1 32bit mux
module mux8to1_32bit(in0,in1,in2,in3,in4,in5,in6,in7,sel,Z);

    parameter WIDTH=32;
    parameter SEL=3;
    input [0:(WIDTH-1)] in0,in1,in2,in3,in4,in5,in6,in7;
    input [0:(SEL-1)] sel;
    output [0:(WIDTH-1)] Z;
    
    //now route in1 and in2 through one mux, and in3,in4 through another mux
    
    //need a wire to carry signals into 3rd mux
    wire [0:(WIDTH-1)] bus1;
    wire [0:(WIDTH-1)] bus2;
    
    mux4to1_32bit MUX_BUS1 (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel[1:2]),
        .Z(bus1)
    );
    
    mux4to1_32bit MUX_BUS2 (
        .in0(in4),
        .in1(in5),
        .in2(in6),
        .in3(in7),
        .sel(sel[1:2]),
        .Z(bus2)
    );
    
    //now route it through mux with select sel[1]
    
    mux2to1_32bit MUX_OUT (
        .X(bus1),
        .Y(bus2),
        .sel(sel[0]),
        .Z(Z)
    );

endmodule


// a 8:1 32bit mux
module mux16to1_32bit(in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,sel,Z);

    parameter WIDTH=32;
    parameter SEL=4;
    input [0:(WIDTH-1)] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15;
    input [0:(SEL-1)] sel;
    output [0:(WIDTH-1)] Z;
    
    //now route in1 and in2 through one mux, and in3,in4 through another mux
    
    //need a wire to carry signals into 3rd mux
    wire [0:(WIDTH-1)] bus1;
    wire [0:(WIDTH-1)] bus2;
    
    mux8to1_32bit MUX_BUS1 (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .sel(sel[1:3]),
        .Z(bus1)
    );
    
    mux8to1_32bit MUX_BUS2 (
        .in0(in8),
        .in1(in9),
        .in2(in10),
        .in3(in11),
        .in4(in12),
        .in5(in13),
        .in6(in14),
        .in7(in15),
        .sel(sel[1:3]),
        .Z(bus2)
    );
    
    //now route it through mux with select sel[1]
    
    mux2to1_32bit MUX_OUT (
        .X(bus1),
        .Y(bus2),
        .sel(sel[0]),
        .Z(Z)
    );

endmodule


// a 8:1 32bit mux
module mux32to1_32bit(in0,in1,in2,in3,in4,in5,in6,in7,in8,
                    in9,in10,in11,in12,in13,in14,in15,
                    in16,in17,in18,in19,in20,in21,in22,in23,in24,
                    in25,in26,in27,in28,in29,in30,in31,
                    sel,Z);

    parameter WIDTH=32;
    parameter SEL=5;
    input [0:(WIDTH-1)] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31;
    input [0:(SEL-1)] sel;
    output [0:(WIDTH-1)] Z;
    
    //now route in1 and in2 through one mux, and in3,in4 through another mux
    
    //need a wire to carry signals into 3rd mux
    wire [0:(WIDTH-1)] bus1;
    wire [0:(WIDTH-1)] bus2;
    
    mux16to1_32bit MUX_BUS1 (
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
        .sel(sel[1:4]),
        .Z(bus1)
    );
    
    mux16to1_32bit MUX_BUS2 (
        .in0(in16),
        .in1(in17),
        .in2(in18),
        .in3(in19),
        .in4(in20),
        .in5(in21),
        .in6(in22),
        .in7(in23),
        .in8(in24),
        .in9(in25),
        .in10(in26),
        .in11(in27),
        .in12(in28),
        .in13(in29),
        .in14(in30),
        .in15(in31),
        .sel(sel[1:4]),
        .Z(bus2)
    );
    
    //now route it through mux with select sel[1]
    
    mux2to1_32bit MUX_OUT (
        .X(bus1),
        .Y(bus2),
        .sel(sel[0]),
        .Z(Z)
    );

endmodule