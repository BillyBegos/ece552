module Cache_fill_FSM(clk, rst_n, miss_detected, miss_address, fsm_busy, write_data_array, write_tag_array, memory_address, cacheAddr, memory_data, memory_data_valid, forceReset, cacheMemEnable);

input clk, rst_n, memory_data_valid, forceReset, miss_detected;
input [15 : 0] miss_address, memory_data;

output fsm_busy, write_data_array, write_data_array, write_tag_array, cacheMemEnable;
output [15 : 0] memory_address, cacheAddr;

wire [3 : 0] countD, countQ, addrD, addrQ;
wire [15 : 0] baseAddr, addrPlusTwo, addrPlusTwoC, cAddr, nextAddr, cAddrC, nextAddrC, readComplete;

assign baseAddr = {miss_address[15 : 4], {4'b0000}};
assign nextAddr = (addrQ == 0) ? baseAddr : addrPlusTwo;
assign nextAddrC = (addrQ == 0) ? baseAddr : (memory_data_valid) ? addrPlusTwoC : cAddrC;
assign readComplete = (addrQ == 9) ? 1 : 0;
assign cacheMemEnable = (readComplete | (addrQ == 0));
assign write_tag_array = (countQ == 8) ? 1 : 0;
assign write_data_array = (memory_data_valid & miss_detected) ? 1 : 0;
assign fsm_busy = miss_detected;
assign memory_address = cAddr;
assign cacheAddr = cAddrC;

Register_4b count(.clk(clk), .rst(~miss_detected | ~rst_n | (countQ == 8) | forceReset), .D(countD), .WriteReg((countQ != 8) & (memory_data_valid)), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(countQ), .Bitline2());
Register_4b qCount(.clk(clk), .rst(~miss_detected | ~rst_n | forceReset), .D(addrD), .WriteReg((addrQ != 9)), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(addrQ), .Bitline2());
Register currentAddr(.clk(clk), .rst(~miss_detected | ~rst_n), .D(nextAddr), .WriteReg(1'b1), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(cAddr), .Bitline2());
Register workAddr(.clk(clk), .rst(~miss_detected | ~rst_n), .D(nextAddrC), .WriteReg(1'b1), .ReadEnable1(1'b1), .ReadEnable2(1'b0), .Bitline1(cAddrC), .Bitline2());
CLA_4b countInc(.A(countQ), .B({3'b000, miss_detected}), .Cin(1'b0), .Sum(countD), .P(), .G(), . Cout());
CLA_4b coundAddrInc(.A(addrQ), .B({3'b000, miss_detected}), .Cin(1'b0), .Sum(addrD), .P(), .G(), . Cout());
CLA_16b addrInc(.A(cAddr), .B(16'd2), .Sum(addrPlusTwo), .Cout(), .ovfl(), .addSub(1'b0));
CLA_16b addrIncCache(.A(cAddrC), .B(16'd2), .Sum(addrPlusTwoC), .Cout(), .ovfl(), .addSub(1'b0));
endmodule