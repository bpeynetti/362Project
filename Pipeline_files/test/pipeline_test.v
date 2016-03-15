module testbench;
reg clock;
reg reset;
reg [8*80-1:0] filename;
wire [0:31] PC;
wire [0:31]busWout,instructionOut;

top_level top(clock,reset);

// assign PC = {top.instructionfetch.PCout,2'b00};

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

//   $monitor("Instruction = %h  PC = %h\n\tIFU\n\t\tTarget = %h\n\t\ttakeBranch = %b\n\t\tjType = %b\n\t\treset = %b\n\t\tregJump = %b\n\t\tlinkTarget = %h\n\tDECODER\n\t\trs1 = %d\n\t\trs2 = %d\n\t\trd = %d\n\t\timmediate = %h\n\t\talu_signals = %b\n\t\tmem_size = %b\n\t\tmem_write = %b\n\t\tmem_ext = %b\n\t\treg_write = %b\n\t\tbranch_instr = %b\n\t\tjump_instr = %b\n\t\treg_data = %b\n\t\tI_type = %b\n\t\tbne = %b\n\t\tbeq = %b\n\t\tlink = %b\n\tREGISTERS\n\t\treg_data_in = %h\n\t\twrite_en = %b\n\t\taddr1 = %d\n\t\taddr2 = %d\n\t\twraddr = %d\n\t\tregA = %h\n\t\tregB = %h\n\tALU\n\t\tA = (HEX)%h   (DEC)%d\n\t\tB = (HEX)%h    (DEC)%d\n\t\talu_controls = %b\n\t\tzero = %b\n\t\talu_out = (HEX)%h    (DEC)%d\n\tDATA_MEMORY\n\t\taddr = %h\n\t\twData = %h\n\t\twriteEnable = %b\n\t\tdsize = %b\n\t\tmem_ext = %b\n\t\tdata_mem_out = %h\n\n",top.instruction,top.instructionfetch.PCout,top.instruction,top.Branch,top.jump_instruction,top.rst,top.Jump,top.instruction,top.RS,top.RT,top.RD,top.immed,top.ALUCtr,top.tmp,top.MemWr,top.tmp,top.RegWr,top.branch_instruction,top.jump_instruction,top.busWr,top.tmp,top.Branch_NotEqual,top.Branch,top.tmp,top.busWr,top.RegWr,top.RS,top.RT,top.WrAddr,top.busA,top.busB,top.busA,top.busA,top.bIN,top.bIN,top.ALUCtr,top.Zero,top.ALUOut,top.ALUOut,top.ALUOut,top.busB,top.MemWr,top.tmp,top.tmp,top.MemOut);
// $monitor("Clock = %b; Instruction = %h PC = %h imm=%h addrout=%h target=%h rs=%d rt=%d rd = %d", top.clk, top.instruction, top.instructionfetch.PCout, top.instructionfetch.immediate26, top.instructionfetch.jumpMUXout,  top.instructionfetch.PCin, top.RS, top.RT, top.RD); 
    // $monitor("\n clk=%b reset=%b instruction=%h pc=%h r0=%x r1=%x r2=%x r3=%x r4=%x r5=%x r6=%x r7=%x r8=%x imm16=%h aluout=%h aluOrMultOut=%h busW=%h",
    //         clock,reset,top.instruction,top.instructionAddr,
    //         top.REGFILE.reg_out[0],top.REGFILE.reg_out[1],top.REGFILE.reg_out[2],top.REGFILE.reg_out[3],
    //         top.REGFILE.reg_out[4],top.REGFILE.reg_out[5],top.REGFILE.reg_out[6],top.REGFILE.reg_out[7],top.REGFILE.reg_out[8],
    //         top.imm16,top.aluOut,top.aluOrMultOut,top.busW);


    // $monitor("\n clk=%b reset=%b instruction=%h pc=%h r0=%x r1=%x r2=%x r3=%x r4=%x imm16=%h aluout=%h aluOrMultOut=%h busW=%h,dmem_addr=%h dmem_dout=%h dmem_write=%h",
    //         clock,reset,top.instruction,top.instructionAddr,
    //         top.SINGLE_CYCLE.REGFILE.reg_out[0],top.SINGLE_CYCLE.REGFILE.reg_out[1],top.SINGLE_CYCLE.REGFILE.reg_out[2],top.SINGLE_CYCLE.REGFILE.reg_out[3],
    //         top.SINGLE_CYCLE.REGFILE.reg_out[4],
    //         top.SINGLE_CYCLE.imm16,top.SINGLE_CYCLE.aluOut,top.SINGLE_CYCLE.aluOrMultOut,top.SINGLE_CYCLE.busW,
    //         top.dmem_addr,top.dmem_read,top.dmem_write);

//$monitor("Clock = %b; Instruction = %h PC = %h imm=%h addrout=%h target=%h rs=%d rt=%d rd = %d busA=%d busB=%d bIN=%d ALUSrc=%b ALUOut=(hex)%h (dec)%d ALUCtr=%b \n MemOut=%h busWr=%h WrAddr=%d RegWr=%b Mem2Reg=%b Branch=%b Jump=%b Branch_instruction = %h Zero =%b \n Jump_Link=%b WrAddr = %h JALcheck=%b Reg[1] = %h Reg[31] = %h\n", top.clk, top.instruction, top.instructionfetch.PCout, top.instructionfetch.immediate26, top.instructionfetch.jumpMUXout,  top.instructionfetch.PCin, top.RS, top.RT, top.RD, top.busA, top.busB, top.bIN, top.ALUSrc, top.ALUOut, top.ALUOut, top.ALUCtr, top.MemOut, top.busWr, top.WrAddr, top.RegWr, top.Mem2Reg, top.instructionfetch.andBranch, top.Jump, top.branch_instruction, top.Zero, top.Jump_Link, top.WrAddr, top.instructionfetch.JALcheck, top.rFile.reg_file[1], top.rFile.reg_file[31]); 
	
// iter=0;
    $monitor("clk=%b rst=%b Instruction=%h PC=%h r1=%h r2=%h r3=%h r4=%h r5=%h r6=%h f1=%h f2=%h f3=%h f4=%h f5=%h r29=%h f30=%h r31=%h",
      top.clk,top.reset,top.imem_out,top.imem_addr,
      top.PIPELINE.REG_FILE.reg_out[1],top.PIPELINE.REG_FILE.reg_out[2],
      top.PIPELINE.REG_FILE.reg_out[3],top.PIPELINE.REG_FILE.reg_out[4],
      top.PIPELINE.REG_FILE.reg_out[5],top.PIPELINE.REG_FILE.reg_out[6],
      top.PIPELINE.FP_REG_FILE.reg_out[1],top.PIPELINE.FP_REG_FILE.reg_out[2],
      top.PIPELINE.FP_REG_FILE.reg_out[3],top.PIPELINE.FP_REG_FILE.reg_out[4],
      top.PIPELINE.FP_REG_FILE.reg_out[5],
      top.PIPELINE.REG_FILE.reg_out[29],top.PIPELINE.REG_FILE.reg_out[30],top.PIPELINE.REG_FILE.reg_out[31]
    );

   #0 clock=0; reset=0; 
   #2 reset=0;
   #2 reset=1;

   #400; 
   $finish;
end

// attempt to finish before we're supposed to (before #5000 steps)
reg [0:31] instr;

always @(posedge clock) begin
    // $display("Evaluation number: %h",j);
  //This checks for a trap 0x300 (signifying the end of the file)

  // if (top.PIPELINE.)

  if (top.PIPELINE.trap_mem == 1'b1) begin	
   
	$display("Hitting a trap, end, waiting 1 clock cycle and finishing");
	#20;
  $writememh("datamem_end",top.DATA_MEM.mem);
	$finish;
	
	end
end

endmodule
