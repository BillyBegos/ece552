module forward(
    input exmemRegWrite, input exmemMemWrite, input memwbRegWrite, input [3:0] exmemDstReg, input [3:0] memwbDstReg, input [3:0] idRs, input [3:0] idRt, input [3:0] exmemRt, input [3:0] memwbRd, input [3:0] exmemRd, output exexForwardRs, output exexForwardRt, output memmemForwardRt, output memexForwardRs, output memexForwardRt
);

assign exexForwardRs = ((exmemRegWrite) & (exmemDstReg == idRs) & (exmemDstReg != 4'h0));
assign exexForwardRt = ((exmemRegWrite) & (exmemDstReg == idRt) & (exmemDstReg != 4'h0));
assign memmemForwardRt = ((exmemMemWrite) & (memwbRegWrite) & (memwbDstReg!= 4'h0) & (memwbDstReg == exmemRt));
assign memexForwardRs = ((memwbRegWrite) & (memwbRd != 4'h0) & (~((exmemRegWrite) & (exmemRd != 4'h0) & (exmemRd == idRs))) & (memwbRd == idRs));
assign memexForwardRt = ((memwbRegWrite) & (memwbRd != 4'h0) & (~((exmemRegWrite) & (exmemRd != 4'h0) & (exmemRd == idRt))) & (memwbRd == idRt));


endmodule