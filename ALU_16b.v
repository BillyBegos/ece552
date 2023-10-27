module ALU_16b(rd, rs, rt, Opcode, PC, FLAG, inst, clk, rst, hlt);

input [15:0] rs;
input [15:0] rt;
input [15:0] PC;
input [3:0] Opcode;
input [15:0] inst;
input clk;
input rst;
output [15:0] rd;
output [2:0] FLAG;
output hlt;

wire [3:0] offset;
wire [7:0] immediate;
wire [15:0] addr;
wire [15:0] temp1;
wire [15:0] temp2;
wire [15:0] rd_lower;
wire [15:0] rd_higher;
wire wr;
wire [15:0] data_in;
wire [15:0] data_out;
wire [15:0] PC_2;
wire [4:0] offset_sll;
wire [15:0] sign_extend_offset;

assign offset_sll = offset << 1;
assign sign_extend_offset = (offset_sll[3] == 1) ? {11'b11111111111, offset_sll} : {11'b00000000000, offset_sll}; 

assign temp1 = rs & 16'hFFFE;
assign temp2 = sign_extend_offset;

CLA_16b adder(.A(temp1), .B(temp2), .Sum(addr), .Cout(), .ovfl(), .addSub(1'b0));
CLA_16b pc2(.A(PC), .B(16'h2), .Sum(PC_2), .Cout(), .ovfl(), .addSub(1'b0));

assign offset = inst[3:0];
assign immediate = inst[7:0];

//assign rd 


//we also import clk, rst, and instruction from cpu.v
//call 2 instances of memory.v, one for instruction, one for data
//
//from instruction, get offset
//assign offset = 4'b0000
//assign inst = 16'b0

//use adder to calculate address
//assign addr = (Reg[inst[7:4]] & 0xFFFE) + (sign_extend_offset(offset) << 1)
// ^use CLA_16b adder instead of plus sign
// use shifter instead of <<

//call 2 instances of memory.v, one for instruction, one for data
//memory1c mem_data();
//memory1c mem_inst();

wire [15:0] addOut, paddsbOut, tempAddOut, tempSubOut, subOut, xorOut, shiftOut, redOut;

wire OvflAdd,OvflSub;

CLA_16b add(.A(rs), .B(rt), .Sum(addOut), .Cout(), .ovfl(OvflAdd), .addSub(1'b0));
CLA_16b sub(.A(rs), .B(rt), .Sum(subOut), .Cout(), .ovfl(OvflSub), .addSub(1'b1));


RED_16b red(.A(rs), .B(rt), .Sum(redOut));
PADDSB_16b paddsb(.Sum(paddsbOut), .A(rs), .B(rt));

base_3_shifter shift(.Mode(Opcode[1:0]), .Shift_Out(shiftOut),.Shift_In(rs),.Shift_Val(rt[3:0]));

assign xorOut =  rs ^ rt;

assign rd = (Opcode == 4'd0) ? addOut:
				 (Opcode == 4'd1) ? subOut:
				 (Opcode == 4'd2) ? xorOut:
				 (Opcode == 4'd3) ? redOut:
				 (Opcode == 4'd4) ? shiftOut:
				 (Opcode == 4'd5) ? shiftOut:
				 (Opcode == 4'd6) ? shiftOut:
				 (Opcode == 4'd7) ? paddsbOut:
				 (Opcode == 4'd8) ? addOut:
				 (Opcode == 4'd9) ? addOut:
				 rs | rt;
/*
    FLAG[0] = Z = zero
    FLAG[1] = V = overflow
    FLAG[2] = N = sign
*/
assign FLAG[0] = (rd == 16'd0);
assign FLAG[1] = ((Opcode == 4'd0) & (OvflAdd)) ? 1'b1 :
				 ((Opcode == 4'd1) & (OvflSub)) ? 1'b1 :
				 1'b0;
assign FLAG[2] = ((Opcode == 4'd0) & (addOut[15])) ? 1'b1 :
				 ((Opcode == 4'd1) & (subOut[15])) ? 1'b1 :
				 1'b0;
endmodule


