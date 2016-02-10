module decoder_2to4(x, en, z);
    input [0:1] x; //the two bit signal to decode
    input en;
    output [0:3] z; //the four bit output of the decoder
    
    assign z[0] = (en & ~x[1] & ~x[0]);
    assign z[1] = (en &  x[1] & ~x[0]);
    assign z[2] = (en & ~x[1] &  x[0]);
    assign z[3] = (en &  x[1] &  x[0]);
    //NEED TO CHECK WITH BRUNO - IS THE ENDIANNESS/ORDERING BACKWARDS?
    //NEED TO CHECK THIS FOR ALL THREE DECODERS!!!
    
endmodule

module decoder_3to8(x, en, z);
    input [0:2] x; //the three bit signal to decode
    input en;
    output [0:7] z; //the eight bit output of the decoder
    
    wire not_x0;
    wire x0;
    assign not_x0 = ~ x[0] & en;
    assign x0 = x[0] & en;
    
    
    // not_1 INVERT_MSB(x[2], not_x2);
    decoder_2to4 DECODER_1(x[1:2], not_x0, z[0:3]);
    decoder_2to4 DECODER_2(x[1:2], x0, z[4:7]);
    
endmodule

module decoder_5to32(x, en, z,enable_out);
    
    input [0:4] x; //the five bit signal to decode
    input en;
    output [0:31] z; //the 32 bit output of the decoder
    output [0:3] enable_out;
    
    wire [0:3] enable; //the enable signals for the 4 3 to 8 decoders
    
    
    decoder_2to4 GENERATE_ENABLE(x[0:1], 1'b1, enable[0:3]);
    
    decoder_3to8 DECODE_BYTE_0(x[2:4], enable[0], z[0:7]);
    decoder_3to8 DECODE_BYTE_1(x[2:4], enable[1], z[8:15]);
    decoder_3to8 DECODE_BYTE_2(x[2:4], enable[2], z[16:23]);
    decoder_3to8 DECODE_BYTE_3(x[2:4], enable[3], z[24:31]);

    assign enable_out = enable;

endmodule