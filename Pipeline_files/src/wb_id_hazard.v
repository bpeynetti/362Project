module wb_id_hazard(
	//inputs 
	rs1_id,rs2_id,rd_wb,we_wb,
	//outputs 
	wb_id_hazard_rs1,wb_id_hazard_rs2
);

	input [0:4] rs1_id,rs2_id,rd_wb;
	input we_wb;
	output wb_id_hazard_rs1,wb_id_hazard_rs2;
	
	wire [0:4] rs1_xor, rs2_xor;
	wire rs1_equal, rs2_equal;
	
	xor_5 XOR_S1(
		.X(rd_wb),
		.Y(rs1_id),
		.Z(rs1_xor)
	);
	
	xor_5 XOR_S2(
		.X(rd_wb),
		.Y(rs2_id),
		.Z(rs2_xor)
	);
	
	zero_5bit CHECK_RS1_EQUAL(
		.X(rs1_xor),
		.z(rs1_equal)
	);
	
	zero_5bit CHECK_RS2_EQUAL(
		.X(rs2_xor),
		.z(rs2_equal)
	);
	
	assign wb_id_hazard_rs1 = rs1_equal & we_wb;
	assign wb_id_hazard_rs2 = rs2_equal & we_wb;

endmodule