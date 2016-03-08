// module instruction_fetch(leap_addr, leap, clk, reset, pcplus4, instruction);
module instruction_fetch(leap_addr, leap, pc_we, clk, reset, pcplus4, pc_out_);
    input [0:31] leap_addr;
    input leap, pc_we, clk, reset;
    output [0:31] pcplus4,pc_out_;
    
    // output [0:31] instruction;
    
    wire [0:31] pc_out;
    wire [0:31] pc_new;
    
    
    register32 PC_REG(
        .inData(pc_new),
        .clk(clk),
        .writeEnable(pc_we),
        .reset(reset),
        .outData(pc_out)
    );
    
    assign pc_out_ = pc_out;
    
    fa_nbit ADD_FOUR(
        .A(pc_out),
        .B(32'd4),
        .cin(1'b0),
        .Sum(pcplus4)
    );
    
    mux2to1_32bit ADD_FOUR_OR_JUMP(
        .X(pcplus4),
        .Y(leap_addr),
        .sel(leap),
        .Z(pc_new)
    );
    
    // imem I_MEM (.addr(pc_out),.instr(instruction));
    
endmodule