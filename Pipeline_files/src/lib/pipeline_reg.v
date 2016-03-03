module PipeCtlRegN #(parameter WIDTH=32) (out, in, ctl, clk, reset); // synopsys template
   parameter init = 0;
   output [0:WIDTH-1] out;
   reg [0:WIDTH-1]    out;
   input [0:WIDTH-1]  in;
   input     	      ctl;
   input 	      clk, reset;

   always @ (posedge clk or negedge reset)
     if (~reset)
       out <= init;
     else begin
        if (ctl == 1'b0)
	        out <= in;
        else if (ctl == 1'b1)
	        out <= init;
     end
endmodule // PipeCtlReg