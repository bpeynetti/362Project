module testbench;
reg clock;
reg reset;
reg [8*80-1:0] filename;
wire [0:31] PC;
wire [0:31]busWout,instructionOut;

top_level top(clock,reset);

always begin
   #1 clock = ~clock;
end

integer i;
integer iter;
initial begin
	   // $dumpfile("tests/single_cycle_test.vcd");
    	$dumpvars(0);
  // Clear DMEM
   for (i = 0; i < top.DATA_MEM.SIZE; i = i+1)
      top.DATA_MEM.mem[i] = 8'h0;
    for (i=0; i<top.INSTRUCTION_MEM.SIZE; i = i+1)
      top.INSTRUCTION_MEM.mem[i] = 8'h0;

  //Load IMEM from file
   if (!$value$plusargs("instrfile=%s", filename)) begin
      filename = "test/instr.hex";
   end
   $readmemh(filename, top.INSTRUCTION_MEM.mem);
  // Load DMEM from file
  if (!$value$plusargs("datafile=%s", filename)) begin 
      filename = "test/data.hex";
  end
  $writememh("imem", top.INSTRUCTION_MEM.mem);
  $readmemh(filename, top.DATA_MEM.mem);
  $writememh("datamem",top.DATA_MEM.mem);


    //UNCOMMENT THIS IN ORDER TO DISPLAY ALL MONITOR SIGNALS. OTHERWISE, ONLY MEMORY WRITES WILL APPEAR
    
    // $monitor("clk=%b rst=%b Instruction=%h PC=%h r1=%h r2=%h r3=%h r4=%h r5=%h r6=%h f1=%h f2=%h f3=%h f4=%h f5=%h r29=%h f30=%h r31=%h",
    //   top.clk,top.reset,top.imem_out,top.imem_addr,
    //   top.PIPELINE.REG_FILE.reg_out[1],top.PIPELINE.REG_FILE.reg_out[2],
    //   top.PIPELINE.REG_FILE.reg_out[3],top.PIPELINE.REG_FILE.reg_out[4],
    //   top.PIPELINE.REG_FILE.reg_out[5],top.PIPELINE.REG_FILE.reg_out[6],
    //   top.PIPELINE.FP_REG_FILE.reg_out[1],top.PIPELINE.FP_REG_FILE.reg_out[2],
    //   top.PIPELINE.FP_REG_FILE.reg_out[3],top.PIPELINE.FP_REG_FILE.reg_out[4],
    //   top.PIPELINE.FP_REG_FILE.reg_out[5],
    //   top.PIPELINE.REG_FILE.reg_out[29],top.PIPELINE.REG_FILE.reg_out[30],top.PIPELINE.REG_FILE.reg_out[31]
    // );

   #0 clock=0; reset=0; 
   #2 reset=0;
   #2 reset=1;

   #4000; 
   $finish;
end

// attempt to finish before we're supposed to (before #5000 steps)
reg [0:31] instr;

always @(posedge clock) begin
    // $display("Evaluation number: %h",j);
  //This checks for a trap 0x300 (signifying the end of the file)

  // if (top.PIPELINE.)
  if (top.PIPELINE.mul_ex_in == 1'b1) begin
    $display("MULTIPLICATION  \n");
  end
  if (top.PIPELINE.trap_mem == 1'b1) begin	
   
	$display("Hitting a trap, end, waiting 1 clock cycle and finishing");
    $display("Writing final data memory to datamem_end file");
	#2;
  $writememh("datamem_end",top.DATA_MEM.mem);
	$finish;
	
	end
end

endmodule
