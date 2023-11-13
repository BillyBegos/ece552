module and_gate (
  output out,
  input a,
  input b
);
  assign out = a & b;
endmodule

module not_gate (
  output out,
  input in
);
  assign out = ~in;
endmodule

module or_gate (
  output out,
  input a,
  input b
);
  assign out = a | b;
endmodule

module flush_block(
ID_RegDst,ID_ALUSrc, ID_MemtoReg,ID_RegWrite,ID_MemRead,ID_MemWrite,
ID_Branch,ID_ALUOp,ID_JRControl,flush,RegDst,ALUSrc,MemtoReg,RegWrite,
MemRead,MemWrite,Branch,ALUOp,JRControl);

output ID_RegDst,ID_ALUSrc,ID_MemtoReg,ID_RegWrite,ID_MemRead,ID_MemWrite,ID_Branch,ID_JRControl;
output [1:0] ID_ALUOp;
input flush,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,JRControl;
input [1:0] ALUOp;

  not_gate not1 (.out(notflush), .in(flush));

  and_gate and2 (.out(ID_RegDst), .a(RegDst), .b(notflush));
  and_gate and3 (.out(ID_ALUSrc), .a(ALUSrc), .b(notflush));
  and_gate and4 (.out(ID_MemtoReg), .a(MemtoReg), .b(notflush));
  and_gate and5 (.out(ID_RegWrite), .a(RegWrite), .b(notflush));
  and_gate and6 (.out(ID_MemRead), .a(MemRead), .b(notflush));
  and_gate and7 (.out(ID_MemWrite), .a(MemWrite), .b(notflush));
  and_gate and8 (.out(ID_Branch), .a(Branch), .b(notflush));
  and_gate and9 (.out(ID_JRControl), .a(JRControl), .b(notflush));
  and_gate and10 (.out(ID_ALUOp[1]), .a(ALUOp[1]), .b(notflush));
  and_gate and11 (.out(ID_ALUOp[0]), .a(ALUOp[0]), .b(notflush));
endmodule

module Discard_Instr(ID_flush,IF_flush,jump,bne,jr);
output ID_flush,IF_flush;
input jump,bne,jr;

  or_gate or1 (.out(IF_flush), .a(jump), .b(bne), .c(jr));
  or_gate or2 (.out(ID_flush), .a(bne), .b(jr));
endmodule
