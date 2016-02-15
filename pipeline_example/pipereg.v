module PipeReg(out, in, clk, rst); // synopsys template
   parameter width = 32, init = 0;
   output [width-1:0] out;
   reg [width-1:0]    out;
   input [width-1:0]  in;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else
       out <= in;
   
endmodule // PipeReg

module PipeCtlReg(out, in, ctl, clk, rst); // synopsys template
   parameter width = 32, init = 0;
   output [width-1:0] out;
   reg [width-1:0]    out;
   input [width-1:0]  in;
   input [1:0] 	      ctl;
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
