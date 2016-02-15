module compare_lt(a, b, result);
   input [0:15] a, b;
   output [0:15] result;

   assign result = (a < b) ? a : b;
endmodule // compare_lt

module find_min(a, b, c, d, m, clk, rst);
   input [0:15] a, b, c, d;
   input 	clk, rst;
   output [0:15] m;
   wire [0:15] input1_a, input1_b, input2_a, input2_b, result1, result2, result1_reg, result2_reg,
	       final_result;
   
   PipeReg #(16) IN_PIPE_REG_A(input1_a, a, clk, rst);
   PipeReg #(16) IN_PIPE_REG_B(input1_b, b, clk, rst);
   PipeReg #(16) IN_PIPE_REG_C(input2_a, c, clk, rst);
   PipeReg #(16) IN_PIPE_REG_D(input2_b, d, clk, rst);   

   compare_lt COMPARE1_STAGE1(.a(input1_a), .b(input1_b), .result(result1));
   compare_lt COMPARE2_STAGE1(.a(input2_a), .b(input2_b), .result(result2));

   PipeReg #(16) PIPEREG1(result1_reg, result1, clk, rst);
   PipeReg #(16) PIPEREG2(result2_reg, result2, clk, rst);

   compare_lt COMPARE_STAGE2(.a(result1_reg), .b(result2_reg), .result(final_result));
   assign m = final_result;
   
endmodule // find_max

module test_bench();
   reg [0:15] a, b, c, d;
   reg 	      clk;
   reg 	      rst;
   wire [0:15] m;

   find_min MIN(.a(a), .b(b), .c(c), .d(d), .m(m), .clk(clk), .rst(rst));

   initial begin
      $monitor($time,,"a=%d b=%d c=%d d=%d m=%d result1_reg=%d result2_reg=%d final_result=%d",
	       a, b, c, d, m, MIN.result1_reg, MIN.result2_reg, MIN.final_result);
      
      #1 rst <= 0; clk <= 0;
      #1 rst <= 1; 
      #1 a <= 1; b <= 2; c <= 3; d <= 4; clk <= 1;
      #1 clk <= 0;
      #1 a <= 45; b <= 35; c <= 23; d <= 100; clk <= 1;
      #1 clk = 0;
      #1 a <= 100; b <= 300; c <= 200; d <= 400; clk <= 1;
      #1 clk <= 0;
      #1 clk <= 1;
      #1 clk <= 0;
      #1 clk <= 1;

   end
endmodule // test_bench
