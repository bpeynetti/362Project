
//-------------
// File: control_test.v
// Purpose: Verilog Test Control Module  - Simulation
//--------------

module testbench;
	//declare signals
    reg [0:31] instruction;
    wire PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul, extOp, LHIOp,loadSign;
    wire [0:1] DSize;
    wire [0:3] ALUCtrl;
    
    reg [0:4] r1,r2,rd;
    reg [0:6] opcode;
    reg [0:15] imm16;
    reg [0:25] imm26;
    reg [0:5] func;
    reg [0:4] unused;

    //wire signals together
	control CTRL (
	    .instruction(instruction),
	    .PCtoReg(PCtoReg),
	    .regToPC(regToPC),
	    .jump(jump),
	    .branch(branch),
	    .branchZero(branchZero),
	    .RType(RType),
	    .RegWrite(RegWrite),
	    .MemToReg(MemToReg),
	    .MemWrite(MemWrite),
	    .mul(mul),
	    .extOp(extOp),
	    .LHIOp(LHIOp),
	    .DSize(DSize),
	    .ALUCtrl(ALUCtrl),
	    .loadSign(loadSign)
	);

	initial
	begin
	    $dumpfile("tests/test_control.vcd");
    	$dumpvars(0);
		//reset 
		
		unused = 6'd0;
		//start
// 		instruction = 32'h00000000;
		$display("Starting test ");
		$display("r-type instructions");
		#1;
		//r-type instruction
		$display("Add r3=r1+r2");
		opcode = 6'h0;
		func = 6'h20;
		r1=5'd1;
		r2=5'd2;
		rd=5'd3;
		#1;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		$display("Sub r3=r1-r2");
		func = 6'h22;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sll");
		func = 6'h4;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("srl");
		func = 6'h6;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sra");
		func = 6'h7;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("nop");
		func = 6'h15;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("and");
		func = 6'h24;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("or");
		func = 6'h25;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("xor");
		func = 6'h26;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("seq");
		func = 6'h28;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sne");
		func = 6'h29;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("slt");
		func = 6'h2a;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sgt");
		func = 6'h2b;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sle");
		func = 6'h2c;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("sge");
		func = 6'h2d;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("multiply");
		opcode = 6'h01;
		func = 6'h0e;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		
		$display("multiply unsigned");
		opcode = 6'h1;
		func = 6'h16;
		instruction = {opcode,r1,r2,rd,unused,func};
		#1;
		//immediate-type  (start with branching)
		
		$display("jump to imm26");
		opcode = 6'h2;
		imm26 = 26'h1919;
	    instruction = {opcode,imm26};
        #1;
        
        $display("jalr");
        opcode = 6'h13;
		imm26 = 26'h1919;
	    instruction = {opcode,imm26};
        #1;
		
		$display("jr ");
		opcode = 6'h12;
		instruction = {opcode,imm26};
		#1;
		
		$display("beqz");
		opcode = 6'h4;
		r1=5'h1;
		r2=5'h2;
		imm16=16'h23;
		instruction = {opcode,r1,r2,imm16};
		#1;
		
		$display("bnez");
		opcode = 6'h5;
		r1=5'h1;
		r2=5'h2;
		imm16=16'h23;
		instruction = {opcode,r1,r2,imm16};
		#1;
		
		$display("addi r5 = r1+Imm16");
		opcode = 6'h8;
		rd = 5'h5;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("addui");
		opcode = 6'h9;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("subi");
		opcode = 6'ha;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("subui");
		opcode = 6'hb;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("lhi");
		opcode = 6'hf;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("andi");
		opcode = 6'hc;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("ori");
		opcode = 6'hd;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("xori");
		opcode = 6'he;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("slli");
		opcode = 6'h14;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("srli");
		opcode = 6'h16;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("srai");
		opcode = 6'h17;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("seqi");
		opcode = 6'h18;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("snei");
		opcode = 6'h19;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("slti");
		opcode = 6'h1a;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("sgti");
		opcode = 6'h1b;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("slei");
		opcode = 6'h1c;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("sgei");
		opcode = 6'h1d;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		//load and store instructions
		$display("\n ----- LOAD AND STORE ");
		$display("lb");
		opcode = 6'h20;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("lh");
		opcode = 6'h21;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("lw");
		opcode = 6'h23;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("lbu");
		opcode = 6'h24;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("lhu");
		opcode = 6'h25;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("sb");
		opcode = 6'h28;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("sh");
		opcode = 6'h29;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		
		$display("sw");
		opcode = 6'h2b;
		r1 = 5'h1;
		rd = 5'h2;
		imm16 = 16'h29;
		instruction = {opcode,r1,rd,imm16};
		#1;
		

		$finish;
	end

	initial
	begin
	//PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg, MemWrite, mul, extOp, LHIOp
		$monitor("Instruction=%h, PCtoReg=%x regToPC=%x jump=%x branch=%x branchZero=%x RType=%x RegWrite=%x MemToReg=%x MemWrite=%x mul=%x extOp=%x LHIOp=%x Dsize=%x ALUCtrl=%x loadSign=%x",
		        instruction, PCtoReg,regToPC,jump,branch,branchZero,RType,RegWrite,MemToReg,MemWrite,mul,extOp,LHIOp,DSize,ALUCtrl,loadSign);
	end
endmodule