module decoder_2to4(x, en, z);
    input [0:1] x; //the two bit signal to decode
    input en;
    output [0:3] z; //the four bit output of the decoder
    
    assign z[0] = (en & ~x[1] & ~x[0]);
    assign z[1] = (en & ~x[1] &  x[0]);
    assign z[2] = (en &  x[1] & ~x[0]);
    assign z[3] = (en &  x[1] &  x[0]);
    //NEED TO CHECK WITH BRUNO - IS THE ENDIANNESS/ORDERING BACKWARDS?
    
endmodule

module decoder_3to8(x, en z);
    input [0:2] x; //the five bit signal to decode
    input en;
    output [0:7] z; //the thirty-two bit output of the decoder
    
    