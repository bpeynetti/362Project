//-- SETTER
module or_1(x, y, z);
    input x, y;
    output z;

    assign z = x | y;
endmodule // or


module zero(X,z);

    parameter WIDTH=32;
    input [0:(WIDTH-1)] X;
    output z;
    
    wire [0:WIDTH] cascade;
    
    //set to 0
    assign cascade[0] = X[0] & (~X[0]);
    
    
    genvar i;
    generate
        for(i=0; i<WIDTH; i=i+1) begin: CASCADE_ZERO
            or_1 OR_1 (
                .x(X[i]),
                .y(cascade[0]),
                .z(cascade[i+1]));
        end
    endgenerate
    
    assign z = ~cascade[WIDTH];

endmodule

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
    assign slt = sle_temp;
    assign sge = sgt_temp;
    assign sle = sge_temp;
    
endmodule
