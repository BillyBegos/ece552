module memwb(haltIn, regWriteIn, memToRegIn, writeRegIn, pcsIn, newPCIn, memIn, rtIn,
            haltOut, regWriteOut, memToRegOut, writeRegOut, pcsOut, newPCOut, memOut, rtOut,
clk, rst, en);

input clk, rst, en, haltIn, memToRegIn, regWriteIn, pcsIn;
input [3:0] writeRegIn;
input [15:0] newPCIn, memIn, rtIn;

output haltOut, memToRegOut, regWriteOut, pcsOut;
output [3:0] writeRegOut;
output [15:0] newPCOut, memOut, rtOut;

dff halt (.d(haltIn), .q(haltOut), .wen(en), .clk(clk), .rst(rst));
dff regWrite (.d(regWriteIn), .q(regWriteOut), .wen(en), .clk(clk), .rst(rst));
dff memToReg (.d(memToRegIn), .q(memToRegOut), .wen(en), .clk(clk), .rst(rst));
dff PCS (.d(pcsIn), .q(pcsOut), .wen(en), .clk(clk), .rst(rst));

dff writeRegFF0(.d(writeRegIn[0]), .q(writeRegOut[0]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF1(.d(writeRegIn[1]), .q(writeRegOut[1]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF2(.d(writeRegIn[2]), .q(writeRegOut[2]), .wen(en), .clk(clk), .rst(rst));
dff writeRegFF3(.d(writeRegIn[3]), .q(writeRegOut[3]), .wen(en), .clk(clk), .rst(rst));

Register newPC (.D(newPCIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(newPCOut), .Bitline2(), .clk(clk), .rst(rst));
Register rt (.D(rtIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(rtOut), .Bitline2(), .clk(clk), .rst(rst));
Register mem (.D(memIn), .WriteReg(en), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(memOut), .Bitline2(), .clk(clk), .rst(rst));

endmodule
