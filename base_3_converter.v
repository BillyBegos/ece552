module base_3_converter(input [3:0] binary_shift_val, output reg [5:0] base_3_binary);

	always@(*) begin
		case (binary_shift_val)
			4'h0: base_3_binary = 6'b000000;
			4'h1: base_3_binary = 6'b000001;
			4'h2: base_3_binary = 6'b000010;
			4'h3: base_3_binary = 6'b000100;
			4'h4: base_3_binary = 6'b000101;
			4'h5: base_3_binary = 6'b000110;
			4'h6: base_3_binary = 6'b001000;
			4'h7: base_3_binary = 6'b001001;
			4'h8: base_3_binary = 6'b001010;
			4'h9: base_3_binary = 6'b010000;
			4'ha: base_3_binary = 6'b010001;
			4'hb: base_3_binary = 6'b010010;
			4'hc: base_3_binary = 6'b010100;
			4'hd: base_3_binary = 6'b010101;
			4'he: base_3_binary = 6'b010110;
			4'hf: base_3_binary = 6'b011000;
		endcase
	end

endmodule