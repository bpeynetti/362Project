module mux_1(x,y,sel,z);

    input x,y,sel;
    output z;
    
    assign z = x&(~sel) | y&sel;

endmodule
module dff(data, clk, reset, q);
    
    input data, clk, reset;
    output q;
    
    reg q;
    
    always @ (posedge clk)
    if (~reset) begin
        q <= 1'b0;
    end
    else begin
        q <= data;
    end

endmodule

module register1(inData, clk, writeEnable, reset, outData);
    
    input inData, clk, writeEnable,reset;
    output outData;
    
    wire ffOut;
    wire muxOut;
    
    mux_1 CHECK_WRITE(ffOut, inData, writeEnable, muxOut);
    dff STORE_DATA(muxOut, clk, reset, ffOut);
    assign outData = ffOut;
endmodule

module pipeRegister1(inData, clk, flush, reset, outData);
    
    input inData,clk,flush,reset;
    output outData;
    
    wire zero,one;
    assign zero = 1'b0;
    assign one = 1'b1;
    
    wire outReg;
    register1 REG1 (
            .inData(inData),
            .clk(clk),
            .reset(reset),
            .writeEnable(one),
            .outData(outReg)
    );
    
    // now NAND it  (if flush=0, outreg=outData, if flush=1, outData = 0)
    assign outData = outReg & (~flush);
    
endmodule

module pipeRegister32(inData, clk,flush, reset,outData);
    parameter width=32;
    input [0:width-1] inData;
    input clk,flush,reset;
    output [0:width-1] outData;
    
    genvar i;
    generate
        for (i=0; i<width; i=i+1) begin: REG_NBIT
            pipeRegister1 PIPEREG1 (
                .inData(inData[i]),
                .clk(clk),
                .flush(flush),
                .reset(reset),
                .outData(outData[i])
                );
        end
    endgenerate
endmodule

module pipeline(data,clk,rst,flush,out);
   parameter width = 32, init = 0;
    input clk,rst;
    input flush; //sets the flush to be on on the flushid register
    input [0:width-1] data; //data in and data out
    
    output [0:width-1] out;
    
    //now create 4 of these and wire them from one to the other
    wire [0:width-1] IF_data,ID_data,EX_data,MEM_data,WB_data;

    // wire IFID_flush,IDEX_flush,EXMEM_flush,MEMWB_flush;
    wire [0:1] ctlFlush;
    assign ctlFlush = {flush,flush};
    wire [0:1] nothing;
    assign nothing = 2'b00;

    assign IF_data = data;
    // I think I don't need flush id since I only flush one 
    pipeRegister32 IFID_REG(
    	.clk(clk),
    	.inData(IF_data),
    	.reset(reset),
    	.flush(ctlFlush),
    	.outData(ID_data)
    	);

    pipeRegister32 IDEX_REG(
    	.clk(clk),
    	.inData(ID_data),
    	.reset(reset),
    	.flush(ctlFlush),
    	.outData(EX_data)
    	);

    pipeRegister32 EXMEM_REG(
    	.clk(clk),
    	.in(data),
    	.rst(rst),
    	.ctl(nothing),
    	.out(MEM_data)
    	);

    pipeRegister32 MEMWB_REG(
    	.clk(clk),
    	.in(data),
    	.rst(rst),
    	.ctl(nothing),
    	.out(WB_data)
    	);
    
	assign out = WB_data;   
    
endmodule

    


