module load_stall(
	//inputs from first instruction (in insturction decode stage)
	MemToReg_id, rd_id,
	//inputs from second instruction (in instruction fetch stage)
	instruction_if,
	//output: whether to stall the instruction in instruction fetch for 1 cycle
	stall
);

	input MemToReg_id;
	input [0:4] rd_id;
	input [0:31] instruction_if;
	output stall;
	
	wire [0:4] rs1, rs2, rs1_xor, rs2_xor;
	wire [0:5] opcode;
	wire rs1_equal, rs2_equal;
	wire jumpNonReg_if, RType_if, store_if;
	
	assign opcode = instruction_if[0:5];
	assign rs1 = instruction_if[6:10];
	assign rs2 = instruction_if[11:15];
	
	assign jumpNonReg_if =  ~(opcode[0] | opcode[1] | opcode[2] | opcode[3] ) & opcode[4];
	assign RType_if = (~opcode[0]) & (~opcode[1]) & (~opcode[2]) & (~opcode[3]) & (~opcode[4]) & (~opcode[5]);
	assign store_if = opcode[0] & (~opcode[1]) & opcode[2] & (~opcode[3]) & ((~opcode[4]) | (opcode[4] & opcode[5]));
	
	xor_5 XOR_RS1(
		.X(rd_id),
		.Y(rs1),
		.Z(rs1_xor)
	);
	
	xor_5 XOR_RS2(
		.X(rd_id),
		.Y(rs2),
		.Z(rs2_xor)
	);
	
	zero_5bit RS1_CHECK_EQUAL(
		.X(rs1_xor),
		.z(rs1_equal)
	);
	
	zero_5bit RS2_CHECK_EQUAL(
		.X(rs2_xor),
		.z(rs2_equal)
	);
	
	assign stall = (rs1_equal & MemToReg_id & (~jumpNonReg_if) & (~store_if)) | (rs2_equal & MemToReg_id & (~jumpNonReg_if) & (RType_if | store_if));
	
endmodule