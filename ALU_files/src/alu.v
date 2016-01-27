module alu(A, B, ctrl, ALUout, zero);
    input [0:31] A, B;
    input [0:3] ctrl;
    output [0:31] ALUout;
    output zero;
    
    //need a wire 
    wire [0:31] and_out, or_out, xor_out;
    wire [0:31] b_not, add_sub_in, add_sub_out;
    wire [0:31] shift_out;
    wire seq_1bit, sne_1bit, sle_1bit, sgt_1bit, sge_1bit, slt_1bit;
    wire [0:31] seq_out, sne_out, sle_out, sgt_out, sge_out, slt_out;
    
    wire [0:4] shift_amount;
    wire add_sub_cout;
    wire add_of;
    
    and_32 AND_32(A, B, and_out);
    or_32 OR_32(A, B, or_out);
    xor_32 XOR_32(A, B, xor_out);
    
    //for now ctrl[3] distinguishes add and subtract
    not_32 NEGATE_B(B, b_not);
    mux2to1_32bit ADD_OR_SUB(B, b_not, ctrl[3], add_sub_in);
    fa_nbit FULL_ADDER(A, add_sub_in, ctrl[3], add_sub_out, add_sub_cout,add_of);
    
    //for now ctrl[1] is 1 for arithmetic shift
    //and ctrl[2] is 1 for right shift
    assign shift_amount = {B[27:31]};
    shift SHIFTER(A, shift_amount, ctrl[1], ctrl[2], shift_out);
    
    setter SET_FLAGS(A, B, seq_1bit, sne_1bit, sle_1bit, slt_1bit, sge_1bit, sgt_1bit);
    
    assign zero = seq_1bit;
    
    extend_1to32 EXTEND_SEQ(seq_1bit, 1'b0, seq_out);
    extend_1to32 EXTEND_SNE(sne_1bit, 1'b0, sne_out);
    extend_1to32 EXTEND_SLE(sle_1bit, 1'b0, sle_out);
    extend_1to32 EXTEND_SLT(slt_1bit, 1'b0, slt_out);
    extend_1to32 EXTEND_SGE(sge_1bit, 1'b0, sge_out);
    extend_1to32 EXTEND_SGT(sgt_1bit, 1'b0, sgt_out);
    
    mux16to1_32bit FINAL_MUX
                (add_sub_out, add_sub_out, 
                    slt_out, sle_out, sgt_out, 
                    sge_out, and_out, shift_out, 
                    and_out, shift_out, shift_out, 
                    seq_out, sne_out, and_out, 
                    or_out, xor_out, 
                    ctrl,
                    ALUout);
    
endmodule