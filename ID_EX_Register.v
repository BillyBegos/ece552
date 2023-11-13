module idex(haltIn, regDstIn, aluSrcIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, llbIn, lhbIn, 
                branchEnableIn, branchInstructIn, pcsIn, opcodeIn, regSourceIn, newPCIn, writeRegIn, srcData1In, srcData2In,immIn, 
            haltOut, regDstOut, aluSrcOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, llbOut, lhbOut, 
                branchEnableOut, branchInstructOut, pcsOut, opcodeOut, regSourceOut, newPCOut, writeRegOut, srcData1Out, srcData2Out, immOut,
clk, rst, en, instrIn, instrOut);


input clk, rst, en, haltIn, regDstIn, aluSrcIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, llbIn, lhbIn, branchEnableIn, branchInstructIn, pcsIn;
input [3:0] writeRegIn, opcodeIn;
input [7:0] regSourceIn;
input [15:0] newPCIn, srcData1In, srcData2In, immIn, instrIn;

output haltOut, regDstOut, aluSrcOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, llbOut, lhbOut, branchEnableOut, branchInstructOut, pcsOut;
output [3:0] writeRegOut, opcodeOut;
output [7:0] regSourceOut;
output [15:0] newPCOut, srcData1Out, srcData2Out, immOut, instrOut;


dff halt (.d(haltIn), .q(haltOut), .wen(en), .clk(clk), .rst(rst));
dff regDst (.d(regDstIn), .q(regDstOut), .wen(en), .clk(clk), .rst(rst));
dff aluSrc (.d(aluSrcIn), .q(aluSrcOut), .wen(en), .clk(clk), .rst(rst));
dff memRead (.d(memReadIn), .q(memReadOut), .wen(en), .clk(clk), .rst(rst));
dff memWrite (.d(memWriteIn), .q(memWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.d(memToRegIn), .q(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.d(regWriteIn), .q(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff llb (.d(llbIn), .q(llbOut), .wen(en), .clk(clk), .rst(rst));
dff lhb (.d(lhbIn), .q(lhbOut), .wen(en), .clk(clk), .rst(rst));
dff branchEnable (.d(branchEnableIn), .q(branchEnableOut), .wen(en), .clk(clk), .rst(rst));
dff branchInstruct (.d(branchInstructIn), .q(branchInstructOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.d(pcsIn), .q(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.q(writeRegOut[0]), .d(writeRegIn[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.q(writeRegOut[1]), .d(writeRegIn[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.q(writeRegOut[2]), .d(writeRegIn[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.q(writeRegOut[3]), .d(writeRegIn[3]), .wen(en), .clk(clk), .rst(rst));

dff opcodeRegFF0(.q(opcodeOut[0]), .d(opcodeIn[0]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF1(.q(opcodeOut[1]), .d(opcodeIn[1]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF2(.q(opcodeOut[2]), .d(opcodeIn[2]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF3(.q(opcodeOut[3]), .d(opcodeIn[3]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register SrcData1 (.D(srcData1In), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(srcData1Out), .Bitline2(), .clk(clk), .rst(rst));
Register SrcData2 (.D(srcData2In), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(srcData2Out), .Bitline2(), .clk(clk), .rst(rst));
Register imm (.D(immIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(immOut), .Bitline2(), .clk(clk), .rst(rst));
Register instr (.D(instrIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(instrOut), .Bitline2(), .clk(clk), .rst(rst));


dff regsourceFF0(.q(regSourceOut[0]), .d(regSourceIn[0]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF1(.q(regSourceOut[1]), .d(regSourceIn[1]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF2(.q(regSourceOut[2]), .d(regSourceIn[2]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF3(.q(regSourceOut[3]), .d(regSourceIn[3]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF5(.q(regSourceOut[4]), .d(regSourceIn[4]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF6(.q(regSourceOut[5]), .d(regSourceIn[5]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF7(.q(regSourceOut[6]), .d(regSourceIn[6]), .wen(en), .clk(clk), .rst(rst));
dff regsourceFF8(.q(regSourceOut[7]), .d(regSourceIn[7]), .wen(en), .clk(clk), .rst(rst));

endmodule
