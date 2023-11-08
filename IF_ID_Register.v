module ifid(opcIn, pcIn, instrIn, opcOut, pcOut, instrOut, clk, rst, en);

input clk, rst, en;

input [15:0] opcIn, pcIn, instrIn;
output [15:0] opcOut, pcOut, instrOut;

Register opcodeRegister(.clk(clk), .rst(rst), .D(opcIn), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(opcOut), .Bitline2());
Register pcRegister(.clk(clk), .rst(rst), .D(pcIn), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(pcOut), .Bitline2());
Register instrRegister(.clk(clk), .rst(rst), .D(instrIn), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(instrOut), .Bitline2());
