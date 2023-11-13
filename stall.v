module and_gate(
  output out,
  input a,
  input b
);
  assign out = a & b;
endmodule

module xor_gate (
  output out,
  input a,
  input b
);
  assign out = a ^ b;
endmodule

module or_gate (
  output out,
  input a,
  input b
);
  assign out = a | b;
endmodule

module StallControl(PC_WriteEn,IFID_WriteEn,Stall_flush,EX_MemRead,EX_rt,ID_rs,ID_rt,ID_Op);
  output PC_WriteEn,IFID_WriteEn,Stall_flush;
  wire PC_WriteEn,IFID_WriteEn,Stall_flush;
  input EX_MemRead,EX_rt,ID_rs,ID_rt;
  input [5:0] ID_Op;
  wire [4:0] EX_rt,ID_rs,ID_rt,xorRsRt,xorRtRt;
  wire [5:0] xoropcodelw,xoropcodexori;
  wire EX_MemRead;

  wire ec1, ec2, xorop, xoroprt, OrOut, Condition;

  assign Stall_flush = Condition;
  assign PC_WriteEn = ~Condition;
  assign IFID_WriteEn = ~Condition;

  xor_gate xorRsRt4 (.out(xorRsRt[4]), .a(EX_rt[4]), .b(ID_rs[4]));
  xor_gate xorRsRt3 (.out(xorRsRt[3]), .a(EX_rt[3]), .b(ID_rs[3]));
  xor_gate xorRsRt2 (.out(xorRsRt[2]), .a(EX_rt[2]), .b(ID_rs[2]));
  xor_gate xorRsRt1 (.out(xorRsRt[1]), .a(EX_rt[1]), .b(ID_rs[1]));
  xor_gate xorRsRt0 (.out(xorRsRt[0]), .a(EX_rt[0]), .b(ID_rs[0]));
  or_gate OrRsRt1 (.out(OrRsRt), .a(xorRsRt[4]), .b(xorRsRt[3]), .c(xorRsRt[2]), .d(xorRsRt[1]), .e(xorRsRt[0]));
  not_gate notgate1 (.out(notOrRsRt), .in(OrRsRt));

  xor_gate xorRtRt4 (.out(xorRtRt[4]), .a(EX_rt[4]), .b(ID_rt[4]));
  xor_gate xorRtRt3 (.out(xorRtRt[3]), .a(EX_rt[3]), .b(ID_rt[3]));
  xor_gate xorRtRt2 (.out(xorRtRt[2]), .a(EX_rt[2]), .b(ID_rt[2]));
  xor_gate xorRtRt1 (.out(xorRtRt[1]), .a(EX_rt[1]), .b(ID_rt[1]));
  xor_gate xorRtRt0 (.out(xorRtRt[0]), .a(EX_rt[0]), .b(ID_rt[0]));
  or_gate OrRtRt1 (.out(OrRtRt), .a(xorRtRt[4]), .b(xorRtRt[3]), .c(xorRtRt[2]), .d(xorRtRt[1]), .e(xorRtRt[0]));
  not_gate notgate2 (.out(notOrRtRt), .in(OrRtRt));

  xor_gate xoropcode5 (.out(xoropcodelw[5]), .a(ID_Op[5]), .b(1'b1));
  xor_gate xoropcode4 (.out(xoropcodelw[4]), .a(ID_Op[4]), .b(1'b0));
  xor_gate xoropcode3 (.out(xoropcodelw[3]), .a(ID_Op[3]), .b(1'b0));
  xor_gate xoropcode2 (.out(xoropcodelw[2]), .a(ID_Op[2]), .b(1'b0));
  xor_gate xoropcode1 (.out(xoropcodelw[1]), .a(ID_Op[1]), .b(1'b1));
  xor_gate xoropcode0 (.out(xoropcodelw[0]), .a(ID_Op[0]), .b(1'b1));
  or_gate oropcode1 (.out(ec1), .a(xoropcodelw[5]), .b(xoropcodelw[4]), .c(xoropcodelw[3]), .d(xoropcodelw[2]), .e(xoropcodelw[1]), .f(xoropcodelw[0]));

  xor_gate xoropcod5 (.out(xoropcodexori[5]), .a(ID_Op[5]), .b(1'b0));
  xor_gate xoropcod4 (.out(xoropcodexori[4]), .a(ID_Op[4]), .b(1'b0));
  xor_gate xoropcod3 (.out(xoropcodexori[3]), .a(ID_Op[3]), .b(1'b1));
  xor_gate xoropcod2 (.out(xoropcodexori[2]), .a(ID_Op[2]), .b(1'b1));
  xor_gate xoropcod1 (.out(xoropcodexori[1]), .a(ID_Op[1]), .b(1'b1));
  xor_gate xoropcod0 (.out(xoropcodexori[0]), .a(ID_Op[0]), .b(1'b0));
  or_gate oropcode2 (.out(ec2), .a(xoropcodexori[5]), .b(xoropcodexori[4]), .c(xoropcodexori[3]), .d(xoropcodexori[2]), .e(xoropcodexori[1]), .f(xoropcodexori[0]));

  and_gate and1 (.out(xorop), .a(ec1), .b(ec2));
  and_gate and2 (.out(xoroprt), .a(xorop), .b(notOrRtRt));
  or_gate OrEXIDRsRt (.out(OrOut), .a(notOrRsRt), .b(xoroprt));
  and_gate AndCondition (.out(Condition), .a(EX_MemRead), .b(OrOut));

endmodule
