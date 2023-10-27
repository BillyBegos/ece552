module base_3_shifter(Shift_Out, Shift_In, Shift_Val, Mode);

	input [15:0] Shift_In;
	input [3:0] Shift_Val;
	input [1:0] Mode;
	output [15:0] Shift_Out;

	wire [5:0] Base_3_Shift;

	wire [15:0] Barrel_Shift_0; //may shift by 1 bit
	wire [15:0] Barrel_Shift_1; //may shift by 2 bits
	wire [15:0] Barrel_Shift_2; //may shift by 3 bits
	wire [15:0] Barrel_Shift_3; //may shift by 6 bits

	base_3_converter conversion(.binary_shift_val(Shift_Val), .base_3_binary(Base_3_Shift));

	assign Barrel_Shift_0 = (Mode == 2'b01) ? ((Base_3_Shift[0] == 1) ? {Shift_In[15], Shift_In[15:1]} : Shift_In) :
			        (Mode == 2'b00) ? ((Base_3_Shift[0] == 1) ? {Shift_In[14:0], 1'b0} : Shift_In) : 
				((Base_3_Shift[0] == 1) ? {Shift_In[0], Shift_In[15:1]} : Shift_In);

	assign Barrel_Shift_1 = (Mode == 2'b01) ? ((Base_3_Shift[1] == 1) ? {{2{Barrel_Shift_0[15]}}, Barrel_Shift_0[15:2]} : Barrel_Shift_0) :
			        (Mode == 2'b00) ? ((Base_3_Shift[1] == 1) ? {Barrel_Shift_0[13:0], {2{1'b0}}} : Barrel_Shift_0) : 
				((Base_3_Shift[1] == 1) ? {Barrel_Shift_0[1:0], Barrel_Shift_0[15:2]} : Barrel_Shift_0);

	assign Barrel_Shift_2 = (Mode == 2'b01) ? ((Base_3_Shift[2] == 1) ? {{3{Barrel_Shift_1[15]}}, Barrel_Shift_1[15:3]} : Barrel_Shift_1) :
			        (Mode == 2'b00) ? ((Base_3_Shift[2] == 1) ? {Barrel_Shift_1[12:0], {3{1'b0}}} : Barrel_Shift_1) : 
				((Base_3_Shift[2] == 1) ? {Barrel_Shift_1[2:0], Barrel_Shift_1[15:3]} : Barrel_Shift_1);

	assign Barrel_Shift_3 = (Mode == 2'b01) ? ((Base_3_Shift[3] == 1) ? {{6{Barrel_Shift_2[15]}}, Barrel_Shift_2[15:6]} : Barrel_Shift_2) :
			        (Mode == 2'b00) ? ((Base_3_Shift[3] == 1) ? {Barrel_Shift_2[9:0], {6{1'b0}}} : Barrel_Shift_2) : 
				((Base_3_Shift[3] == 1) ? {Barrel_Shift_2[5:0], Barrel_Shift_2[15:6]} : Barrel_Shift_2);

	assign Shift_Out = (Mode == 2'b01) ? ((Base_3_Shift[4] == 1) ? {{9{Barrel_Shift_3[15]}}, Barrel_Shift_3[15:9]} : Barrel_Shift_3) :
			   (Mode == 2'b00) ? ((Base_3_Shift[4] == 1) ? {Barrel_Shift_3[6:0], {9{1'b0}}} : Barrel_Shift_3) : 
		           ((Base_3_Shift[4] == 1) ? {Barrel_Shift_3[8:0], Barrel_Shift_3[15:9]} : Barrel_Shift_3);

endmodule