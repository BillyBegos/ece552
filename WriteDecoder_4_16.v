module WriteDecoder_4_16(input [3:0] RegId, input WriteReg, output [15:0] Wordline);

	wire [15:0] temp;
	assign temp = {15'b000000000000000, WriteReg};

	Shifter shift(.Shift_Out(Wordline), .Shift_In(temp), .Shift_Val(RegId), .Mode(1'b0));

endmodule
