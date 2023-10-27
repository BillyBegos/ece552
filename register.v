module ReadDecoder_4_16(input [3:0] RegId, output [15:0] Wordline);

    // 16bit word = 2^(RegId)
    assign Wordline =  (RegId == 0) ? 16'd1 :
                       (RegId == 1) ? 16'd2 :
                       (RegId == 2) ? 16'd4 :
                       (RegId == 3) ? 16'd8 :
                       (RegId == 4) ? 16'd16 :
                       (RegId == 5) ? 16'd32 :
                       (RegId == 6) ? 16'd64 :
                       (RegId == 7) ? 16'd128 :
                       (RegId == 8) ? 16'd256 :
                       (RegId == 9) ? 16'd512 :
                       (RegId == 10) ? 16'd1024 :
                       (RegId == 11) ? 16'd2048 :
                       (RegId == 12) ? 16'd4096 :
                       (RegId == 13) ? 16'd8192 :
                       (RegId == 14) ? 16'd16384 :
                       16'd32768; //RegId == 15

endmodule;

module WriteDecoder_4_16(input [3:0] RegId, input WriteReg, output [15:0] Wordline);

    // 16bit word = 2^(RegId)
    assign Wordline =  (WriteReg == 0) ? 1'd0 :
                       (RegId == 0) ? 16'd1 :
                       (RegId == 1) ? 16'd2 :
                       (RegId == 2) ? 16'd4 :
                       (RegId == 3) ? 16'd8 :
                       (RegId == 4) ? 16'd16 :
                       (RegId == 5) ? 16'd32 :
                       (RegId == 6) ? 16'd64 :
                       (RegId == 7) ? 16'd128 :
                       (RegId == 8) ? 16'd256 :
                       (RegId == 9) ? 16'd512 :
                       (RegId == 10) ? 16'd1024 :
                       (RegId == 11) ? 16'd2048 :
                       (RegId == 12) ? 16'd4096 :
                       (RegId == 13) ? 16'd8192 :
                       (RegId == 14) ? 16'd16384 :
                       16'd32768; //reg1d = 15

endmodule;


module BitCell( input clk, input rst, input D, input WriteEnable, input ReadEnable1, input
ReadEnable2, inout Bitline1, inout Bitline2);

wire state;

dff ff0(.q(state),.d(D),.wen(WriteEnable),.clk(clk),.rst(rst));

//tri-state buffer, if rEn is low, the Hi-Z, otherwise pass through dff output
assign Bitline1 = ReadEnable1 ? state : 1'bz;

assign Bitline2 = ReadEnable2 ? state : 1'bz;

endmodule;


module Register( input clk, input rst, input [15:0] D, input WriteReg, input ReadEnable1, input
ReadEnable2, inout [15:0] Bitline1, inout [15:0] Bitline2);

BitCell c0(.clk(clk),.rst(rst),.D(D[0]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[0]),.Bitline2(Bitline2[0]));
BitCell c1(.clk(clk),.rst(rst),.D(D[1]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[1]),.Bitline2(Bitline2[1]));
BitCell c2(.clk(clk),.rst(rst),.D(D[2]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[2]),.Bitline2(Bitline2[2]));
BitCell c3(.clk(clk),.rst(rst),.D(D[3]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[3]),.Bitline2(Bitline2[3]));
BitCell c4(.clk(clk),.rst(rst),.D(D[4]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[4]),.Bitline2(Bitline2[4]));
BitCell c5(.clk(clk),.rst(rst),.D(D[5]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[5]),.Bitline2(Bitline2[5]));
BitCell c6(.clk(clk),.rst(rst),.D(D[6]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[6]),.Bitline2(Bitline2[6]));
BitCell c7(.clk(clk),.rst(rst),.D(D[7]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[7]),.Bitline2(Bitline2[7]));
BitCell c8(.clk(clk),.rst(rst),.D(D[8]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[8]),.Bitline2(Bitline2[8]));
BitCell c9(.clk(clk),.rst(rst),.D(D[9]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[9]),.Bitline2(Bitline2[9]));
BitCell c10(.clk(clk),.rst(rst),.D(D[10]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[10]),.Bitline2(Bitline2[10]));
BitCell c11(.clk(clk),.rst(rst),.D(D[11]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[11]),.Bitline2(Bitline2[11]));
BitCell c12(.clk(clk),.rst(rst),.D(D[12]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[12]),.Bitline2(Bitline2[12]));
BitCell c13(.clk(clk),.rst(rst),.D(D[13]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[13]),.Bitline2(Bitline2[13]));
BitCell c14(.clk(clk),.rst(rst),.D(D[14]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[14]),.Bitline2(Bitline2[14]));
BitCell c15(.clk(clk),.rst(rst),.D(D[15]),.WriteEnable(WriteReg),.ReadEnable1(ReadEnable1),.ReadEnable2(ReadEnable2),.Bitline1(Bitline1[15]),.Bitline2(Bitline2[15]));

endmodule;


module RegisterFile(input clk, input rst, input [3:0] SrcReg1, input [3:0] SrcReg2, input [3:0]
DstReg, input WriteReg, input [15:0] DstData, inout [15:0] SrcData1, inout [15:0] SrcData2);

wire [15:0] ReadWordline1, ReadWordline2, WriteWordline, D;

wire[15:0] tempSrcData1, tempSrcData2;

assign D = DstData;

ReadDecoder_4_16 rd0(.RegId(SrcReg1),.Wordline(ReadWordline1));
ReadDecoder_4_16 rd1(.RegId(SrcReg2),.Wordline(ReadWordline2));
WriteDecoder_4_16 wd0(.RegId(DstReg),.WriteReg(WriteReg),.Wordline(WriteWordline));


Register r0(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[0]), .ReadEnable1(ReadWordline1[0]), .ReadEnable2(ReadWordline2[0]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r1(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[1]), .ReadEnable1(ReadWordline1[1]), .ReadEnable2(ReadWordline2[1]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r2(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[2]), .ReadEnable1(ReadWordline1[2]), .ReadEnable2(ReadWordline2[2]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r3(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[3]), .ReadEnable1(ReadWordline1[3]), .ReadEnable2(ReadWordline2[3]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r4(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[4]), .ReadEnable1(ReadWordline1[4]), .ReadEnable2(ReadWordline2[4]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r5(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[5]), .ReadEnable1(ReadWordline1[5]), .ReadEnable2(ReadWordline2[5]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r6(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[6]), .ReadEnable1(ReadWordline1[6]), .ReadEnable2(ReadWordline2[6]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r7(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[7]), .ReadEnable1(ReadWordline1[7]), .ReadEnable2(ReadWordline2[7]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r8(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[8]), .ReadEnable1(ReadWordline1[8]), .ReadEnable2(ReadWordline2[8]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r9(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[9]), .ReadEnable1(ReadWordline1[9]), .ReadEnable2(ReadWordline2[9]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r10(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[10]), .ReadEnable1(ReadWordline1[10]), .ReadEnable2(ReadWordline2[10]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r11(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[11]), .ReadEnable1(ReadWordline1[11]), .ReadEnable2(ReadWordline2[11]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r12(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[12]), .ReadEnable1(ReadWordline1[12]), .ReadEnable2(ReadWordline2[12]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r13(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[13]), .ReadEnable1(ReadWordline1[13]), .ReadEnable2(ReadWordline2[13]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r14(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[14]), .ReadEnable1(ReadWordline1[14]), .ReadEnable2(ReadWordline2[14]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));
Register r15(.clk(clk), .rst(rst), .D(D), .WriteReg(WriteWordline[15]), .ReadEnable1(ReadWordline1[15]), .ReadEnable2(ReadWordline2[15]), .Bitline1(tempSrcData1), .Bitline2(tempSrcData2));

//if DstReg is equal to either srcreg, then assign srcdata[x] to dstdata in the same cycle, otherwise use the value from the registers
assign SrcData1 =  tempSrcData1; //write-before-read bypassing
assign SrcData2 =  tempSrcData2;

endmodule;