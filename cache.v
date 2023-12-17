module cache(clk, rst, opAddr, rEn, cacheOp, cacheDataIn, cacheDataOut, cacheMiss);
input clk, rst, rEn; 
input [15 : 0] opAddr, cacheDataIn;
input [1 : 0] cacheOp;

output cacheMiss;
output [15 : 0] cacheDataOut; 

wire hitW0, hitW1, hitW2, hitW3, dataWe, tagWe, validN0, validN1, validN2, validN3, hit;
wire [1 : 0] lruW0, lruW1, lruW2, lruW3;
wire [2 : 0] sel;
wire [3 : 0] valid, miss;
wire [4 : 0] setIndex;
wire [6 : 0] tagN0, tagN1, tagN2, tagN3, tagIn, tagOut0, tagOut1, tagOut2, tagOut3;
wire [7 : 0] tagRaw0, tagRaw1, tagRaw2, tagRaw3, wordEnable, tagFull0, tagFull1, tagFull2, tagFull3;
wire [15 : 0] dataArrayOut;
wire [31 : 0] blockDecode;
wire [127 : 0] blockDecodeData, blockDecodeZe; 

assign hitW0 = valid[0] & (tagIn == tagOut0);
assign hitW1 = valid[1] & (tagIn == tagOut1);
assign hitW2 = valid[2] & (tagIn == tagOut2);
assign hitW3 = valid[3] & (tagIn == tagOut3);
assign cacheMiss = rEn & ~(hitW0 | hitW1 | hitW2 | hitW3);
assign hit = rEn & (hitW0 | hitW1 | hitW2 | hitW3);
assign cacheDataOut = rEn ? blockDecodeData != {128{1'b0}} ? dataArrayOut : {16{1'b0}} : {16{1'b0}};
assign tagIn = opAddr[15 : 9];
assign tagOut0 = tagRaw0[6 : 0];
assign tagOut1 = tagRaw1[6 : 0];
assign tagOut2 = tagRaw2[6 : 0];
assign tagOut3 = tagRaw3[6 : 0];
assign setIndex = opAddr[8 : 4];
assign valid = {tagRaw3[7], tagRaw2[7], tagRaw1[7], tagRaw0[7]};
assign blockDecodeZe = {{96{1'b0}}, blockDecode};
assign sel = opAddr[3 : 1];

assign dataWe = rEn ? cacheOp == 2'b01 ? 1 : 0 : 0;
assign tagWe = rEn ?cacheOp == 2'b10 ? 1 : cacheOp == 2'b00 ?hit ? 1 : 0 : 0 : 0;
assign validN0 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[0] == 1 ? 1 : valid[0] : valid[0] : valid[0]; 
assign validN1 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[1] == 1 ? 1 : valid[1] : valid[1] : valid[1];
assign validN2 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[2] == 1 ? 1 : valid[2] : valid[2] : valid[2]; 
assign validN3 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[3] == 1 ? 1 : valid[3] : valid[3] : valid[3]; 
assign tagN0 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[0] == 1 ? tagIn : tagRaw0 : tagOut0 : tagOut0;
assign tagN1 = cacheOp == 2'b10 ? cacheMiss == 1 ? miss[1] == 1 ? tagIn : tagRaw1 : tagOut1 : tagOut1;
assign tagN2 = cacheOp == 2'b10 ?cacheMiss == 1 ? miss[2] == 1 ? tagIn : tagRaw2 : tagOut2 : tagOut2;
assign tagN3 = cacheOp == 2'b10 ?cacheMiss == 1 ? miss[3] == 1 ? tagIn : tagRaw3 : tagOut3 : tagOut3;
assign miss = lruW0 == 2'b00 ? 4'b0001 : lruW1 == 2'b00 ? 4'b0010 : lruW2 == 2'b00 ? 4'b0100 : lruW3 == 2'b00 ? 4'b1000 : 4'b0000;
assign tagFull0 = {validN0, tagN0};
assign tagFull1 = {validN1, tagN1};
assign tagFull2 = {validN2, tagN2};
assign tagFull3 = {validN3, tagN3};
assign blockDecodeData = cacheOp == 2'b00 ? hitW0 == 1 ? blockDecodeZe : hitW1 == 1 ? blockDecodeZe << 32 : hitW2 == 1 ? blockDecodeZe << 64 : hitW3 == 1 ? blockDecodeZe << 96 : {128{1'b0}} : cacheOp == 2'b01 ? cacheMiss == 1 ?miss[0] == 1 ? blockDecodeZe : miss[1] == 1 ? blockDecodeZe << 32 : miss[2] == 1 ? blockDecodeZe << 64 : miss[3] == 1 ? blockDecodeZe << 96 : {128{1'b0}} : hitW0 == 1 ? blockDecodeZe : hitW1 == 1 ? blockDecodeZe << 32 : hitW2 == 1 ? blockDecodeZe << 64 : hitW3 == 1 ? blockDecodeZe << 96 : {128{1'b0}} : {128{1'b0}};

LRU lru(.clk(clk), .rst(rst), .select(setIndex), .out0(lruW0), .out1(lruW1), .out2(lruW2), .out3(lruW3), .hitW0(hitW0), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hit_occurred(hit), .miss_occurred(cacheMiss), .miss(miss));
Decoder532 dataDecide(.in(setIndex), .out(blockDecode));
Decoder38 wordDecode(.in(sel), .out(wordEnable));
DataArray data(.clk(clk), .rst(rst), .DataIn(cacheDataIn), .Write(dataWe), .BlockEnable(blockDecodeData), .WordEnable(wordEnable), .DataOut(dataArrayOut));
MetaDataArray tag0(.clk(clk), .rst(rst), .DataIn(tagFull0), .Write(tagWe), .BlockEnable(blockDecode), .DataOut(tagRaw0));
MetaDataArray tag1(.clk(clk), .rst(rst), .DataIn(tagFull1), .Write(tagWe), .BlockEnable(blockDecode), .DataOut(tagRaw1));
MetaDataArray tag2(.clk(clk), .rst(rst), .DataIn(tagFull2), .Write(tagWe), .BlockEnable(blockDecode), .DataOut(tagRaw2));
MetaDataArray tag3(.clk(clk), .rst(rst), .DataIn(tagFull3), .Write(tagWe), .BlockEnable(blockDecode), .DataOut(tagRaw3));
endmodule
