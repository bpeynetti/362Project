module PipeReg32(out, in, clk, rst); // synopsys template
   parameter width = 32, init = 0;
   output [0:width-1] out;
   reg [0:width-1]    out;
   input [0:width-1]  in;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else
       out <= in;
   
endmodule // PipeReg

module PipeCtlReg32(out, in, ctl, clk, rst); // synopsys template
   parameter width = 32, init = 0;
   output [0:width-1] out;
   reg [0:width-1]    out;
   input [0:width-1]  in;
   input [0:1] 	      ctl;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else begin
        if (ctl == 2'b00)
	        out <= in;
        else if (ctl == 2'b11)
	        out <= init;
     end
endmodule // PipeCtlReg

module PipeCtlRegN #(parameter WIDTH=32) (out, in, ctl, clk, rst); // synopsys template
   parameter init = 0;
   output [0:WIDTH-1] out;
   reg [0:WIDTH-1]    out;
   input [0:WIDTH-1]  in;
   input     	      ctl;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else begin
        if (ctl == 1'b0)
	        out <= in;
        else if (ctl == 1'b1)
	        out <= init;
     end
endmodule // PipeCtlReg

module pipeline(data,clk,rst,flush,out);
   parameter width = 32, init = 0;
    input clk,rst;
    input flush; //sets the flush to be on on the flushid register
    input [0:width-1] data; //data in and data out
    
    output [0:width-1] out;
    

    //now create 4 of these and wire them from one to the other
    wire [0:width-1] IF_data,ID_data,EX_data,MEM_data,WB_data;

    wire nothing;
    assign nothing = 1'b0;

    assign IF_data = data;
    // I think I don't need flush id since I only flush one 
    PipeCtlRegN #(32) IFID_REG(
    	.clk(clk),
    	.in(IF_data),
    	.rst(rst),
    	.ctl(flush),
    	.out(ID_data)
    	);

    PipeCtlRegN #(32) IDEX_REG(
    	.clk(clk),
    	.in(ID_data),
    	.rst(rst),
    	.ctl(nothing),
    	.out(EX_data)
    	);

    PipeCtlRegN #(32) EXMEM_REG(
    	.clk(clk),
    	.in(EX_data),
    	.rst(rst),
    	.ctl(nothing),
    	.out(MEM_data)
    	);

    PipeCtlRegN #(32) MEMWB_REG(
    	.clk(clk),
    	.in(MEM_data),
    	.rst(rst),
    	.ctl(nothing),
    	.out(WB_data)
    	);
    
	assign out = WB_data;   
    
endmodule



