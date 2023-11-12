module forward(input MEM_WB_RegWrite, input EX_MEM_RegWrite, input [4:0] MEM_WB_RegisterRd, input [4:0] EX_MEM_RegisterRd, input [4:0] EX_MEM_RegisterRt, input [4:0] ID_EX_RegisterRs, input [4:0] ID_EX_RegisterRt, output [1:0] ForwardA, output [1:0] ForwardB, output [1:0] ForwardC);
	
	//EX-to-EX
	assign ForwardA = (MEM_WB_RegWrite & (MEM_WB_RegisterRd != 5'b0) & ~(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 5'b0) & (EX_MEM_RegisterRd != ID_EX_RegisterRs)) & (MEM_WB_RegisterRd == ID_EX_RegisterRs)) ? 2'b01 :
			  (EX_MEM_RegWrite & (EX_MEM_RegisterRd != 5'b0) & (EX_MEM_RegisterRd == ID_EX_RegisterRs)) ? 2'b10 :
		          2'b00;

	//MEM-to-EX
	assign ForwardB = (MEM_WB_RegWrite & (MEM_WB_RegisterRd != 5'b0) & ~(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 5'b0) & (EX_MEM_RegisterRd != ID_EX_RegisterRt)) & (MEM_WB_RegisterRd == ID_EX_RegisterRt)) ? 2'b01 :
			  (EX_MEM_RegWrite & (EX_MEM_RegisterRd != 5'b0) & (EX_MEM_RegisterRd == ID_EX_RegisterRt)) ? 2'b10 :
		          2'b00;

	//MEM-to-MEM
	assign ForwardC = (MEM_WB_RegWrite & (MEM_WB_RegisterRd != 5'b0) & (MEM_WB_RegisterRd == EX_MEM_RegisterRt)) ? 2'b01 :
			  2'b00;

endmodule
