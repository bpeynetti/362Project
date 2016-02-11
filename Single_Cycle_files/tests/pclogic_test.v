//-------------
// File: pclogic_test.v
// Purpose: Verilog Test PC Logic  - Simulation
//--------------

module testbench;

	//declare signals
    reg [0:15] imm16;
    reg [0:25] imm26;
    reg [0:31] alu_out, reg_out;
    reg branch, branchOrJmp, regToPC; //control signals
    reg clk; //clock signal
    reg reset; //reset signal
    wire [0:31] instruction;

    //wire signals together
	pc_logic PCLOGIC (
		.imm16(imm16), 
		.imm26(imm26), 
		.alu_out(alu_out), 
		.reg_out(reg_out),
		.branch(branch), 
		.branchOrJmp(branchOrJmp), 
		.regToPC(regToPC), 
		.clk(clk), 
		.reset(reset),
		.instruction(instruction)
	);

	//make a clock
	always 
		#5 clk = ~clk;


	initial
	begin
	    $dumpfile("test_pclogic.vcd");
    	$dumpvars(0);
		//reset 
		clk = 1'b0;
		reset = 1'b1;
		imm16 = 16'h1020;
		imm26 = 26'h0003000;
		alu_out = 32'h00000001;
		reg_out = 32'h00000001;
		branch = 1'b0;
		branchOrJmp = 1'b0;
		regToPC = 1'b0;

		// START
		#10 reset = 1'b0;
		//wait for 5 cycles (5*10=50)
		$display("Should just add 4 each posedge clk");
		#50; 
		$display("Now branch (takes imm16)");
		branch = 1'b1;
		#10;
		branch = 1'b0;
		$display("Now go again for a bit");
		#50;
		$display("Now take a jmp ");
		#1
		branch = 1'b1;
		branchOrJmp = 1'b1;
		#5;
		branch = 1'b0;
		#20;
		reg_out = 32'hbadbaddd;
		$display("Now load badbaddd into pc");
		regToPC = 1'b1;
		#15;
		regToPC = 1'b0;
		$display("And now just keep adding 4 at a time");
		#40;


		$finish;
	end

	initial
	begin
		$monitor("clk=%x reset=%x imm16=%x imm26=%x alu_out=%x reg_out=%x branch=%x branchOrJmp=%x regToPC=%x instruction=%x",clk,reset,imm16,imm26,alu_out,reg_out,branch,branchOrJmp,regToPC,instruction);
	end
endmodule