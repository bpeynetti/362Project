
module instruction_decode ( nextPC_in, instruction_in, clk, reset, busA_in, 
        busB_in, nextPC_out, PCtoReg_out, RegToPC_out, jump_out, branch_out, 
        branchZero_out, RType_out, RegWrite_out, MemToReg_out, MemWrite_out, 
        loadSign_out, mul_out, extOp_out, LHIOp_out, DSize_out, ALUCtrl_out, 
        imm16_out, imm26_out, busA_out, busB_out, destReg, memVal_out, 
        jumpNonReg_out, r1_out, r2_out, trap_out, FPRType_out, FPRegWrite_out, 
        movi2fp_out, movfp2i_out );
  input [0:31] nextPC_in;
  input [0:31] instruction_in;
  input [0:31] busA_in;
  input [0:31] busB_in;
  output [0:31] nextPC_out;
  output [0:1] DSize_out;
  output [0:3] ALUCtrl_out;
  output [0:15] imm16_out;
  output [0:25] imm26_out;
  output [0:31] busA_out;
  output [0:31] busB_out;
  output [0:4] destReg;
  output [0:31] memVal_out;
  output [0:4] r1_out;
  output [0:4] r2_out;
  input clk, reset;
  output PCtoReg_out, RegToPC_out, jump_out, branch_out, branchZero_out,
         RType_out, RegWrite_out, MemToReg_out, MemWrite_out, loadSign_out,
         mul_out, extOp_out, LHIOp_out, jumpNonReg_out, trap_out, FPRType_out,
         FPRegWrite_out, movi2fp_out, movfp2i_out;
  wire   n1, n2, n3, n4, n5, n21, n22, n24, n25, n26, n27, n199, n30, n31, n34,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n197, n198;

  NOR4_X2 U3 ( .A1(n67), .A2(n68), .A3(n69), .A4(n70), .ZN(trap_out) );
  NAND4_X2 U4 ( .A1(n47), .A2(n48), .A3(n49), .A4(n38), .ZN(n70) );
  OR4_X2 U5 ( .A1(instruction_in[6]), .A2(instruction_in[7]), .A3(
        instruction_in[8]), .A4(instruction_in[9]), .ZN(n69) );
  NAND4_X2 U6 ( .A1(n63), .A2(n64), .A3(n62), .A4(n71), .ZN(n68) );
  NOR4_X2 U7 ( .A1(instruction_in[12]), .A2(instruction_in[11]), .A3(
        instruction_in[10]), .A4(instruction_in[31]), .ZN(n71) );
  NAND4_X2 U8 ( .A1(n72), .A2(n73), .A3(n74), .A4(n75), .ZN(n67) );
  NOR4_X2 U9 ( .A1(instruction_in[27]), .A2(instruction_in[26]), .A3(
        instruction_in[25]), .A4(instruction_in[24]), .ZN(n75) );
  NOR4_X2 U10 ( .A1(instruction_in[21]), .A2(instruction_in[20]), .A3(
        instruction_in[19]), .A4(instruction_in[18]), .ZN(n74) );
  NOR4_X2 U11 ( .A1(instruction_in[17]), .A2(instruction_in[16]), .A3(n76), 
        .A4(n77), .ZN(n73) );
  OAI221_X2 U16 ( .B1(RType_out), .B2(n49), .C1(n81), .C2(n54), .A(n82), .ZN(
        destReg[4]) );
  OAI221_X2 U17 ( .B1(RType_out), .B2(n48), .C1(n81), .C2(n53), .A(n82), .ZN(
        destReg[3]) );
  OAI221_X2 U18 ( .B1(RType_out), .B2(n47), .C1(n81), .C2(n52), .A(n82), .ZN(
        destReg[2]) );
  OAI221_X2 U19 ( .B1(RType_out), .B2(n46), .C1(n81), .C2(n51), .A(n82), .ZN(
        destReg[1]) );
  OAI221_X2 U20 ( .B1(RType_out), .B2(n45), .C1(n81), .C2(n50), .A(n82), .ZN(
        destReg[0]) );
  NAND2_X2 U21 ( .A1(n83), .A2(n84), .ZN(busB_out[9]) );
  NAND2_X2 U22 ( .A1(busB_in[9]), .A2(RType_out), .ZN(n84) );
  NAND2_X2 U23 ( .A1(n83), .A2(n85), .ZN(busB_out[8]) );
  NAND2_X2 U24 ( .A1(busB_in[8]), .A2(RType_out), .ZN(n85) );
  NAND2_X2 U25 ( .A1(n83), .A2(n86), .ZN(busB_out[7]) );
  NAND2_X2 U26 ( .A1(busB_in[7]), .A2(RType_out), .ZN(n86) );
  NAND2_X2 U27 ( .A1(n83), .A2(n87), .ZN(busB_out[6]) );
  NAND2_X2 U28 ( .A1(busB_in[6]), .A2(RType_out), .ZN(n87) );
  NAND2_X2 U29 ( .A1(n83), .A2(n88), .ZN(busB_out[5]) );
  NAND2_X2 U30 ( .A1(busB_in[5]), .A2(RType_out), .ZN(n88) );
  NAND2_X2 U31 ( .A1(n83), .A2(n89), .ZN(busB_out[4]) );
  NAND2_X2 U32 ( .A1(busB_in[4]), .A2(RType_out), .ZN(n89) );
  NAND2_X2 U33 ( .A1(n83), .A2(n90), .ZN(busB_out[3]) );
  NAND2_X2 U34 ( .A1(busB_in[3]), .A2(RType_out), .ZN(n90) );
  AOI22_X2 U35 ( .A1(n199), .A2(busB_in[31]), .B1(instruction_in[31]), .B2(n92), .ZN(n91) );
  AOI22_X2 U36 ( .A1(n199), .A2(busB_in[30]), .B1(instruction_in[30]), .B2(n92), .ZN(n93) );
  NAND2_X2 U37 ( .A1(n83), .A2(n94), .ZN(busB_out[2]) );
  NAND2_X2 U38 ( .A1(busB_in[2]), .A2(RType_out), .ZN(n94) );
  AOI22_X2 U39 ( .A1(n199), .A2(busB_in[29]), .B1(instruction_in[29]), .B2(n92), .ZN(n95) );
  AOI22_X2 U40 ( .A1(n199), .A2(busB_in[28]), .B1(instruction_in[28]), .B2(n92), .ZN(n96) );
  AOI22_X2 U43 ( .A1(RType_out), .A2(busB_in[26]), .B1(instruction_in[26]), 
        .B2(n92), .ZN(n98) );
  AOI22_X2 U44 ( .A1(RType_out), .A2(busB_in[25]), .B1(n92), .B2(
        instruction_in[25]), .ZN(n99) );
  AOI22_X2 U45 ( .A1(RType_out), .A2(busB_in[24]), .B1(n92), .B2(
        instruction_in[24]), .ZN(n100) );
  AOI22_X2 U46 ( .A1(RType_out), .A2(busB_in[23]), .B1(instruction_in[23]), 
        .B2(n92), .ZN(n101) );
  AOI22_X2 U47 ( .A1(n199), .A2(busB_in[22]), .B1(instruction_in[22]), .B2(n92), .ZN(n102) );
  AOI22_X2 U48 ( .A1(RType_out), .A2(busB_in[21]), .B1(n92), .B2(
        instruction_in[21]), .ZN(n103) );
  AOI22_X2 U49 ( .A1(RType_out), .A2(busB_in[20]), .B1(instruction_in[20]), 
        .B2(n92), .ZN(n104) );
  NAND2_X2 U50 ( .A1(n83), .A2(n105), .ZN(busB_out[1]) );
  NAND2_X2 U51 ( .A1(busB_in[1]), .A2(RType_out), .ZN(n105) );
  AOI22_X2 U52 ( .A1(RType_out), .A2(busB_in[19]), .B1(instruction_in[19]), 
        .B2(n92), .ZN(n106) );
  AOI22_X2 U53 ( .A1(RType_out), .A2(busB_in[18]), .B1(instruction_in[18]), 
        .B2(n92), .ZN(n107) );
  AOI22_X2 U54 ( .A1(RType_out), .A2(busB_in[17]), .B1(instruction_in[17]), 
        .B2(n92), .ZN(n108) );
  AOI22_X2 U55 ( .A1(n199), .A2(busB_in[16]), .B1(instruction_in[16]), .B2(n92), .ZN(n109) );
  NAND2_X2 U56 ( .A1(n83), .A2(n110), .ZN(busB_out[15]) );
  NAND2_X2 U57 ( .A1(busB_in[15]), .A2(RType_out), .ZN(n110) );
  NAND2_X2 U58 ( .A1(n83), .A2(n111), .ZN(busB_out[14]) );
  NAND2_X2 U59 ( .A1(busB_in[14]), .A2(RType_out), .ZN(n111) );
  NAND2_X2 U60 ( .A1(n83), .A2(n112), .ZN(busB_out[13]) );
  NAND2_X2 U61 ( .A1(busB_in[13]), .A2(RType_out), .ZN(n112) );
  NAND2_X2 U62 ( .A1(n83), .A2(n113), .ZN(busB_out[12]) );
  NAND2_X2 U63 ( .A1(busB_in[12]), .A2(RType_out), .ZN(n113) );
  NAND2_X2 U64 ( .A1(n83), .A2(n114), .ZN(busB_out[11]) );
  NAND2_X2 U65 ( .A1(busB_in[11]), .A2(RType_out), .ZN(n114) );
  NAND2_X2 U66 ( .A1(n83), .A2(n115), .ZN(busB_out[10]) );
  NAND2_X2 U67 ( .A1(busB_in[10]), .A2(RType_out), .ZN(n115) );
  NAND2_X2 U68 ( .A1(n83), .A2(n116), .ZN(busB_out[0]) );
  NAND2_X2 U69 ( .A1(busB_in[0]), .A2(RType_out), .ZN(n116) );
  NAND4_X2 U72 ( .A1(instruction_in[2]), .A2(n34), .A3(instruction_in[5]), 
        .A4(n37), .ZN(extOp_out) );
  NAND2_X2 U74 ( .A1(busA_in[31]), .A2(n198), .ZN(n117) );
  NAND2_X2 U76 ( .A1(busA_in[30]), .A2(n197), .ZN(n118) );
  NAND2_X2 U78 ( .A1(busA_in[29]), .A2(n198), .ZN(n119) );
  NAND2_X2 U80 ( .A1(busA_in[28]), .A2(n197), .ZN(n120) );
  NAND2_X2 U82 ( .A1(busA_in[27]), .A2(n198), .ZN(n121) );
  NAND2_X2 U84 ( .A1(busA_in[26]), .A2(n198), .ZN(n122) );
  NAND2_X2 U86 ( .A1(busA_in[25]), .A2(n198), .ZN(n123) );
  NAND2_X2 U88 ( .A1(busA_in[24]), .A2(n198), .ZN(n124) );
  NAND2_X2 U90 ( .A1(busA_in[23]), .A2(n198), .ZN(n125) );
  NAND2_X2 U92 ( .A1(busA_in[22]), .A2(n198), .ZN(n126) );
  NAND2_X2 U94 ( .A1(busA_in[21]), .A2(n198), .ZN(n127) );
  NAND2_X2 U96 ( .A1(busA_in[20]), .A2(n198), .ZN(n128) );
  NAND2_X2 U98 ( .A1(busA_in[19]), .A2(n198), .ZN(n129) );
  NAND2_X2 U100 ( .A1(busA_in[18]), .A2(n198), .ZN(n130) );
  NAND2_X2 U102 ( .A1(busA_in[17]), .A2(n198), .ZN(n131) );
  NAND2_X2 U104 ( .A1(busA_in[16]), .A2(n198), .ZN(n132) );
  AND2_X2 U106 ( .A1(busA_in[9]), .A2(n21), .ZN(busA_out[9]) );
  AND2_X2 U107 ( .A1(busA_in[8]), .A2(n21), .ZN(busA_out[8]) );
  AND2_X2 U108 ( .A1(busA_in[7]), .A2(n21), .ZN(busA_out[7]) );
  AND2_X2 U109 ( .A1(busA_in[6]), .A2(n21), .ZN(busA_out[6]) );
  AND2_X2 U110 ( .A1(busA_in[5]), .A2(n197), .ZN(busA_out[5]) );
  AND2_X2 U111 ( .A1(busA_in[4]), .A2(n21), .ZN(busA_out[4]) );
  AND2_X2 U112 ( .A1(busA_in[3]), .A2(n21), .ZN(busA_out[3]) );
  AND2_X2 U113 ( .A1(busA_in[2]), .A2(n21), .ZN(busA_out[2]) );
  AND2_X2 U114 ( .A1(busA_in[1]), .A2(n198), .ZN(busA_out[1]) );
  AND2_X2 U115 ( .A1(busA_in[15]), .A2(n197), .ZN(busA_out[15]) );
  AND2_X2 U116 ( .A1(busA_in[14]), .A2(n198), .ZN(busA_out[14]) );
  AND2_X2 U117 ( .A1(busA_in[13]), .A2(n197), .ZN(busA_out[13]) );
  AND2_X2 U118 ( .A1(busA_in[12]), .A2(n198), .ZN(busA_out[12]) );
  AND2_X2 U119 ( .A1(busA_in[11]), .A2(n197), .ZN(busA_out[11]) );
  AND2_X2 U120 ( .A1(busA_in[10]), .A2(n198), .ZN(busA_out[10]) );
  AND2_X2 U121 ( .A1(busA_in[0]), .A2(n21), .ZN(busA_out[0]) );
  NOR4_X2 U123 ( .A1(instruction_in[2]), .A2(PCtoReg_out), .A3(n76), .A4(n43), 
        .ZN(n136) );
  NAND2_X2 U125 ( .A1(n138), .A2(n139), .ZN(n133) );
  NAND2_X2 U127 ( .A1(jump_out), .A2(instruction_in[5]), .ZN(n82) );
  NAND2_X2 U133 ( .A1(n78), .A2(n27), .ZN(FPRegWrite_out) );
  NAND4_X2 U135 ( .A1(instruction_in[26]), .A2(RType_out), .A3(n144), .A4(
        instruction_in[27]), .ZN(n79) );
  NAND4_X2 U136 ( .A1(instruction_in[29]), .A2(FPRType_out), .A3(n145), .A4(
        n146), .ZN(n78) );
  XOR2_X2 U137 ( .A(instruction_in[28]), .B(instruction_in[27]), .Z(n146) );
  NAND2_X2 U140 ( .A1(n37), .A2(n39), .ZN(n147) );
  AND2_X2 U141 ( .A1(n40), .A2(n140), .ZN(DSize_out[0]) );
  NAND4_X2 U143 ( .A1(n3), .A2(n148), .A3(n22), .A4(n149), .ZN(ALUCtrl_out[3])
         );
  NOR4_X2 U145 ( .A1(instruction_in[1]), .A2(n76), .A3(n43), .A4(n38), .ZN(
        n151) );
  NAND4_X2 U146 ( .A1(n3), .A2(n148), .A3(n154), .A4(n155), .ZN(ALUCtrl_out[2]) );
  NAND4_X2 U152 ( .A1(n4), .A2(n5), .A3(n166), .A4(n167), .ZN(ALUCtrl_out[1])
         );
  NOR4_X2 U153 ( .A1(n165), .A2(n153), .A3(n168), .A4(n169), .ZN(n167) );
  OAI22_X2 U154 ( .A1(n142), .A2(n170), .B1(n171), .B2(n172), .ZN(n165) );
  NAND2_X2 U155 ( .A1(instruction_in[31]), .A2(instruction_in[30]), .ZN(n172)
         );
  AOI22_X2 U156 ( .A1(n173), .A2(n150), .B1(n31), .B2(n40), .ZN(n166) );
  NOR4_X2 U162 ( .A1(n175), .A2(n157), .A3(n158), .A4(n177), .ZN(n152) );
  OAI221_X2 U163 ( .B1(n142), .B2(n143), .C1(n170), .C2(n163), .A(n178), .ZN(
        n177) );
  NAND2_X2 U165 ( .A1(instruction_in[4]), .A2(instruction_in[5]), .ZN(n142) );
  OAI22_X2 U170 ( .A1(n143), .A2(n42), .B1(n174), .B2(n180), .ZN(n157) );
  NAND2_X2 U171 ( .A1(n181), .A2(n145), .ZN(n180) );
  OAI22_X2 U172 ( .A1(n163), .A2(n143), .B1(n174), .B2(n183), .ZN(n175) );
  NAND2_X2 U173 ( .A1(n144), .A2(n65), .ZN(n183) );
  AOI221_X2 U174 ( .B1(n145), .B2(n24), .C1(n1), .C2(n182), .A(n168), .ZN(n154) );
  OAI22_X2 U175 ( .A1(n77), .A2(n143), .B1(n174), .B2(n184), .ZN(n168) );
  NAND2_X2 U176 ( .A1(instruction_in[31]), .A2(n144), .ZN(n184) );
  AND2_X2 U177 ( .A1(n181), .A2(n64), .ZN(n144) );
  NAND2_X2 U178 ( .A1(n185), .A2(instruction_in[26]), .ZN(n174) );
  OR2_X2 U179 ( .A1(n164), .A2(instruction_in[1]), .ZN(n143) );
  NAND2_X2 U180 ( .A1(n138), .A2(instruction_in[2]), .ZN(n164) );
  NAND2_X2 U181 ( .A1(instruction_in[5]), .A2(n43), .ZN(n77) );
  NOR4_X2 U188 ( .A1(n135), .A2(instruction_in[1]), .A3(instruction_in[2]), 
        .A4(instruction_in[4]), .ZN(n139) );
  AND4_X2 U189 ( .A1(n186), .A2(n187), .A3(n188), .A4(n189), .ZN(n135) );
  NAND4_X2 U191 ( .A1(n55), .A2(n56), .A3(n57), .A4(n58), .ZN(n192) );
  NAND4_X2 U192 ( .A1(n59), .A2(n60), .A3(n61), .A4(n62), .ZN(n191) );
  NAND4_X2 U193 ( .A1(n34), .A2(n50), .A3(n41), .A4(n193), .ZN(n190) );
  NOR4_X2 U194 ( .A1(instruction_in[20]), .A2(instruction_in[19]), .A3(
        instruction_in[18]), .A4(instruction_in[17]), .ZN(n193) );
  NAND2_X2 U195 ( .A1(n43), .A2(n44), .ZN(n163) );
  NOR4_X2 U196 ( .A1(n194), .A2(instruction_in[29]), .A3(instruction_in[31]), 
        .A4(instruction_in[30]), .ZN(n188) );
  OR4_X2 U197 ( .A1(instruction_in[10]), .A2(instruction_in[11]), .A3(
        instruction_in[12]), .A4(instruction_in[13]), .ZN(n194) );
  NOR4_X2 U198 ( .A1(instruction_in[9]), .A2(instruction_in[8]), .A3(
        instruction_in[7]), .A4(instruction_in[6]), .ZN(n187) );
  NOR4_X2 U199 ( .A1(instruction_in[2]), .A2(instruction_in[1]), .A3(
        instruction_in[15]), .A4(instruction_in[14]), .ZN(n186) );
  NAND2_X2 U200 ( .A1(n39), .A2(n36), .ZN(n76) );
  INV_X4 U203 ( .A(n170), .ZN(n1) );
  INV_X4 U204 ( .A(n152), .ZN(n2) );
  INV_X4 U205 ( .A(n165), .ZN(n3) );
  INV_X4 U206 ( .A(n175), .ZN(n4) );
  INV_X4 U207 ( .A(n157), .ZN(n5) );
  INV_X4 U208 ( .A(n109), .ZN(busB_out[16]) );
  INV_X4 U209 ( .A(n108), .ZN(busB_out[17]) );
  INV_X4 U210 ( .A(n107), .ZN(busB_out[18]) );
  INV_X4 U211 ( .A(n106), .ZN(busB_out[19]) );
  INV_X4 U212 ( .A(n104), .ZN(busB_out[20]) );
  INV_X4 U213 ( .A(n103), .ZN(busB_out[21]) );
  INV_X4 U214 ( .A(n102), .ZN(busB_out[22]) );
  INV_X4 U215 ( .A(n101), .ZN(busB_out[23]) );
  INV_X4 U216 ( .A(n100), .ZN(busB_out[24]) );
  INV_X4 U217 ( .A(n99), .ZN(busB_out[25]) );
  INV_X4 U218 ( .A(n98), .ZN(busB_out[26]) );
  INV_X4 U219 ( .A(n96), .ZN(busB_out[28]) );
  INV_X4 U220 ( .A(n95), .ZN(busB_out[29]) );
  INV_X4 U221 ( .A(n93), .ZN(busB_out[30]) );
  INV_X4 U222 ( .A(n91), .ZN(busB_out[31]) );
  INV_X4 U223 ( .A(LHIOp_out), .ZN(n21) );
  INV_X4 U224 ( .A(n153), .ZN(n22) );
  INV_X4 U225 ( .A(n133), .ZN(branch_out) );
  INV_X4 U226 ( .A(n171), .ZN(n24) );
  INV_X4 U227 ( .A(n169), .ZN(n25) );
  INV_X4 U228 ( .A(n161), .ZN(n26) );
  INV_X4 U229 ( .A(movi2fp_out), .ZN(n27) );
  INV_X4 U230 ( .A(n81), .ZN(n199) );
  INV_X4 U231 ( .A(n78), .ZN(mul_out) );
  INV_X4 U232 ( .A(n139), .ZN(n30) );
  INV_X4 U233 ( .A(n159), .ZN(n31) );
  INV_X4 U234 ( .A(n82), .ZN(PCtoReg_out) );
  INV_X4 U235 ( .A(n80), .ZN(jump_out) );
  INV_X4 U236 ( .A(n76), .ZN(n34) );
  INV_X4 U237 ( .A(n137), .ZN(MemWrite_out) );
  INV_X4 U238 ( .A(instruction_in[0]), .ZN(n36) );
  INV_X4 U239 ( .A(instruction_in[1]), .ZN(n37) );
  INV_X4 U240 ( .A(instruction_in[2]), .ZN(n38) );
  INV_X4 U241 ( .A(instruction_in[3]), .ZN(n39) );
  INV_X4 U242 ( .A(n142), .ZN(n40) );
  INV_X4 U243 ( .A(n163), .ZN(n41) );
  INV_X4 U244 ( .A(n182), .ZN(n42) );
  INV_X4 U245 ( .A(instruction_in[4]), .ZN(n43) );
  INV_X4 U246 ( .A(instruction_in[5]), .ZN(n44) );
  INV_X4 U247 ( .A(instruction_in[11]), .ZN(n45) );
  INV_X4 U248 ( .A(instruction_in[12]), .ZN(n46) );
  INV_X4 U249 ( .A(instruction_in[13]), .ZN(n47) );
  INV_X4 U250 ( .A(instruction_in[14]), .ZN(n48) );
  INV_X4 U251 ( .A(instruction_in[15]), .ZN(n49) );
  INV_X4 U252 ( .A(instruction_in[16]), .ZN(n50) );
  INV_X4 U253 ( .A(instruction_in[17]), .ZN(n51) );
  INV_X4 U254 ( .A(instruction_in[18]), .ZN(n52) );
  INV_X4 U255 ( .A(instruction_in[19]), .ZN(n53) );
  INV_X4 U256 ( .A(instruction_in[20]), .ZN(n54) );
  INV_X4 U257 ( .A(instruction_in[21]), .ZN(n55) );
  INV_X4 U258 ( .A(instruction_in[22]), .ZN(n56) );
  INV_X4 U259 ( .A(instruction_in[23]), .ZN(n57) );
  INV_X4 U260 ( .A(instruction_in[24]), .ZN(n58) );
  INV_X4 U261 ( .A(instruction_in[25]), .ZN(n59) );
  INV_X4 U262 ( .A(instruction_in[26]), .ZN(n60) );
  INV_X4 U263 ( .A(instruction_in[27]), .ZN(n61) );
  INV_X4 U264 ( .A(instruction_in[28]), .ZN(n62) );
  INV_X4 U265 ( .A(instruction_in[29]), .ZN(n63) );
  INV_X4 U266 ( .A(instruction_in[30]), .ZN(n64) );
  INV_X4 U268 ( .A(busB_in[27]), .ZN(n66) );
  OAI33_X1 U269 ( .A1(n26), .A2(n63), .A3(n65), .B1(n164), .B2(n77), .B3(n37), 
        .ZN(n153) );
  NOR2_X2 U270 ( .A1(n39), .A2(instruction_in[0]), .ZN(n138) );
  NAND3_X2 U271 ( .A1(instruction_in[1]), .A2(n34), .A3(instruction_in[2]), 
        .ZN(n159) );
  OAI21_X2 U272 ( .B1(n163), .B2(n159), .A(n179), .ZN(n158) );
  NAND3_X2 U273 ( .A1(n63), .A2(n65), .A3(n161), .ZN(n179) );
  INV_X4 U274 ( .A(instruction_in[31]), .ZN(n65) );
  NOR3_X2 U275 ( .A1(n62), .A2(instruction_in[30]), .A3(n174), .ZN(n161) );
  NOR2_X2 U276 ( .A1(n43), .A2(instruction_in[5]), .ZN(n182) );
  NOR2_X2 U277 ( .A1(n64), .A2(instruction_in[31]), .ZN(n145) );
  NOR3_X2 U278 ( .A1(n190), .A2(n191), .A3(n192), .ZN(n189) );
  AOI21_X2 U279 ( .B1(n65), .B2(n161), .A(n162), .ZN(n148) );
  NOR3_X2 U280 ( .A1(n163), .A2(n37), .A3(n164), .ZN(n162) );
  NOR3_X2 U281 ( .A1(n64), .A2(instruction_in[29]), .A3(n174), .ZN(n150) );
  NAND3_X2 U282 ( .A1(n24), .A2(n65), .A3(n64), .ZN(n178) );
  OAI21_X2 U283 ( .B1(n77), .B2(n159), .A(n176), .ZN(n169) );
  NAND3_X2 U284 ( .A1(instruction_in[31]), .A2(n63), .A3(n161), .ZN(n176) );
  NAND3_X2 U285 ( .A1(instruction_in[2]), .A2(n42), .A3(n140), .ZN(n137) );
  NOR2_X2 U286 ( .A1(n65), .A2(n79), .ZN(movi2fp_out) );
  NOR2_X2 U287 ( .A1(n81), .A2(instruction_in[27]), .ZN(n185) );
  NAND3_X2 U288 ( .A1(n181), .A2(n60), .A3(n185), .ZN(n171) );
  NOR2_X2 U289 ( .A1(n63), .A2(instruction_in[28]), .ZN(n181) );
  NAND3_X2 U290 ( .A1(instruction_in[1]), .A2(n38), .A3(n138), .ZN(n170) );
  NOR3_X2 U291 ( .A1(n37), .A2(n56), .A3(n57), .ZN(n72) );
  NAND3_X2 U292 ( .A1(instruction_in[16]), .A2(extOp_out), .A3(n92), .ZN(n83)
         );
  NOR2_X2 U293 ( .A1(n62), .A2(n65), .ZN(n173) );
  NOR3_X2 U294 ( .A1(instruction_in[1]), .A2(instruction_in[3]), .A3(n36), 
        .ZN(n140) );
  NAND3_X2 U295 ( .A1(n34), .A2(n38), .A3(instruction_in[4]), .ZN(n80) );
  NOR2_X2 U296 ( .A1(instruction_in[31]), .A2(n79), .ZN(movfp2i_out) );
  NOR3_X2 U297 ( .A1(n76), .A2(n44), .A3(n30), .ZN(FPRType_out) );
  NOR2_X2 U298 ( .A1(instruction_in[1]), .A2(n80), .ZN(jumpNonReg_out) );
  OAI21_X2 U299 ( .B1(n81), .B2(n66), .A(n97), .ZN(busB_out[27]) );
  OAI21_X2 U300 ( .B1(LHIOp_out), .B2(instruction_in[27]), .A(n81), .ZN(n97)
         );
  OAI21_X2 U301 ( .B1(n65), .B2(n197), .A(n117), .ZN(busA_out[31]) );
  OAI21_X2 U302 ( .B1(n64), .B2(n197), .A(n118), .ZN(busA_out[30]) );
  OAI21_X2 U303 ( .B1(n63), .B2(n197), .A(n119), .ZN(busA_out[29]) );
  OAI21_X2 U304 ( .B1(n62), .B2(n197), .A(n120), .ZN(busA_out[28]) );
  OAI21_X2 U305 ( .B1(n61), .B2(n197), .A(n121), .ZN(busA_out[27]) );
  OAI21_X2 U306 ( .B1(n60), .B2(n197), .A(n122), .ZN(busA_out[26]) );
  OAI21_X2 U307 ( .B1(n59), .B2(n197), .A(n123), .ZN(busA_out[25]) );
  OAI21_X2 U308 ( .B1(n58), .B2(n197), .A(n124), .ZN(busA_out[24]) );
  OAI21_X2 U309 ( .B1(n57), .B2(n198), .A(n125), .ZN(busA_out[23]) );
  OAI21_X2 U310 ( .B1(n56), .B2(n198), .A(n126), .ZN(busA_out[22]) );
  OAI21_X2 U311 ( .B1(n55), .B2(n197), .A(n127), .ZN(busA_out[21]) );
  OAI21_X2 U312 ( .B1(n54), .B2(n198), .A(n128), .ZN(busA_out[20]) );
  OAI21_X2 U313 ( .B1(n53), .B2(n198), .A(n129), .ZN(busA_out[19]) );
  OAI21_X2 U314 ( .B1(n52), .B2(n197), .A(n130), .ZN(busA_out[18]) );
  OAI21_X2 U315 ( .B1(n51), .B2(n197), .A(n131), .ZN(busA_out[17]) );
  OAI21_X2 U316 ( .B1(n50), .B2(n197), .A(n132), .ZN(busA_out[16]) );
  AOI211_X2 U317 ( .C1(n150), .C2(n62), .A(n2), .B(n151), .ZN(n149) );
  NOR3_X2 U318 ( .A1(n156), .A2(n157), .A3(n158), .ZN(n155) );
  OAI21_X2 U319 ( .B1(n159), .B2(n42), .A(n160), .ZN(n156) );
  NAND3_X2 U320 ( .A1(instruction_in[28]), .A2(n65), .A3(n150), .ZN(n160) );
  NAND3_X2 U321 ( .A1(n154), .A2(n152), .A3(n25), .ZN(ALUCtrl_out[0]) );
  AOI211_X2 U322 ( .C1(n30), .C2(n147), .A(n36), .B(n44), .ZN(DSize_out[1]) );
  NOR3_X2 U323 ( .A1(n36), .A2(instruction_in[3]), .A3(n30), .ZN(loadSign_out)
         );
  OAI21_X2 U324 ( .B1(n30), .B2(n36), .A(n141), .ZN(MemToReg_out) );
  NAND3_X2 U325 ( .A1(instruction_in[5]), .A2(n38), .A3(n140), .ZN(n141) );
  NOR3_X2 U326 ( .A1(n134), .A2(n135), .A3(n136), .ZN(RegWrite_out) );
  NAND3_X2 U327 ( .A1(n133), .A2(n27), .A3(n137), .ZN(n134) );
  NOR2_X2 U328 ( .A1(instruction_in[5]), .A2(n133), .ZN(branchZero_out) );
  NOR2_X2 U329 ( .A1(n37), .A2(n80), .ZN(RegToPC_out) );
  NAND3_X2 U330 ( .A1(n34), .A2(n44), .A3(n139), .ZN(n81) );
  NOR2_X2 U331 ( .A1(n142), .A2(n143), .ZN(LHIOp_out) );
  NOR2_X2 U332 ( .A1(LHIOp_out), .A2(n199), .ZN(n92) );
  INV_X4 U333 ( .A(LHIOp_out), .ZN(n197) );
  INV_X4 U334 ( .A(LHIOp_out), .ZN(n198) );
  INV_X4 U335 ( .A(n81), .ZN(RType_out) );
  BUF_X4 U336 ( .A(instruction_in[25]), .Z(imm16_out[9]) );
  BUF_X4 U337 ( .A(instruction_in[25]), .Z(imm26_out[19]) );
  BUF_X4 U338 ( .A(instruction_in[26]), .Z(imm16_out[10]) );
  BUF_X4 U339 ( .A(instruction_in[26]), .Z(imm26_out[20]) );
  BUF_X4 U340 ( .A(instruction_in[27]), .Z(imm16_out[11]) );
  BUF_X4 U341 ( .A(instruction_in[27]), .Z(imm26_out[21]) );
  BUF_X4 U342 ( .A(instruction_in[28]), .Z(imm16_out[12]) );
  BUF_X4 U343 ( .A(instruction_in[28]), .Z(imm26_out[22]) );
  BUF_X4 U344 ( .A(instruction_in[29]), .Z(imm16_out[13]) );
  BUF_X4 U345 ( .A(instruction_in[29]), .Z(imm26_out[23]) );
  BUF_X4 U346 ( .A(instruction_in[30]), .Z(imm16_out[14]) );
  BUF_X4 U347 ( .A(instruction_in[30]), .Z(imm26_out[24]) );
  BUF_X4 U348 ( .A(instruction_in[31]), .Z(imm16_out[15]) );
  BUF_X4 U349 ( .A(instruction_in[31]), .Z(imm26_out[25]) );
  BUF_X4 U350 ( .A(instruction_in[6]), .Z(imm26_out[0]) );
  BUF_X4 U351 ( .A(instruction_in[6]), .Z(r1_out[0]) );
  BUF_X4 U352 ( .A(instruction_in[7]), .Z(imm26_out[1]) );
  BUF_X4 U353 ( .A(instruction_in[7]), .Z(r1_out[1]) );
  BUF_X4 U354 ( .A(instruction_in[8]), .Z(imm26_out[2]) );
  BUF_X4 U355 ( .A(instruction_in[8]), .Z(r1_out[2]) );
  BUF_X4 U356 ( .A(instruction_in[9]), .Z(imm26_out[3]) );
  BUF_X4 U357 ( .A(instruction_in[9]), .Z(r1_out[3]) );
  BUF_X4 U358 ( .A(instruction_in[10]), .Z(imm26_out[4]) );
  BUF_X4 U359 ( .A(instruction_in[10]), .Z(r1_out[4]) );
  BUF_X4 U360 ( .A(instruction_in[11]), .Z(imm26_out[5]) );
  BUF_X4 U361 ( .A(instruction_in[11]), .Z(r2_out[0]) );
  BUF_X4 U362 ( .A(instruction_in[12]), .Z(imm26_out[6]) );
  BUF_X4 U363 ( .A(instruction_in[12]), .Z(r2_out[1]) );
  BUF_X4 U364 ( .A(instruction_in[13]), .Z(imm26_out[7]) );
  BUF_X4 U365 ( .A(instruction_in[13]), .Z(r2_out[2]) );
  BUF_X32 U366 ( .A(busB_in[31]), .Z(memVal_out[31]) );
  BUF_X32 U367 ( .A(busB_in[30]), .Z(memVal_out[30]) );
  BUF_X32 U368 ( .A(busB_in[29]), .Z(memVal_out[29]) );
  BUF_X32 U369 ( .A(busB_in[28]), .Z(memVal_out[28]) );
  BUF_X32 U370 ( .A(busB_in[27]), .Z(memVal_out[27]) );
  BUF_X32 U371 ( .A(busB_in[26]), .Z(memVal_out[26]) );
  BUF_X32 U372 ( .A(busB_in[25]), .Z(memVal_out[25]) );
  BUF_X32 U373 ( .A(busB_in[24]), .Z(memVal_out[24]) );
  BUF_X32 U374 ( .A(busB_in[23]), .Z(memVal_out[23]) );
  BUF_X32 U375 ( .A(busB_in[22]), .Z(memVal_out[22]) );
  BUF_X32 U376 ( .A(busB_in[21]), .Z(memVal_out[21]) );
  BUF_X32 U377 ( .A(busB_in[20]), .Z(memVal_out[20]) );
  BUF_X32 U378 ( .A(busB_in[19]), .Z(memVal_out[19]) );
  BUF_X32 U379 ( .A(busB_in[18]), .Z(memVal_out[18]) );
  BUF_X32 U380 ( .A(busB_in[17]), .Z(memVal_out[17]) );
  BUF_X32 U381 ( .A(busB_in[16]), .Z(memVal_out[16]) );
  BUF_X32 U382 ( .A(busB_in[15]), .Z(memVal_out[15]) );
  BUF_X32 U383 ( .A(busB_in[14]), .Z(memVal_out[14]) );
  BUF_X32 U384 ( .A(busB_in[13]), .Z(memVal_out[13]) );
  BUF_X32 U385 ( .A(busB_in[12]), .Z(memVal_out[12]) );
  BUF_X32 U386 ( .A(busB_in[11]), .Z(memVal_out[11]) );
  BUF_X32 U387 ( .A(busB_in[10]), .Z(memVal_out[10]) );
  BUF_X32 U388 ( .A(busB_in[9]), .Z(memVal_out[9]) );
  BUF_X32 U389 ( .A(busB_in[8]), .Z(memVal_out[8]) );
  BUF_X32 U390 ( .A(busB_in[7]), .Z(memVal_out[7]) );
  BUF_X32 U391 ( .A(busB_in[6]), .Z(memVal_out[6]) );
  BUF_X32 U392 ( .A(busB_in[5]), .Z(memVal_out[5]) );
  BUF_X32 U393 ( .A(busB_in[4]), .Z(memVal_out[4]) );
  BUF_X32 U394 ( .A(busB_in[3]), .Z(memVal_out[3]) );
  BUF_X32 U395 ( .A(busB_in[2]), .Z(memVal_out[2]) );
  BUF_X32 U396 ( .A(busB_in[1]), .Z(memVal_out[1]) );
  BUF_X32 U397 ( .A(busB_in[0]), .Z(memVal_out[0]) );
  BUF_X32 U398 ( .A(instruction_in[15]), .Z(imm26_out[9]) );
  BUF_X32 U399 ( .A(instruction_in[15]), .Z(r2_out[4]) );
  BUF_X32 U400 ( .A(instruction_in[14]), .Z(imm26_out[8]) );
  BUF_X32 U401 ( .A(instruction_in[14]), .Z(r2_out[3]) );
  BUF_X32 U402 ( .A(instruction_in[24]), .Z(imm16_out[8]) );
  BUF_X32 U403 ( .A(instruction_in[24]), .Z(imm26_out[18]) );
  BUF_X32 U404 ( .A(instruction_in[23]), .Z(imm16_out[7]) );
  BUF_X32 U405 ( .A(instruction_in[23]), .Z(imm26_out[17]) );
  BUF_X32 U406 ( .A(instruction_in[22]), .Z(imm16_out[6]) );
  BUF_X32 U407 ( .A(instruction_in[22]), .Z(imm26_out[16]) );
  BUF_X32 U408 ( .A(instruction_in[21]), .Z(imm16_out[5]) );
  BUF_X32 U409 ( .A(instruction_in[21]), .Z(imm26_out[15]) );
  BUF_X32 U410 ( .A(instruction_in[20]), .Z(imm16_out[4]) );
  BUF_X32 U411 ( .A(instruction_in[20]), .Z(imm26_out[14]) );
  BUF_X32 U412 ( .A(instruction_in[19]), .Z(imm16_out[3]) );
  BUF_X32 U413 ( .A(instruction_in[19]), .Z(imm26_out[13]) );
  BUF_X32 U414 ( .A(instruction_in[18]), .Z(imm16_out[2]) );
  BUF_X32 U415 ( .A(instruction_in[18]), .Z(imm26_out[12]) );
  BUF_X32 U416 ( .A(instruction_in[17]), .Z(imm16_out[1]) );
  BUF_X32 U417 ( .A(instruction_in[17]), .Z(imm26_out[11]) );
  BUF_X32 U418 ( .A(instruction_in[16]), .Z(imm16_out[0]) );
  BUF_X32 U419 ( .A(instruction_in[16]), .Z(imm26_out[10]) );
  BUF_X32 U420 ( .A(nextPC_in[31]), .Z(nextPC_out[31]) );
  BUF_X32 U421 ( .A(nextPC_in[30]), .Z(nextPC_out[30]) );
  BUF_X32 U422 ( .A(nextPC_in[29]), .Z(nextPC_out[29]) );
  BUF_X32 U423 ( .A(nextPC_in[28]), .Z(nextPC_out[28]) );
  BUF_X32 U424 ( .A(nextPC_in[27]), .Z(nextPC_out[27]) );
  BUF_X32 U425 ( .A(nextPC_in[26]), .Z(nextPC_out[26]) );
  BUF_X32 U426 ( .A(nextPC_in[25]), .Z(nextPC_out[25]) );
  BUF_X32 U427 ( .A(nextPC_in[24]), .Z(nextPC_out[24]) );
  BUF_X32 U428 ( .A(nextPC_in[23]), .Z(nextPC_out[23]) );
  BUF_X32 U429 ( .A(nextPC_in[22]), .Z(nextPC_out[22]) );
  BUF_X32 U430 ( .A(nextPC_in[21]), .Z(nextPC_out[21]) );
  BUF_X32 U431 ( .A(nextPC_in[20]), .Z(nextPC_out[20]) );
  BUF_X32 U432 ( .A(nextPC_in[19]), .Z(nextPC_out[19]) );
  BUF_X32 U433 ( .A(nextPC_in[18]), .Z(nextPC_out[18]) );
  BUF_X32 U434 ( .A(nextPC_in[17]), .Z(nextPC_out[17]) );
  BUF_X32 U435 ( .A(nextPC_in[16]), .Z(nextPC_out[16]) );
  BUF_X32 U436 ( .A(nextPC_in[15]), .Z(nextPC_out[15]) );
  BUF_X32 U437 ( .A(nextPC_in[14]), .Z(nextPC_out[14]) );
  BUF_X32 U438 ( .A(nextPC_in[13]), .Z(nextPC_out[13]) );
  BUF_X32 U439 ( .A(nextPC_in[12]), .Z(nextPC_out[12]) );
  BUF_X32 U440 ( .A(nextPC_in[11]), .Z(nextPC_out[11]) );
  BUF_X32 U441 ( .A(nextPC_in[10]), .Z(nextPC_out[10]) );
  BUF_X32 U442 ( .A(nextPC_in[9]), .Z(nextPC_out[9]) );
  BUF_X32 U443 ( .A(nextPC_in[8]), .Z(nextPC_out[8]) );
  BUF_X32 U444 ( .A(nextPC_in[7]), .Z(nextPC_out[7]) );
  BUF_X32 U445 ( .A(nextPC_in[6]), .Z(nextPC_out[6]) );
  BUF_X32 U446 ( .A(nextPC_in[5]), .Z(nextPC_out[5]) );
  BUF_X32 U447 ( .A(nextPC_in[4]), .Z(nextPC_out[4]) );
  BUF_X32 U448 ( .A(nextPC_in[3]), .Z(nextPC_out[3]) );
  BUF_X32 U449 ( .A(nextPC_in[2]), .Z(nextPC_out[2]) );
  BUF_X32 U450 ( .A(nextPC_in[1]), .Z(nextPC_out[1]) );
  BUF_X32 U451 ( .A(nextPC_in[0]), .Z(nextPC_out[0]) );
endmodule

