
module shift(X, shamt, arith, right, Z);
    input [0:31] X;
    input [0:4] shamt;//NOTE: will need to reverse endianness
    input arith, right;
    output [0:31] Z;
    
    //the MASK wires are used as input to each mux
    //each shift power of two has a mux to decide 
    //whether to shift by that amount
    //the TEMP wires are used as intermediate outputs
    //for the next part of the shifting computation
    wire [0:31] lmask0, lmask1, lmask2, lmask3, lmask4;
    wire [0:31] ltemp0, ltemp1, ltemp2, ltemp3, ltemp4;
    wire [0:31] rmask0, rmask1, rmask2, rmask3, rmask4;
    wire [0:31] rtemp0, rtemp1, rtemp2, rtemp3, rtemp4;
    wire extend;
    wire [0:15] extend16;
    
    //SHIFT LEFT:
    //idea - shift individually by each power of two
    //each shift uses a 2-to-1 mux
    //with a bit from the shift amount as the selector
    assign lmask0 = {X[16:31], 16'h0000};
    mux2to1_32bit SHIFTLEFT16(X, lmask0, shamt[0], ltemp0);
    assign lmask1 = {ltemp0[8:31], 8'h00};
    mux2to1_32bit SHIFTLEFT8(ltemp0, lmask1, shamt[1], ltemp1);
    assign lmask2 = {ltemp1[4:31], 4'h0};
    mux2to1_32bit SHIFTLEFT4(ltemp1, lmask2, shamt[2], ltemp2);
    assign lmask3 = {ltemp2[2:31], 2'b00};
    mux2to1_32bit SHIFTLEFT2(ltemp2, lmask3, shamt[3], ltemp3);
    assign lmask4 = {ltemp3[1:31], 1'b0};
    mux2to1_32bit SHIFTLEFT1(ltemp3, lmask4, shamt[4], ltemp4);
    
    //SHIFT RIGHT:
    //idea - shift individually by each power of two
    //each shift uses a 2-to-1 mux
    //with a bit from the shift amount as the selector
    assign rmask0 = {extend16, X[0:15]};
    mux2to1_32bit SHIFTRIGHT16(X, rmask0, shamt[0], rtemp0);
    assign rmask1 = {extend16[0:7], rtemp0[0:23]};
    mux2to1_32bit SHIFTRIGHT8(rtemp0, rmask1, shamt[1], rtemp1);
    assign rmask2 = {extend16[0:3], rtemp1[0:27]};
    mux2to1_32bit SHIFTRIGHT4(rtemp1, rmask2, shamt[2], rtemp2);
    assign rmask3 = {extend16[0:1], rtemp2[0:29]};
    mux2to1_32bit SHIFTRIGHT2(rtemp2, rmask3, shamt[3], rtemp3);
    assign rmask4 = {extend, rtemp3[0:30]};
    mux2to1_32bit SHIFTRIGHT1(rtemp3, rmask4, shamt[4], rtemp4);
    
    //if the shift is arithmetic and the MSB is 1
    //(meaning the number is negative)
    //then you extend with 1's, otherwise with 0's (for right shift)
    assign extend = X[0] & arith;
    assign extend16 = {extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend, extend};
    
    //select between left and right based on the control signal given
    mux2to1_32bit LEFTORRIGHT(ltemp4, rtemp4, right, Z);

endmodule