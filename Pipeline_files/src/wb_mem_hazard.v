module wb_mem_hazard(
	//inputs from first instruction (in writeback stage)
	regWrite_wb, rd_wb,
	//inputs from second instruction (in memory stage)
	store_mem, rs_mem,
	//output: the control bit for whether there is a write after read (WAR) hazard (store after writing to register)
	store_hazard
);

	input regWrite_wb;
	input [0:4] rd_wb;
	input store_mem;
	input [0:4] rs_mem;
	output store_hazard;
	
	wire [0:4] rs_xor;
	wire rs_equal;
	
	xor_5 XOR_RS(
		.X(rd_wb),
		.Y(rs_mem),
		.Z(rs_xor)
	);
	
	zero_5bit RS_CHECK_EQUAL(
		.X(rs_xor),
		.z(rs_equal)
	);
	
	assign store_hazard = rs_equal & regWrite_wb & store_mem;
	
endmodule