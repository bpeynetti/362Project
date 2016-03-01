//-- SETTER


module setter(A, B, seq, sne, sle, slt, sge, sgt);
    
    input [0:31] A, B;
    output seq, sne, sle, slt, sge, sgt;
    
    wire [0:31] b_not;
    wire [0:31] difference;
    wire sub_cout;
    wire seq_temp, slt_temp, sge_temp, sle_temp;
    wire sub_of;
    
    not_32 NEGATE_B(B, b_not);
    fa_nbit FULL_ADDER(A, b_not, 1'b1, difference, sub_cout, sub_of);
    
    zero CHECK_EQ(difference, seq_temp);
    
    assign slt_temp = difference[0] ^ sub_of;
    assign sge_temp = ~slt_temp;
    assign sle_temp = seq_temp | slt_temp;
    assign sgt = ~sle_temp;
    assign sne = ~seq_temp;
    
    assign seq = seq_temp;
    assign slt = slt_temp;
    assign sge = sge_temp;
    assign sle = sle_temp;
    
endmodule