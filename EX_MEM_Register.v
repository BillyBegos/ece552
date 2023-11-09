module exmem(haltIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, pcsIn, opcodeIn, newPCIn, rtForwardIn, rtIn, regDataIn, writeRegIn,
            haltOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, pcsOut, opcodeOut, newPCOut, rtForwardOut, rtOut, regDataOut, writeRegOut
clk, rst, en);


input clk, rst, en haltIn, memReadIn, memWriteIn, memToRegIn, regWriteIn, pcsIn;
input [3:0] opcodeIn, writeRegIn, rtForwardIn;
input [15:0] newPCIn, regDataIn, rtIn;

output haltOut, memReadOut, memWriteOut, memToRegOut, regWriteOut, pcsOut;
output [3:0] writeRegOut, opcodeOut, rtForwardOut;
output [15:0] newPCOut, regDataOut, rtOut;

assign zExtRegSourceIn = {8{1'b0}, regSourceIn};

dff halt (.q(haltIn), .d(haltOut), .wen(en), .clk(clk), .rst(rst));
dff memRead (.q(memReadIn), .d(memReadOut), .wen(en), .clk(clk), .rst(rst));
dff memWrite (.q(memWriteIn), .d(memWriteOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.q(regWriteIn), .d(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.q(memToRegIn), .d(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.q(pcsIn), .d(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.q(writeRegIn[0]), .d(writeRegOut[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.q(writeRegIn[1]), .d(writeRegOut[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.q(writeRegIn[2]), .d(writeRegOut[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.q(writeRegIn[3]), .d(writeRegOut[3]), .wen(en), .clk(clk), .rst(rst));

dff opcodeRegFF1(.q(opcodeIn[1]), .d(opcodeOut[1]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF2(.q(opcodeIn[2]), .d(opcodeOut[2]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF3(.q(opcodeIn[3]), .d(opcodeOut[3]), .wen(en), .clk(clk), .rst(rst));
dff opcodeRegFF4(.q(opcodeIn[4]), .d(opcodeOut[4]), .wen(en), .clk(clk), .rst(rst));

dff rtFwdFF1(.q(rtForwardIn[1]), .d(rtForwardOut[1]), .wen(en), .clk(clk), .rst(rst));
dff rtFwdFF2(.q(rtForwardIn[2]), .d(rtForwardOut[2]), .wen(en), .clk(clk), .rst(rst));
dff rtFwdFF3(.q(rtForwardIn[3]), .d(rtForwardOut[3]), .wen(en), .clk(clk), .rst(rst));
dff rtFwdFF4(.q(rtForwardIn[4]), .d(rtForwardOut[4]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register rt (.D(rtIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(rtOut), .Bitline2(), .clk(clk), .rst(rst));
Register regData (.D(regDataIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(regDataOut), .Bitline2(), .clk(clk), .rst(rst));

endmodule