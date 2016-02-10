module test5_32;
    reg [0:4] x;
    reg en;
    wire [0:31] z;
    wire [0:3] enable;

    decoder_5to32 DECODER(x,en,z,enable);
    
    initial begin
        $monitor("x=%x en=%b z=%b enable=%b",x,en,z,enable);

        #0 x=5'b00000; en=1'b1;
        #1 x=5'b00001; en=1'b1;


    end
endmodule // testbench



module test2_4;
    reg [0:1] x;
    reg en;
    wire [0:3] z;

    decoder_2to4 DECODER(x,en,z);
    
    initial begin
        $monitor("x=%x en=%b z=%b",x,en,z);

        #0 x=2'b00; en=1'b1;
        #1 x=2'b01; en=1'b0;
        #1 x=2'b10; en=1'b1;
        #1 x=2'b11; en=1'b1;


    end
endmodule // testbench


module test3_8;
    reg [0:2] x;
    reg en;
    wire [0:7] z;

    decoder_3to8 DECODER(x,en,z);
    
    initial begin
        $monitor("x=%x en=%b z=%b",x,en,z);

        #0 x=3'b000; en=1'b1;
        #1 x=3'b001; en=1'b1;
        #1 x=3'b010; en=1'b1;
        #1 x=3'b011; en=1'b0;
        #1 x=3'b100; en=1'b1;
        #1 x=3'b101; en=1'b1;
        #1 x=3'b110; en=1'b1;
        #1 x=3'b111; en=1'b1;


    end
endmodule // testbench
