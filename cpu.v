module cpu(
input clk,
input rst_n,
output hlt,
output [15:0] pc
); 


//flags to control cpu
wire halt, regDst, ALUSrc, memRead, memWrite, MemtoReg, RegWrite, LLB, LHB, branchEnable, brInstuct, PCS;                   

wire[11:0] cpuFlags;

assign hlt = cpuFlags[11];
assign regDst = cpuFlags[10];
assign ALUSrc = cpuFlags[9];
assign memRead = cpuFlags[8];
assign memWrite = cpuFlags[7];
assign MemtoReg = cpuFlags[6];
assign RegWrite = cpuFlags[5];
assign LLB = cpuFlags[4];
assign LHB = cpuFlags[3];
assign branchEnable = cpuFlags[2];
assign brInstuct = cpuFlags[1];
assign PCS = cpuFlags[0];

wire [15:0] pcOut;

wire [2:0] flag, en;
wire [3:0] rs, rt, rd, writeRegister;           
wire [15:0] inst, SrcData1, SrcData2, memAddress, memData, writeData, rs_full, rt_full, imm, memAddr, brAddr;
assign rs = (LLB | LHB) ? rd : inst[7:4];
assign rt = (memRead | memWrite) ? inst[11:8] : inst[3:0];
assign rd = inst[11:8];
assign rs_full = (memRead | memWrite) ? SrcData1 & 16'hFFFE : 
              (LLB) ? (SrcData1 & 16'hFF00) :
              (LHB) ? (SrcData1 & 16'h00FF) :
               SrcData1;
assign rt_full = (ALUSrc) ? imm : SrcData2;
assign imm = (memRead | memWrite) ? {{12{1'b0}},inst[3:0]} << 1 :
                   (LLB) ? {{8{1'b0}},inst[7:0]} : 
                   (inst[7:0] << 8);



wire ifidHalt, idexHalt, exmemHalt, memwbHalt, pcregHalt;
wire ifidStall, idexStall, exmemS

                   /*
RegisterFile regf(.clk(clk), .rst(~rst_n), .SrcReg1(rs), .SrcReg2(rt), .DstReg(writeRegister), .WriteReg(RegWrite), .DstData(writeData), .SrcData1(SrcData1), .SrcData2(SrcData2));
PC_Register pcReg(.clk(clk), .rst(~rst_n), .d(brAddr), .wen(~hlt), .q(pc));
ALU_16b alu(.rd(memAddress), .rs(rs_full), .rt(rt_full), .Opcode(inst[15:12]), .FLAG(flag), .PC(pc), .clk(clk),.rst(~rst_n),.hlt(hlt), .inst(inst));
CPU_flags flags(.op(inst[15:12]), .out(cpuFlags));
PC_control pcCon(.branch(branchEnable),.C(inst[11:9]), .I(inst[8:0]), .F(flag), .PC_in(pc), .PC_out(pcOut), .Opcode(inst[15:12]));
memory_instruction instr(.data_out(inst), .data_in(16'b1), .addr(pc), .clk(clk), .rst(~rst_n), .enable(1'b1), .wr(1'b0));
memory_data data(.data_out(memData), .data_in(SrcData2), .addr(memAddress), .enable(memRead), .wr(memWrite), .clk(clk), .rst(~rst_n));

*/

//INSTRUCTION FETCH
ifid fetchDecode(.opcIn(), .pcIn(), .instrIn(instr), .opcOut(), .pcOut(), .instrOut(), .clk(clk), .rst(~rst), .en())

//INSTRUCTION DECODE


//EXECUTE


//MEMORY


//WRITEBACK

assign writeRegister = (regDst) ? rd : rt;
assign writeData = (MemtoReg) ? memData : (PCS) ? pcOut : memAddress;

//only true if the instruction is BR
assign brAddr = (brInstuct) ? SrcData1 : pcOut;

endmodule