module register_file_fp(
    rd, //destination register number
    ra, //source 1 register number (goes to busA)
    rb, //source 2 register number (goes to busB)
    busW, //value to write into rd
    64bit, //1 if 64 bits should be written to rd
    clk, //clock
    writeEnable, //1 to write
    reset, //1 for reset
    
    busA, //value from register ra
    busB //value from register rb
    );
    
    input [0:4] rd, ra, rb;
    input [0:63] busW;
    input 64bit;
    input clk, writeEnable, reset;
    
    output [0:31] busA, busB;
    
    wire [0:31] reg_out[0:31];
    wire [0:31] reg32_we, reg_we;
    wire [0:15] reg64_we;
    wire [0:31] busW_even, busW_odd;
    
    assign busW_odd = busW[32:63];
    mux2to1_32bit CHOOSE_EVEN_BUSW(
    	.X(busW[32:63]),
    	.Y(busW[0:31]),
    	.sel(64bit),
    	.Z(busW_even)
    );
    
    decoder_5to32 DECODE_32BIT (rd, writeEnable, reg32_we);
    decoder_4to16 DECODE_64BIT (rd[0:3], writeEnable, reg64_we);
    
    genvar i;
    genvar j;
    genvar k;
    generate
    	for (i=0;i<32; i=i+1) begin: MUX_WE
    		mux_1 CHOOSE_WRITE_ENABLE (
    			.x(reg32_we[i]),
    			.y(reg64_we[i/2]),
    			.sel(64bit),
    			.z(reg_we[i])
    		);
    	end
    endgenerate
    generate
        for (j=0; j<32; j=j+2) begin: REGISTER_FILE_EVEN
            register32 REGISTER32_EVEN (
                .inData(busW_even),
                .clk(clk),
                .writeEnable(reg_we),
                .reset(reset),
                .outData(reg_out[j]));
        end
    endgenerate
    generate
        for (k=0; k<32; k=k+2) begin: REGISTER_FILE_ODD
            register32 REGISTER32_ODD (
                .inData(busW_odd),
                .clk(clk),
                .writeEnable(reg_we),
                .reset(reset),
                .outData(reg_out[j]));
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