module cacheController(clk, rst, instrWriteEn, dataWriteEn, dataEnable, instrAddress, dataAddress, 
instrOut, dataOut, instrIn, dataIn, instrMiss, dataMiss);

input clk, rst, dataEnable, instrWriteEn, dataWriteEn;
input [15 : 0] instrAddress, dataAddress, instrIn, dataIn;

output [15 : 0] instrOut, dataOut;
output instrMiss, dataMiss;
 
wire [15 : 0] memDataIn, memDataOut, memAddr, instrCacheAddrIn, dataCacheAddrIn, instrDataIn, dataDataIn, fsmAddrIn, fsmDataIn, currentAddr, nextAddr, cacheCurrAddr;
wire [3 : 0] instrIndex, dataIndex;
wire [1 : 0] missState, fsmState, fsmS0, fsmS1, cacheOp;
wire fsmEn, memEn, store, driving, validState, fsmDataFill, fsmTagFill, fsmEnabled, fsmUpdate, forceReset, updateEn, dataHitEn;
 
Cache_fill_FSM fsm(.clk(clk), .rst_n(~(~fsmEn | rst)), .miss_detected(fsmEn), .miss_address(fsmAddrIn), .fsm_busy(fsmEnabled), .write_data_array(fsmDataFill), 
    .write_tag_array(fsmTagFill), .memory_address(currentAddr), .cacheAddr(cacheCurrAddr), .memory_data(fsmDataIn), .forceReset(forceReset), .memory_data_valid(validState), .cacheMemEnable(memEn));
cache instr(.clk(clk), .rst(rst), .opAddr(instrCacheAddrIn), .rEn(1'b1), .cacheOp(fsmS0), .cacheDataIn(instrDataIn), .cacheDataOut(instrOut), .cacheMiss(instrMiss));
cache data(.clk(clk), .rst(rst), .opAddr(dataCacheAddrIn), .rEn(dataEnable), .cacheOp(cacheOp), .cacheDataIn(dataDataIn), .cacheDataOut(dataOut), .cacheMiss(dataMiss));
memory4c mem(.data_out(memDataOut), .data_in(memDataIn), .addr(nextAddr), .enable(( | missState & ~memEn) | updateEn | dataHitEn), .wr(updateEn | dataHitEn), .clk(clk), .rst(rst), .data_valid(validState));

assign dataOut = cacheOp == 2'b01 ? {16{1'b0}} : {16{1'bz}};
assign dataHitEn = store & ~fsmEn;
assign updateEn = missState == 2'b01 & store & fsmTagFill;
assign fsmUpdate = store ? fsmDataFill == 1 ? dataAddress[3 : 0] == cacheCurrAddr[3 : 0] ? 1 : 0 : 0 : 0;
assign cacheOp = dataHitEn ? 2'b01 : fsmS1;
assign nextAddr = (missState == 2'b01) ? (store) ? (fsmTagFill) ? fsmAddrIn : currentAddr : currentAddr : (dataHitEn) ? dataAddress : currentAddr;
assign instrOut = instrMiss ? {16{1'b0}} : {16{1'bz}};
assign dataOut = dataMiss ? {16{1'b0}} : ~dataEnable ? {16{1'b0}} : {16{1'bz}};
assign instrIndex = instrMiss ? fsmDataFill == 1 ? cacheCurrAddr[3 : 0] : instrAddress[3 : 0] : instrAddress[3 : 0];
assign dataIndex = dataMiss ? fsmDataFill == 1 ? cacheCurrAddr[3 : 0] : dataAddress[3 : 0] : dataAddress[3 : 0];
assign instrDataIn = instrMiss ? memDataOut : instrOut; 
assign dataDataIn = dataMiss ? store ? fsmUpdate ? dataIn : memDataOut : memDataOut : dataHitEn ? dataIn : dataOut;
assign instrCacheAddrIn = { instrAddress[15 : 4], instrIndex };
assign dataCacheAddrIn = { dataAddress[15 : 4], dataIndex };
assign missState = {instrMiss, dataMiss & dataEnable};
assign driving = missState == 2'b01 ? 0 : missState == 2'b10 ? 1 : missState == 2'b11 ? 1 : 0; 
assign fsmEn = missState == 2'b00 ? 0 : 1; 
assign fsmState = fsmTagFill == 1 ? 2'b10 : fsmDataFill == 1 ? 2'b01 : 2'b00; 
assign fsmS0 = instrMiss ? driving == 1 ? fsmState : 2'b00 : 2'b00;
assign fsmS1 = dataMiss ? driving == 0 ? fsmState : 2'b00 : 2'b00;
assign fsmAddrIn = driving == 1 ? instrAddress : dataAddress;
assign memAddr = fsmAddrIn;
assign store = dataWriteEn;
assign fsmDataIn = store ? driving == 1 ? instrIn : dataIn : memDataOut;
assign forceReset = missState == 2'b11 ? fsmTagFill == 1 ? 1 : 0 : 2'b00;
assign memDataIn = driving == 1 ? instrIn : dataIn;


endmodule