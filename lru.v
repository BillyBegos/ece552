module LRU(clk, rst, select, out0, out1, out2, out3, hitW0, hitW1, hitW2, hitW3, hit_occurred, miss_occurred, miss);

input clk, rst, hitW1, hitW2, hitW3, hitW0, hit_occurred, miss_occurred;
input [3 : 0] miss;
input [4 : 0] select;
output [1 : 0] out0, out1, out2, out3;

lruFile f0(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00000));
lruFile f1(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00001));
lruFile f2(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00010));
lruFile f3(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00011));
lruFile f4(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00100));
lruFile f5(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00101));
lruFile f6(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00110));
lruFile f7(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b00111));
lruFile f8(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01000));
lruFile f9(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01001));
lruFile f10(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01010));
lruFile f11(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01011));
lruFile f12(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01100));
lruFile f13(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01101));
lruFile f14(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01110));
lruFile f15(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b01111));
lruFile f16(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10000));
lruFile f17(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10001));
lruFile f18(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10010));
lruFile f19(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10011));
lruFile f20(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10100));
lruFile f21(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10101));
lruFile f22(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10110));
lruFile f23(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b10111));
lruFile f24(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11000));
lruFile f25(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11001));
lruFile f26(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11010));
lruFile f27(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11011));
lruFile f28(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11100));
lruFile f29(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11101));
lruFile f30(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11110));
lruFile f31(.clk(clk), .rst(rst), .miss(miss), .out0(out0), .out1(out1), .out2(out2), .out3(out3), .hitW1(hitW1), .hitW2(hitW2), .hitW3(hitW3), .hitW0(hitW0), .hit_occurred(hit_occurred), .miss_occurred(miss_occurred), .lruActive(select == 5'b11111));
endmodule

module lruFile(clk, rst, miss, lruActive, out0, out1, out2, out3, hitW1, hitW2, hitW3, hitW0, hit_occurred, miss_occurred);

input [3 : 0] miss;
input clk, rst, lruActive, hitW1, hitW2, hitW3, hitW0, hit_occurred, miss_occurred;
output [1 : 0] out0, out1, out2, out3;

reg [1 : 0] lruW0, lruW1, lruW2, lruW3;

assign out0 = lruActive ? lruW0 : {2{1'bz}};
assign out1 = lruActive ? lruW1 : {2{1'bz}};
assign out2 = lruActive ? lruW2 : {2{1'bz}};
assign out3 = lruActive ? lruW3 : {2{1'bz}};
	
	always @(posedge clk) begin

		if(rst == 1) begin
			lruW0 <= 2'b00;
			lruW1 <= 2'b00;
			lruW2 <= 2'b00;
			lruW3 <= 2'b00;
		end
		if(hit_occurred & !miss_occurred) begin
			if(hitW0) begin lruW0 <= 2'b11;
				if(lruW1 != 2'b00) lruW1 <= (lruW1 - 1);
				if(lruW2 != 2'b00) lruW2 <= (lruW2 - 1);
				if(lruW3 != 2'b00) lruW3 <= (lruW3 - 1);
			end
			if(hitW1) begin
				if(lruW0 != 2'b00) lruW0 <= (lruW0 - 1); lruW1 <= 2'b11;
				if(lruW2 != 2'b00) lruW2 <= (lruW2 - 1);
				if(lruW3 != 2'b00) lruW3 <= (lruW3 - 1);
			end
			if(hitW2) begin
				if(lruW0 != 2'b00) lruW0 <= (lruW0 - 1);
				if(lruW1 != 2'b00) lruW1 <= (lruW1 - 1); lruW2 <= 2'b11;
				if(lruW3 != 2'b00) lruW3 <= (lruW3 - 1);
			end
			if(hitW3) begin
				if(lruW0 != 2'b00) lruW0 <= (lruW0 - 1);
				if(lruW1 != 2'b00) lruW1 <= (lruW1 - 1);
				if(lruW2 != 2'b00) lruW2 <= (lruW2 - 1); lruW3 <= 2'b11;
			end
		end

	end


endmodule