module extend_1to32(x, sign, Z);
    
    //x is the bit to extend
    //sign is 1 if it is a sign extend
    //0 if it is a zero extend
    input x, sign;
    output [0:31] Z;
    
    wire bit_to_extend;
    
    mux_1 SELECT_EXTEND(1'b0, x, sign, bit_to_extend);
    
    assign Z = {bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,x};
    
endmodule