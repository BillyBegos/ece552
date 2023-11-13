module cpu(
input clk,
input rst_n,
output hlt,
output [15:0] pc
); 



//pipeline wires
wire [15:0] newPC, ifidNewPC, idexNewPC, exmemNewPC, memwbNewPC, ifidOldPC;                     
wire [2:0] flag, en;                                                                          
wire [3:0] rs, rt, rd, rt_fwd, destReg, idexWriteRegister, exmemWriteRegister, memwbWriteRegister;   
wire [3:0] idexOpcode, exmemOpcode;                                                                
wire [7:0] rsrt_fwd;                                                                             
wire [15:0] instr, ifidInstr, idexInstr;                                                        
wire [15:0] ifidSrcData1, ifidSrcData2, idexSrcData1, idexSrcData2, exmemSrcData2, aluIn1, aluIn2;     
wire [15:0] aluOut, exmemAluOut, memwbAluOut;                                  
wire [15:0] memDataOut, memDataIn;                                                            
wire [15:0] regWriteData, memwbMemDataOut;                                         
wire [15:0] rs_full, rt_full;                                                             
wire [15:0] ifidImm, idexImm;                                  
wire [15:0] brAddr;                       
wire [11:0] cpuFlags;

//pipeline control signals
wire stall, flush, ifFlush, branchTaken;                                  
wire ifidHalt, idexHalt, exmemHalt, memwbHalt;                                 
wire ifidRegDst, idexRegDst;                                                               
wire ifidAluSrc, idexAluSrc;                                                                    
wire ifidMemRead, idexMemRead, exmemMemRead;                                        
wire ifidMemWrite, idexMemWrite, exmemMemWrite, memEnable;                               
wire ifidMemToReg, idexMemToReg, exmemMemToReg, memwbMemToReg;                              
wire ifidRegWrite, idexRegWrite, exmemRegWrite, memwbRegWrite;                            
wire ifidLLB, idexLLB;                                                                     
wire ifidLHB, idexLHB;                                                                  
wire ifidBranchEn, idexBranchEn;                                                                        
wire ifidBranchInstr, idexBranchInstr;                                                                      
wire ifidPCS, idexPCS, exmemPCS, memwbPCS;                                               

wire [7:0] rsrt;

wire extoexA, memtoexA, extoexB, memtoexB, memtomemB;

assign brAddr = (ifidBranchInstr) ? ifidSrcData1 : newPC;
assign ifFlush = ~rst_n | flush;
assign hlt = memwbHalt;

//FETCH INSTRUCTION ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ifid if_id(.clk(clk), .rst(ifFlush), .en(~stall), .opcIn(pc), .pcIn(brAddr), .instrIn(instr), .opcOut(ifidOldPC), .pcOut(ifidNewPC), .instrOut(ifidInstr));
PC_Register pcReg(.clk(clk), .rst(~rst_n), .d(brAddr), .wen(~(instr[15:12] == 4'hf && ~branchTaken)), .q(pc));
memory_instruction instruction(.data_out(instr), .data_in(16'b1), .addr(pc), .clk(clk), .rst(~rst_n), .enable(1'b1), .wr(1'b0));
PC_control pcControl(.branch(ifidBranchEn), .C(ifidInstr[11:9]), .I(ifidInstr[8:0]), .F(flag), .Opcode(ifidInstr[15:12]), .PC_in(ifidBranchEn ? ifidOldPC : pc), .PC_out(newPC), .branchTaken(branchTaken));

//DECODE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
idex id_ex(.clk(clk), .rst(~rst_n), .en(~stall), .haltIn(ifidHalt), .regDstIn(ifidRegDst), .aluSrcIn(ifidAluSrc), .memReadIn(ifidMemRead),
                    .memWriteIn(ifidMemWrite), .memToRegIn(ifidMemToReg),.regWriteIn(ifidRegWrite), .llbIn(ifidLLB),
                    .lhbIn(ifidLHB), .branchEnableIn(ifidBranchEn), .branchInstructIn(ifidBranchInstr), .pcsIn(ifidPCS), .opcodeIn(ifidInstr[15:12]), .regSourceIn(rsrt), .newPCIn(ifidNewPC), .writeRegIn(destReg), 
                    .srcData1In(ifidSrcData1), .srcData2In(ifidSrcData2), .immIn(ifidImm), .haltOut(idexHalt), .regDstOut(idexRegDst), .aluSrcOut(idexAluSrc),
                    .memReadOut(idexMemRead), .memWriteOut(idexMemWrite), .memToRegOut(idexMemToReg), .regWriteOut(idexRegWrite),
                    .llbOut(idexLLB), .lhbOut(idexLHB), .branchEnableOut(idexBranchEn), .branchInstructOut(idexBranchInstr), .pcsOut(idexPCS), .opcodeOut(idexOpcode), .regSourceOut(rsrt_fwd),
                    .newPCOut(idexNewPC), .writeRegOut(idexWriteRegister), .srcData1Out(idexSrcData1), .srcData2Out(idexSrcData2), .immOut(idexImm), .instrIn(ifidInstr), .instrOut(idexInstr));

RegisterFile rf(.clk(clk), .rst(~rst_n), .SrcReg1(rs), .SrcReg2(rt), .DstReg(memwbWriteRegister), .WriteReg(memwbRegWrite), .DstData(regWriteData), .SrcData1(ifidSrcData1), .SrcData2(ifidSrcData2));

CPU_flags flags(.op(ifidInstr[15:12]), .out(cpuFlags));
hazard hzd(.br(ifidBranchEn), .opcode(exmemOpcode), .idRs(rs), .idRt(rt), .memRd(exmemWriteRegister), .stall(stall));


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
exmem ex_mem(.clk(clk), .rst(~rst_n), .en(1'b1), .writeRegIn(idexWriteRegister), .haltIn(idexHalt), .memReadIn(idexMemRead), .memWriteIn(idexMemWrite),
                    .memToRegIn(idexMemToReg), .regWriteIn(idexRegWrite), .pcsIn(idexPCS), .rtForwardIn(rsrt_fwd[3:0]), .newPCIn(idexNewPC), .rtIn(idexSrcData2),
                    .aluIn(aluOut), .opcodeIn(idexOpcode),.writeRegOut(exmemWriteRegister), .haltOut(exmemHalt), .memReadOut(exmemMemRead), 
                    .memWriteOut(exmemMemWrite),.memToRegOut(exmemMemToReg), .regWriteOut(exmemRegWrite), .pcsOut(exmemPCS),
                    .rtForwardOut(rt_fwd), .newPCOut(exmemNewPC), .rtOut(exmemSrcData2), .aluOut(exmemAluOut), .opcodeOut(exmemOpcode));
ALU_16b aluEx(.rd(aluOut), .rs(rs_full), .rt(rt_full), .Opcode(idexOpcode), .FLAG(flag), .PC(pc), .rst(~rst_n), .clk(clk), .hlt(hlt), .inst(idexInstr));

forward fwd(.exmemRegWrite(exmemRegWrite), .exmemMemWrite(exmemMemWrite), .memwbRegWrite(memwbRegWrite), .exmemDstReg(exmemWriteRegister), .memwbDstReg(memwbWriteRegister),
                    .idRs(rsrt_fwd[7:4]), .idRt(rsrt_fwd[3:0]), .exmemRt(rt_fwd), .memwbRd(memwbWriteRegister), .exmemRd(exmemWriteRegister), .exexForwardRs(extoexA), 
                    .exexForwardRt(extoexB), .memmemForwardRt(memtomemB), .memexForwardRs(memtoexA), .memexForwardRt(memtoexB));

assign aluIn1 = extoexA ? exmemAluOut : memtoexA ? regWriteData : idexSrcData1;
assign aluIn2 = extoexB ? exmemAluOut : memtoexB ? regWriteData : idexSrcData2;

assign rs_full = (idexMemRead | idexMemWrite) ? aluIn1 & 16'hfffe : 
              (idexLLB) ? (aluIn1 & 16'hff00) :
              (idexLHB) ? (aluIn1 & 16'h00ff) : aluIn1;

assign rt_full = (idexAluSrc) ? idexImm : idexSrcData2;



//MEMORY ACCESS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
memwb mem_wb(.clk(clk), .rst(~rst_n), .en(1'b1), .writeRegIn(exmemWriteRegister), .haltIn(exmemHalt), .memToRegIn(exmemMemToReg), .regWriteIn(exmemRegWrite),
                    .pcsIn(exmemPCS), .newPCIn(exmemNewPC), .memIn(memDataOut), .rtIn(exmemAluOut),.writeRegOut(memwbWriteRegister), .haltOut(memwbHalt), .memToRegOut(memwbMemToReg),
                    .regWriteOut(memwbRegWrite), .pcsOut(memwbPCS), .newPCOut(memwbNewPC), .memOut(memwbMemDataOut), .rtOut(memwbAluOut));
memory_data dMem(.data_out(memDataOut), .data_in(memDataIn), .addr(exmemAluOut), .enable(memEnable), .wr(exmemMemWrite), .clk(clk), .rst(~rst_n));

assign memEnable = (exmemMemRead || exmemMemWrite);
assign memDataIn = memtomemB ? regWriteData : exmemSrcData2;


//WRITEBACK /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign regWriteData = (memwbMemToReg) ? memwbMemDataOut : (memwbPCS) ? memwbNewPC : memwbAluOut;


endmodule