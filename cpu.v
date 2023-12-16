module cpu(
input clk,
input rst_n,
output hlt,
output [15:0] pc
);    

wire [11:0] cpuFlags;
wire stall, flush, ifFlush, branchTaken, ifidHalt, idexHalt, exmemHalt, memwbHalt, ifidRegDst, idexRegDst, ifidAluSrc, idexAluSrc, ifidMemRead, idexMemRead, exmemMemRead, ifidMemWrite, idexMemWrite, exmemMemWrite, memEnable,
ifidMemToReg, idexMemToReg, exmemMemToReg, memwbMemToReg, ifidRegWrite, idexRegWrite, exmemRegWrite, memwbRegWrite,ifidLLB, idexLLB, ifidLHB, idexLHB, ifidBranchEn, idexBranchEn,
ifidBranchInstr, idexBranchInstr, ifidPCS, idexPCS, exmemPCS, memwbPCS, exexRs, memexRs, exexRt, memexRt, memmemRt;                                                                                                            
wire [7:0] rsrtForward;  
wire [3:0] idexOpcode, exmemOpcode, rs, rt, rd, rt_fwd, destReg, idexWriteRegister, exmemWriteRegister, memwbWriteRegister;
wire [2:0] flag, en; 
wire [15:0] instr, ifidInstr, idexInstr, exmemInstr, ifidSrcData1, ifidSrcData2, idexSrcData1, idexSrcData2, exmemSrcData2, newPC, ifidNewPC, idexNewPC, exmemNewPC, memwbNewPC, ifidOldPC, aluIn1, aluIn2, aluOut, exmemAluOut, 
memwbAluOut, memDataOut, memDataIn, regWriteData, memwbMemDataOut, rs_full, rt_full, ifidImm, idexImm, brAddr;
wire [7:0] rsrt;
wire i_miss, d_miss, writeEn, hlt_fetch_not_yet, mem_miss_stall;


///////////////////////
wire stall_cache;
assign pcreg_wen = ~(instr[15:12] == 4'hf & ~branchTaken) & ~stall & mem_miss_stall;
//////////////////////




//FETCH INSTRUCTION ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ifid if_id(.clk(clk), .rst(ifFlush), .en(~stall_cache), .opcIn(pc), .pcIn(brAddr), .instrIn(instr), .opcOut(ifidOldPC), .pcOut(ifidNewPC), .instrOut(ifidInstr));
PC_Register pcReg(.clk(clk), .rst(~rst_n), .d(brAddr), .wen(pcreg_wen), .q(pc));
PC_control pcControl(.branch(ifidBranchEn), .C(ifidInstr[11:9]), .I(ifidInstr[8:0]), .F(flag), .Opcode(ifidInstr[15:12]), .PC_in(ifidBranchEn ? ifidOldPC : pc), .PC_out(newPC), .branchTaken(branchTaken));
assign brAddr = (ifidBranchInstr) ? ifidSrcData1 : newPC;
assign hlt = memwbHalt;



/////////////////
assign ifFlush = ~rst_n | flush;



Memory_Controller MC(.clk(clk), .rst(rst), .d_enable(exmemInstr[15:13] == 3'b100), .if_we(1'b0), .dm_we(exmemMemWrite), .if_addr(pc), .dm_addr(exmemAluOut), .if_data_out(ifidInstr),
	.dm_data_out(regWriteData), .if_data_in(16'h0), .dm_data_in(memDataIn), .if_miss(i_miss), .dm_miss(d_miss));
dff hlt_fetched(.q(hlt_fetch_state), .d(~hlt_fetch_not_yet), .wen(~hlt_fetch_state), .clk(clk), .rst(rst));

assign hlt_fetch_not_yet = ifidInstr[15:12] != 4'b1111 ? 1 :
			       idexInstr[15:13] != 4'b110 ? 0 : branchTaken ? 1 : 0;
assign mem_miss_stall = i_miss | d_miss;
assign stall_cache = mem_miss_stall | stall;
/////////////////


//DECODE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
idex idexRegister(.clk(clk), .rst(~rst_n), .en(~stall_cache), .haltIn(ifidHalt), .regDstIn(ifidRegDst), .aluSrcIn(ifidAluSrc), .memReadIn(ifidMemRead),
                    .memWriteIn(ifidMemWrite), .memToRegIn(ifidMemToReg),.regWriteIn(ifidRegWrite), .llbIn(ifidLLB),
                    .lhbIn(ifidLHB), .branchEnableIn(ifidBranchEn), .branchInstructIn(ifidBranchInstr), .pcsIn(ifidPCS), .opcodeIn(ifidInstr[15:12]), .regSourceIn(rsrt), .newPCIn(ifidNewPC), .writeRegIn(destReg), 
                    .srcData1In(ifidSrcData1), .srcData2In(ifidSrcData2), .immIn(ifidImm), .haltOut(idexHalt), .regDstOut(idexRegDst), .aluSrcOut(idexAluSrc),
                    .memReadOut(idexMemRead), .memWriteOut(idexMemWrite), .memToRegOut(idexMemToReg), .regWriteOut(idexRegWrite),
                    .llbOut(idexLLB), .lhbOut(idexLHB), .branchEnableOut(idexBranchEn), .branchInstructOut(idexBranchInstr), .pcsOut(idexPCS), .opcodeOut(idexOpcode), .regSourceOut(rsrtForward),
                    .newPCOut(idexNewPC), .writeRegOut(idexWriteRegister), .srcData1Out(idexSrcData1), .srcData2Out(idexSrcData2), .immOut(idexImm), .instrIn(ifidInstr), .instrOut(idexInstr));

RegisterFile rf(.clk(clk), .rst(~rst_n), .SrcReg1(rs), .SrcReg2(rt), .DstReg(memwbWriteRegister), .WriteReg(memwbRegWrite), .DstData(regWriteData), .SrcData1(ifidSrcData1), .SrcData2(ifidSrcData2));
hazard hzrd(.br(ifidBranchEn), .opcode(exmemOpcode), .idRs(rs), .idRt(rt), .memRd(exmemWriteRegister), .stall(stall));
CPU_flags flags(.op(ifidInstr[15:12]), .out(cpuFlags));



assign ifidHalt = cpuFlags[11];
assign ifidRegDst = cpuFlags[10];
assign ifidAluSrc = cpuFlags[9];
assign ifidMemRead = cpuFlags[8];
assign ifidMemWrite = cpuFlags[7];
assign ifidMemToReg = cpuFlags[6];
assign ifidRegWrite = cpuFlags[5];
assign ifidLLB = cpuFlags[4];
assign ifidLHB = cpuFlags[3];
assign ifidBranchEn = cpuFlags[2];
assign ifidBranchInstr = cpuFlags[1];
assign ifidPCS = cpuFlags[0];


assign rs = (ifidLLB | ifidLHB) ? rd : ifidInstr[7:4];
assign rt = (ifidMemRead | ifidMemWrite) ? ifidInstr[11:8] : ifidInstr[3:0];
assign rd = ifidInstr[11:8];
assign destReg = (ifidRegDst) ? rd : rt;
assign ifidImm = (ifidMemRead | ifidMemWrite) ? {{12{1'b0}},ifidInstr[3:0]} << 1 :
                   (ifidLLB) ? {{8{1'b0}},ifidInstr[7:0]} : 
                   (ifidLHB) ? (ifidInstr[7:0] << 8) : {{12{1'b0}},ifidInstr[3:0]};

assign rsrt[7:4] = rs;
assign rsrt[3:0] = rt;

assign flush = branchTaken;

//EXECUTE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
exmem exmemRegister(.clk(clk), .rst(~rst_n), .en(~stall_cache), .writeRegIn(idexWriteRegister), .haltIn(idexHalt), .memReadIn(idexMemRead), .memWriteIn(idexMemWrite),
                    .memToRegIn(idexMemToReg), .regWriteIn(idexRegWrite), .pcsIn(idexPCS), .rtForwardIn(rsrtForward[3:0]), .newPCIn(idexNewPC), .rtIn(idexSrcData2),
                    .aluIn(aluOut), .opcodeIn(idexOpcode),.writeRegOut(exmemWriteRegister), .haltOut(exmemHalt), .memReadOut(exmemMemRead), 
                    .memWriteOut(exmemMemWrite),.memToRegOut(exmemMemToReg), .regWriteOut(exmemRegWrite), .pcsOut(exmemPCS),
                    .rtForwardOut(rt_fwd), .newPCOut(exmemNewPC), .rtOut(exmemSrcData2), .aluOut(exmemAluOut), .opcodeOut(exmemOpcode), .instrIn(idexInstr), .instrOut(exmemInstr));
forward fwd(.exmemRegWrite(exmemRegWrite), .exmemMemWrite(exmemMemWrite), .memwbRegWrite(memwbRegWrite), .exmemDstReg(exmemWriteRegister), .memwbDstReg(memwbWriteRegister),
                    .idRs(rsrtForward[7:4]), .idRt(rsrtForward[3:0]), .exmemRt(rt_fwd), .memwbRd(memwbWriteRegister), .exmemRd(exmemWriteRegister), .exexForwardRs(exexRs), 
                    .exexForwardRt(exexRt), .memmemForwardRt(memmemRt), .memexForwardRs(memexRs), .memexForwardRt(memexRt));
ALU_16b aluEx(.rd(aluOut), .rs(rs_full), .rt(rt_full), .Opcode(idexOpcode), .FLAG(flag), .PC(pc), .rst(~rst_n), .clk(clk), .hlt(hlt), .inst(idexInstr));

assign rs_full = (idexMemRead | idexMemWrite) ? aluIn1 & 16'hfffe : 
              (idexLLB) ? (aluIn1 & 16'hff00) :
              (idexLHB) ? (aluIn1 & 16'h00ff) : aluIn1;

assign rt_full = (idexAluSrc) ? idexImm : aluIn2;

assign aluIn1 = exexRs ? exmemAluOut : memexRs ? regWriteData : idexSrcData1;
assign aluIn2 = exexRt ? exmemAluOut : memexRt ? regWriteData : idexSrcData2;





//MEMORY ACCESS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
memwb memwbRegister(.clk(clk), .rst(~rst_n), .en(~stall_cache), .writeRegIn(exmemWriteRegister), .haltIn(exmemHalt), .memToRegIn(exmemMemToReg), .regWriteIn(exmemRegWrite),
                    .pcsIn(exmemPCS), .newPCIn(exmemNewPC), .memIn(memDataOut), .rtIn(exmemAluOut),.writeRegOut(memwbWriteRegister), .haltOut(memwbHalt), .memToRegOut(memwbMemToReg),
                    .regWriteOut(memwbRegWrite), .pcsOut(memwbPCS), .newPCOut(memwbNewPC), .memOut(memwbMemDataOut), .rtOut(memwbAluOut));


// memory_data memory(.data_out(memDataOut), .data_in(memDataIn), .addr(exmemAluOut), .enable(memEnable), .wr(exmemMemWrite), .clk(clk), .rst(~rst_n));

assign memEnable = (exmemMemRead | exmemMemWrite);
assign memDataIn = memmemRt ? regWriteData : exmemSrcData2;


//WRITEBACK /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign regWriteData = (memwbMemToReg) ? memwbMemDataOut : (memwbPCS) ? memwbNewPC : memwbAluOut;


endmodule