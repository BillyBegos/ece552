module exmem(haltIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, pcsIn, opcodeIn, newPCIn, rtForwardIn, rtIn, writeRegIn,
            haltOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, pcsOut, opcodeOut, newPCOut, rtForwardOut, rtOut, writeRegOut,
clk, rst, en, aluIn, aluOut, instrIn, instrOut);


input clk, rst, en, haltIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, pcsIn;
input [3:0] opcodeIn, writeRegIn, rtForwardIn;
input [15:0] newPCIn, rtIn, aluIn, instrIn;

output haltOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, pcsOut;
output [3:0] writeRegOut, opcodeOut, rtForwardOut;
output [15:0] newPCOut, rtOut, aluOut, instrOut;

dff halt (.d(haltIn), .q(haltOut), .wen(en), .clk(clk), .rst(rst));
dff memRead (.d(memReadIn), .q(memReadOut), .wen(en), .clk(clk), .rst(rst));
dff memWrite (.d(memWriteIn), .q(memWriteOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.d(regWriteIn), .q(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.d(memToRegIn), .q(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.d(pcsIn), .q(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.d(writeRegIn[0]), .q(writeRegOut[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.d(writeRegIn[1]), .q(writeRegOut[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.d(writeRegIn[2]), .q(writeRegOut[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.d(writeRegIn[3]), .q(writeRegOut[3]), .wen(en), .clk(clk), .rst(rst));

dff opcodeRegFF0(.d(opcodeIn[0]), .q(opcodeOut[0]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF1(.d(opcodeIn[1]), .q(opcodeOut[1]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF2(.d(opcodeIn[2]), .q(opcodeOut[2]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF3(.d(opcodeIn[3]), .q(opcodeOut[3]), .wen(en), .clk(clk), .rst(rst));

dff rtFwdFF1(.d(rtForwardIn[1]), .q(rtForwardOut[1]), .wen(en), .clk(clk), .rst(rst));
dff rtFwdFF2(.d(rtForwardIn[2]), .q(rtForwardOut[2]), .wen(en), .clk(clk), .rst(rst));
dff rtFwdFF3(.d(rtForwardIn[3]), .q(rtForwardOut[3]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register rt (.D(rtIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(rtOut), .Bitline2(), .clk(clk), .rst(rst));
Register alu (.D(aluIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(aluOut), .Bitline2(), .clk(clk), .rst(rst));
Register instr (.D(instrIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(instrOut), .Bitline2(), .clk(clk), .rst(rst));

endmodule