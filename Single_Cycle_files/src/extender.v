module extend_16to32(x, sign, Z);
    
    //x is the bit to extend
    //sign is 1 if it is a sign extend
    //0 if it is a zero extend
    input [0:15] x;
    input sign;
    output [0:31] Z;
    
    wire bit_to_extend;
    
    mux_1 SELECT_EXTEND(1'b0, x[0], sign, bit_to_extend);
    
    assign Z = {bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,
    			bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,
    			bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,
    			bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,
    			x};
    
endmodule

module extend_26to32(x, sign, Z);
    
    //x is the bit to extend
    //sign is 1 if it is a sign extend
    //0 if it is a zero extend
    input [0:25] x;
    input sign;
    output [0:31] Z;
    
    wire bit_to_extend;
    
    mux_1 SELECT_EXTEND(1'b0, x[0], sign, bit_to_extend);
    
    assign Z = {bit_to_extend,bit_to_extend,bit_to_extend,bit_to_extend,
    			bit_to_extend,bit_to_extend,x};
    
endmodule