module register_file(
    rd, //destination register number
    ra, //source 1 register number (goes to busA)
    rb, //source 2 register number (goes to busB)
    busW, //value to write into rd
    clk, //clock
    writeEnable, //1 to write
    reset, //1 for reset
    
    busA, //value from register ra
    busB //value from register rb
    );
    
    input [0:4] rd, ra, rb;
    input [0:31] busW;
    input clk, writeEnable, reset;
    
    output [0:31] busA, busB;
    
    wire [0:31] reg_out[0:31];
    wire [0:31] reg_we;
    
    decoder_5to32 DECODE_REG_WRITE (rd, writeEnable, reg_we);
    
    genvar i;
    generate
        for (i=0; i<32; i=i+1) begin: REGISTER_FILE_32
            register32 REGISTER32 (
                .inData(busW),
                .clk(clk),
                .writeEnable(reg_we[i]),
                .reset(reset),
                .outData(reg_out[i]));
        end
    endgenerate
    
    mux32to1_32bit MUX_A (
        reg_out[0], reg_out[1], reg_out[2], reg_out[3],
        reg_out[4], reg_out[5], reg_out[6], reg_out[7],
        reg_out[8], reg_out[9], reg_out[10], reg_out[11],
        reg_out[12], reg_out[13], reg_out[14], reg_out[15],
        reg_out[16], reg_out[17], reg_out[18], reg_out[19],
        reg_out[20], reg_out[21], reg_out[22], reg_out[23],
        reg_out[24], reg_out[25], reg_out[26], reg_out[27],
        reg_out[28], reg_out[29], reg_out[30], reg_out[31],
        ra,
        busA
    );
    
    mux32to1_32bit MUX_B (
        reg_out[0], reg_out[1], reg_out[2], reg_out[3],
        reg_out[4], reg_out[5], reg_out[6], reg_out[7],
        reg_out[8], reg_out[9], reg_out[10], reg_out[11],
        reg_out[12], reg_out[13], reg_out[14], reg_out[15],
        reg_out[16], reg_out[17], reg_out[18], reg_out[19],
        reg_out[20], reg_out[21], reg_out[22], reg_out[23],
        reg_out[24], reg_out[25], reg_out[26], reg_out[27],
        reg_out[28], reg_out[29], reg_out[30], reg_out[31],
        rb,
        busB
    );
    
endmodule