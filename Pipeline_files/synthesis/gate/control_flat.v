
module control ( instruction, PCtoReg, regToPC, jump, branch, branchZero, 
        RType, RegWrite, DSize, MemToReg, MemWrite, loadSign, ALUCtrl, mul_out, 
        extOp, LHIOp, jumpNonReg, FPRType_out, FPRegWrite_out, movfp2i_out, 
        movi2fp_out );
  input [0:31] instruction;
  output [0:1] DSize;
  output [0:3] ALUCtrl;
  output PCtoReg, regToPC, jump, branch, branchZero, RType, RegWrite, MemToReg,
         MemWrite, loadSign, mul_out, extOp, LHIOp, jumpNonReg, FPRType_out,
         FPRegWrite_out, movfp2i_out, movi2fp_out;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90;

  NAND4_X2 U5 ( .A1(instruction[2]), .A2(n30), .A3(instruction[5]), .A4(n15), 
        .ZN(extOp) );
  AND2_X2 U6 ( .A1(n22), .A2(branch), .ZN(branchZero) );
  NOR4_X2 U7 ( .A1(n31), .A2(MemWrite), .A3(movi2fp_out), .A4(branch), .ZN(
        RegWrite) );
  NAND2_X2 U9 ( .A1(n33), .A2(n34), .ZN(n31) );
  OR3_X2 U15 ( .A1(n22), .A2(instruction[2]), .A3(n36), .ZN(n37) );
  OR2_X2 U17 ( .A1(mul_out), .A2(movi2fp_out), .ZN(FPRegWrite_out) );
  NAND4_X2 U19 ( .A1(instruction[26]), .A2(RType), .A3(n38), .A4(
        instruction[27]), .ZN(n28) );
  AND4_X2 U20 ( .A1(instruction[29]), .A2(FPRType_out), .A3(n39), .A4(n40), 
        .ZN(mul_out) );
  XNOR2_X2 U21 ( .A(n24), .B(instruction[27]), .ZN(n40) );
  NAND2_X2 U24 ( .A1(n15), .A2(n17), .ZN(n41) );
  NAND4_X2 U27 ( .A1(n43), .A2(n7), .A3(n5), .A4(n44), .ZN(ALUCtrl[3]) );
  NOR4_X2 U29 ( .A1(instruction[1]), .A2(n14), .A3(n20), .A4(n16), .ZN(n46) );
  NAND4_X2 U30 ( .A1(n43), .A2(n7), .A3(n49), .A4(n50), .ZN(ALUCtrl[2]) );
  OAI22_X2 U32 ( .A1(n18), .A2(n12), .B1(n47), .B2(n54), .ZN(n51) );
  NAND2_X2 U33 ( .A1(instruction[28]), .A2(n27), .ZN(n54) );
  NAND4_X2 U36 ( .A1(n60), .A2(n3), .A3(n61), .A4(n62), .ZN(ALUCtrl[1]) );
  NOR4_X2 U37 ( .A1(n2), .A2(n48), .A3(n63), .A4(n64), .ZN(n62) );
  AND3_X2 U39 ( .A1(instruction[31]), .A2(instruction[30]), .A3(n68), .ZN(n67)
         );
  OR3_X2 U43 ( .A1(n1), .A2(n45), .A3(n64), .ZN(ALUCtrl[0]) );
  OAI22_X2 U44 ( .A1(n65), .A2(n12), .B1(n56), .B2(n72), .ZN(n64) );
  NAND2_X2 U45 ( .A1(instruction[31]), .A2(n25), .ZN(n72) );
  NAND4_X2 U46 ( .A1(n60), .A2(n3), .A3(n9), .A4(n73), .ZN(n45) );
  OAI22_X2 U50 ( .A1(n21), .A2(n12), .B1(n56), .B2(n76), .ZN(n53) );
  NAND2_X2 U51 ( .A1(n25), .A2(n27), .ZN(n76) );
  AND3_X2 U57 ( .A1(n38), .A2(n27), .A3(n71), .ZN(n79) );
  AOI221_X2 U58 ( .B1(n39), .B2(n68), .C1(n35), .C2(n66), .A(n63), .ZN(n49) );
  AND2_X2 U61 ( .A1(n81), .A2(instruction[26]), .ZN(n71) );
  AND2_X2 U62 ( .A1(n78), .A2(n26), .ZN(n38) );
  NAND2_X2 U63 ( .A1(instruction[5]), .A2(n20), .ZN(n65) );
  NAND2_X2 U67 ( .A1(instruction[3]), .A2(n8), .ZN(n32) );
  AND3_X2 U69 ( .A1(n78), .A2(n23), .A3(n81), .ZN(n68) );
  NAND4_X2 U72 ( .A1(n34), .A2(n15), .A3(n16), .A4(n20), .ZN(n29) );
  NAND4_X2 U73 ( .A1(n82), .A2(n83), .A3(n84), .A4(n85), .ZN(n34) );
  AND4_X2 U74 ( .A1(n86), .A2(n87), .A3(n88), .A4(n89), .ZN(n85) );
  NOR4_X2 U75 ( .A1(instruction[9]), .A2(instruction[8]), .A3(instruction[7]), 
        .A4(instruction[6]), .ZN(n89) );
  NOR4_X2 U76 ( .A1(instruction[31]), .A2(instruction[30]), .A3(instruction[2]), .A4(instruction[29]), .ZN(n88) );
  NOR4_X2 U77 ( .A1(instruction[28]), .A2(instruction[27]), .A3(
        instruction[26]), .A4(instruction[25]), .ZN(n87) );
  NOR4_X2 U79 ( .A1(n90), .A2(n21), .A3(instruction[10]), .A4(n14), .ZN(n84)
         );
  OR4_X2 U81 ( .A1(instruction[12]), .A2(instruction[11]), .A3(instruction[14]), .A4(instruction[13]), .ZN(n90) );
  NOR4_X2 U82 ( .A1(instruction[21]), .A2(instruction[20]), .A3(instruction[1]), .A4(instruction[19]), .ZN(n83) );
  NOR4_X2 U83 ( .A1(instruction[18]), .A2(instruction[17]), .A3(
        instruction[16]), .A4(instruction[15]), .ZN(n82) );
  INV_X4 U87 ( .A(n49), .ZN(n1) );
  INV_X4 U88 ( .A(n43), .ZN(n2) );
  INV_X4 U89 ( .A(n52), .ZN(n3) );
  INV_X4 U90 ( .A(n74), .ZN(n4) );
  INV_X4 U91 ( .A(n48), .ZN(n5) );
  INV_X4 U92 ( .A(n59), .ZN(n6) );
  INV_X4 U93 ( .A(n55), .ZN(n7) );
  INV_X4 U94 ( .A(instruction[0]), .ZN(n8) );
  INV_X4 U95 ( .A(n53), .ZN(n9) );
  INV_X4 U96 ( .A(n47), .ZN(n10) );
  INV_X4 U97 ( .A(RType), .ZN(n11) );
  INV_X4 U98 ( .A(n69), .ZN(n12) );
  INV_X4 U99 ( .A(jump), .ZN(n13) );
  INV_X4 U100 ( .A(n30), .ZN(n14) );
  INV_X4 U101 ( .A(instruction[1]), .ZN(n15) );
  INV_X4 U102 ( .A(instruction[2]), .ZN(n16) );
  INV_X4 U103 ( .A(instruction[3]), .ZN(n17) );
  INV_X4 U104 ( .A(n35), .ZN(n18) );
  INV_X4 U105 ( .A(n42), .ZN(n19) );
  INV_X4 U106 ( .A(instruction[4]), .ZN(n20) );
  INV_X4 U107 ( .A(n58), .ZN(n21) );
  INV_X4 U108 ( .A(instruction[5]), .ZN(n22) );
  INV_X4 U109 ( .A(instruction[26]), .ZN(n23) );
  INV_X4 U110 ( .A(instruction[28]), .ZN(n24) );
  INV_X4 U111 ( .A(instruction[29]), .ZN(n25) );
  INV_X4 U112 ( .A(instruction[30]), .ZN(n26) );
  INV_X4 U113 ( .A(instruction[31]), .ZN(n27) );
  OAI33_X1 U114 ( .A1(n56), .A2(n25), .A3(n27), .B1(n65), .B2(n15), .B3(n6), 
        .ZN(n48) );
  NOR2_X2 U115 ( .A1(n6), .A2(instruction[1]), .ZN(n74) );
  NOR2_X2 U116 ( .A1(instruction[4]), .A2(instruction[5]), .ZN(n58) );
  NAND3_X2 U117 ( .A1(instruction[28]), .A2(n26), .A3(n71), .ZN(n56) );
  NOR3_X2 U118 ( .A1(n15), .A2(instruction[2]), .A3(n32), .ZN(n66) );
  OAI21_X2 U119 ( .B1(n18), .B2(n4), .A(n77), .ZN(n52) );
  NAND3_X2 U120 ( .A1(n78), .A2(n39), .A3(n71), .ZN(n77) );
  NOR2_X2 U121 ( .A1(n20), .A2(n22), .ZN(n42) );
  AOI21_X2 U122 ( .B1(n58), .B2(n74), .A(n79), .ZN(n60) );
  NOR2_X2 U123 ( .A1(n26), .A2(instruction[31]), .ZN(n39) );
  AOI21_X2 U124 ( .B1(n42), .B2(n66), .A(n67), .ZN(n43) );
  OAI21_X2 U125 ( .B1(instruction[31]), .B2(n56), .A(n57), .ZN(n55) );
  NAND3_X2 U126 ( .A1(n58), .A2(instruction[1]), .A3(n59), .ZN(n57) );
  NOR3_X2 U127 ( .A1(n15), .A2(n14), .A3(n16), .ZN(n69) );
  NAND3_X2 U128 ( .A1(instruction[30]), .A2(n25), .A3(n71), .ZN(n47) );
  OAI21_X2 U129 ( .B1(n4), .B2(n65), .A(n80), .ZN(n63) );
  NAND3_X2 U130 ( .A1(instruction[31]), .A2(n38), .A3(n71), .ZN(n80) );
  AOI222_X1 U131 ( .A1(n42), .A2(n74), .B1(n75), .B2(n68), .C1(n66), .C2(n58), 
        .ZN(n73) );
  NOR2_X2 U132 ( .A1(instruction[31]), .A2(instruction[30]), .ZN(n75) );
  NAND3_X2 U133 ( .A1(n15), .A2(n17), .A3(instruction[0]), .ZN(n36) );
  NOR2_X2 U134 ( .A1(instruction[3]), .A2(instruction[0]), .ZN(n30) );
  NOR2_X2 U135 ( .A1(n20), .A2(instruction[5]), .ZN(n35) );
  NOR2_X2 U136 ( .A1(n27), .A2(n28), .ZN(movi2fp_out) );
  NOR3_X2 U137 ( .A1(n16), .A2(n35), .A3(n36), .ZN(MemWrite) );
  NOR2_X2 U138 ( .A1(n11), .A2(instruction[27]), .ZN(n81) );
  NOR2_X2 U139 ( .A1(n25), .A2(instruction[28]), .ZN(n78) );
  NOR2_X2 U140 ( .A1(n32), .A2(n16), .ZN(n59) );
  NOR3_X2 U141 ( .A1(instruction[22]), .A2(instruction[24]), .A3(
        instruction[23]), .ZN(n86) );
  NOR2_X2 U142 ( .A1(instruction[31]), .A2(n28), .ZN(movfp2i_out) );
  NOR3_X2 U143 ( .A1(n14), .A2(n22), .A3(n29), .ZN(FPRType_out) );
  NOR2_X2 U144 ( .A1(instruction[1]), .A2(n13), .ZN(jumpNonReg) );
  NOR2_X2 U145 ( .A1(n4), .A2(n19), .ZN(LHIOp) );
  AOI211_X2 U146 ( .C1(n10), .C2(n24), .A(n45), .B(n46), .ZN(n44) );
  NOR3_X2 U147 ( .A1(n51), .A2(n52), .A3(n53), .ZN(n50) );
  AOI21_X2 U148 ( .B1(n69), .B2(n42), .A(n70), .ZN(n61) );
  NOR3_X2 U149 ( .A1(n47), .A2(n24), .A3(n27), .ZN(n70) );
  NOR3_X2 U150 ( .A1(n8), .A2(instruction[3]), .A3(n29), .ZN(loadSign) );
  OAI21_X2 U151 ( .B1(n29), .B2(n8), .A(n37), .ZN(MemToReg) );
  AOI211_X2 U152 ( .C1(n29), .C2(n41), .A(n8), .B(n22), .ZN(DSize[1]) );
  NOR2_X2 U153 ( .A1(n36), .A2(n19), .ZN(DSize[0]) );
  NAND3_X2 U154 ( .A1(n30), .A2(n16), .A3(n35), .ZN(n33) );
  NOR3_X2 U155 ( .A1(n14), .A2(instruction[5]), .A3(n29), .ZN(RType) );
  NOR2_X2 U156 ( .A1(n32), .A2(n29), .ZN(branch) );
  NOR3_X2 U157 ( .A1(n14), .A2(instruction[2]), .A3(n20), .ZN(jump) );
  NOR2_X2 U158 ( .A1(n13), .A2(n15), .ZN(regToPC) );
  NOR2_X2 U159 ( .A1(n22), .A2(n13), .ZN(PCtoReg) );
endmodule

