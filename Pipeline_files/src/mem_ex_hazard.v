module mem_ex_hazard(
	//inputs from first instruction (in memory stage)
	regWrite_mem, rd_mem, load_mem,
	//inputs from second instruction (in execution stage)
	jumpNonReg_ex, RType_ex, store_ex, rs1_ex, rs2_ex,
	//output: the two control bits for rs1 and rs2 in the execution stage
	rs1_hazard, rs2_hazard,store_hazard
);
	input regWrite_mem;
	input [0:4] rd_mem;
	input load_mem;
	input jumpNonReg_ex;
	input RType_ex;
	input store_ex;
	input [0:4] rs1_ex;
	input [0:4] rs2_ex;
	output rs1_hazard;
	output rs2_hazard;
	output store_hazard;
	wire [0:4] rs1_xor, rs2_xor;
	wire rs1_equal, rs2_equal;
	xor_5 XOR_RS1(
		.X(rd_mem),
		.Y(rs1_ex),
		.Z(rs1_xor)
	);
	xor_5 XOR_RS2(
		.X(rd_mem),
		.Y(rs2_ex),
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
	assign rs1_hazard = rs1_equal & regWrite_mem & (~load_mem) & (~jumpNonReg_ex) & (~store_ex);
	assign rs2_hazard = rs2_equal & regWrite_mem & (~load_mem) & (~jumpNonReg_ex) & (RType_ex);
	assign store_hazard = rs2_equal & regWrite_mem & store_ex;
endmodule