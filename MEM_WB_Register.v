module memwb(haltIn, regWriteIn, memToRegIn, writeRegIn, pcsIn, newPCIn, memIn, rtIn,
            haltOut, regWriteOut, memToRegOut, writeRegOut, pcsOut, newPCOut, memOut, rtOut,
clk, rst, en);

input clk, rst, en, haltIn, memToRegIn, regWriteIn, pcsIn;
input [3:0] writeRegIn;
input [15:0] newPCIn, memIn, rtIn;

output haltOut, memToRegOut, regWriteOut, pcsOut;
output [3:0] writeregout;
output [15:0] newPCOut, memOut, rtout;

dff halt (.q(haltIn), .d(haltOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.q(regWriteIn), .d(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.q(memToRegIn), .d(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.q(pcsIn), .d(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.q(writeRegIn[0]), .d(writeRegOut[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.q(writeRegIn[1]), .d(writeRegOut[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.q(writeRegIn[2]), .d(writeRegOut[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.q(writeRegIn[3]), .d(writeRegOut[3]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register rt (.D(rtIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(rtOut), .Bitline2(), .clk(clk), .rst(rst));
Register mem (.D(memIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(memOut), .Bitline2(), .clk(clk), .rst(rst));
