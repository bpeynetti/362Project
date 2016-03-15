
module mem_ex_hazard ( regWrite_mem, rd_mem, load_mem, jumpNonReg_ex, RType_ex, 
        store_ex, rs1_ex, rs2_ex, rs1_hazard, rs2_hazard, store_hazard );
  input [0:4] rd_mem;
  input [0:4] rs1_ex;
  input [0:4] rs2_ex;
  input regWrite_mem, load_mem, jumpNonReg_ex, RType_ex, store_ex;
  output rs1_hazard, rs2_hazard, store_hazard;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;

  NOR4_X2 U2 ( .A1(n2), .A2(n4), .A3(jumpNonReg_ex), .A4(load_mem), .ZN(
        rs2_hazard) );
  NAND4_X2 U3 ( .A1(n5), .A2(n6), .A3(n7), .A4(n8), .ZN(n4) );
  XOR2_X2 U5 ( .A(rs2_ex[3]), .B(rd_mem[3]), .Z(n10) );
  XOR2_X2 U6 ( .A(rs2_ex[4]), .B(rd_mem[4]), .Z(n9) );
  XNOR2_X2 U7 ( .A(rd_mem[1]), .B(rs2_ex[1]), .ZN(n7) );
  XNOR2_X2 U8 ( .A(rd_mem[0]), .B(rs2_ex[0]), .ZN(n6) );
  XNOR2_X2 U9 ( .A(rd_mem[2]), .B(rs2_ex[2]), .ZN(n5) );
  NOR4_X2 U10 ( .A1(n11), .A2(n12), .A3(n1), .A4(n13), .ZN(rs1_hazard) );
  XOR2_X2 U11 ( .A(rs1_ex[4]), .B(rd_mem[4]), .Z(n13) );
  OR3_X2 U12 ( .A1(load_mem), .A2(store_ex), .A3(jumpNonReg_ex), .ZN(n12) );
  NAND4_X2 U13 ( .A1(n14), .A2(n15), .A3(n16), .A4(n17), .ZN(n11) );
  XNOR2_X2 U14 ( .A(rd_mem[3]), .B(rs1_ex[3]), .ZN(n17) );
  XNOR2_X2 U15 ( .A(rd_mem[2]), .B(rs1_ex[2]), .ZN(n16) );
  XNOR2_X2 U16 ( .A(rd_mem[1]), .B(rs1_ex[1]), .ZN(n15) );
  XNOR2_X2 U17 ( .A(rd_mem[0]), .B(rs1_ex[0]), .ZN(n14) );
  INV_X4 U18 ( .A(regWrite_mem), .ZN(n1) );
  INV_X4 U19 ( .A(RType_ex), .ZN(n2) );
  INV_X4 U20 ( .A(store_ex), .ZN(n3) );
  NOR3_X2 U21 ( .A1(n9), .A2(n1), .A3(n10), .ZN(n8) );
  NOR2_X2 U22 ( .A1(n4), .A2(n3), .ZN(store_hazard) );
endmodule

