module idex(haltIn, regDstIn, aluSrcIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, llbIn, lhbIn, 
                branchEnableIn, branchInstructIn, pcsIn, opcodeIn, regSourceIn, newPCIn, writeRegIn, srcData1In, srcData2In,immIn, 
            haltOut, regDstOut, aluSrcOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, llbOut, lhbOut, 
                branchEnableOut, branchInstructOut, pcsOut, opcodeOut, regSourceOut, newPCOut, writeRegOut, srcData1Out, srcData2Out, immOut,
clk, rst, en);


input clk, rst, en haltIn, regDstIn, aluSrcIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, llbIn, lhbIn, branchEnableIn, branchInstructIn, pcsIn;
input [3:0] writeRegIn, opcodeIn;
input [7:0] regSourceIn;
input [15:0] newPCIn, srcData1In, srcData2In, immIn;

output haltOut, regDstOut, aluSrcOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, llbOut, lhbOut, branchEnableOut, branchInstructOut, pcsOut;
output [3:0] writeRegOut, opcodeOut;
output [7:0] regSourceOut;
output [15:0] newPCOut, srcData1Out, srcData2Out, immOut;

wire [15:0] zExtRegSourceIn, zExtRegSourceOut;

assign zExtRegSourceIn = {8{1'b0}, regSourceIn};

dff halt (.q(haltIn), .d(haltOut), .wen(en), .clk(clk), .rst(rst));
dff regDst (.q(regDstIn), .d(regDstOut), .wen(en), .clk(clk), .rst(rst));
dff aluSrc (.q(aluSrcIn), .d(alusrcOut), .wen(en), .clk(clk), .rst(rst));
dff memRead (.q(memReadIn), .d(memReadOut), .wen(en), .clk(clk), .rst(rst));
dff memWrite (.q(memWriteIn), .d(memWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.q(memToRegIn), .d(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.q(regWriteIn), .d(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff llb (.q(llbIn), .d(llbOut), .wen(en), .clk(clk), .rst(rst));
dff lhb (.q(lhbIn), .d(lhbOut), .wen(en), .clk(clk), .rst(rst));
dff branchEnable (.q(branchEnableIn), .d(branchEnableOut), .wen(en), .clk(clk), .rst(rst));
dff branchInstruct (.q(branchInstructIn), .d(branchInstructOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.q(pcsIn), .d(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.q(writeRegIn[0]), .d(writeRegOut[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.q(writeRegIn[1]), .d(writeRegOut[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.q(writeRegIn[2]), .d(writeRegOut[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.q(writeRegIn[3]), .d(writeRegOut[3]), .wen(en), .clk(clk), .rst(rst));

dff opcodeRegFF1(.q(opcodeIn[1]), .d(opcodeOut[1]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF2(.q(opcodeIn[2]), .d(opcodeOut[2]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF3(.q(opcodeIn[3]), .d(opcodeOut[3]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF4(.q(opcodeIn[4]), .d(opcodeOut[4]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register SrcData1 (.D(srcData1In), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(srcData1Out), .Bitline2(), .clk(clk), .rst(rst));
Register SrcData2 (.D(srcData2In), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(srcData2Out), .Bitline2(), .clk(clk), .rst(rst));
Register imm (.D(immIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(immOut), .Bitline2(), .clk(clk), .rst(rst));
Register regSource (.D(zExtRegSourceOut), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(zExtRegSourceIn), .Bitline2(), .clk(clk), .rst(rst));

assign regSourceOut = zExtRegSourceOut[7:0];

endmodule
