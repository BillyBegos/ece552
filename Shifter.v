module Shifter(Shift_Out, Shift_In, Shift_Val, Mode);

	input [15:0] Shift_In;
	input [3:0] Shift_Val;
	input Mode;
	output [15:0] Shift_Out;
	
	wire [15:0] Barrel_Shift_0;
	wire [15:0] Barrel_Shift_1;
	wire [15:0] Barrel_Shift_2;

	assign Barrel_Shift_0 = (Mode == 1) ? ((Shift_Val[0] == 1) ? {Shift_In[15], Shift_In[15:1]} : Shift_In) :
					      ((Shift_Val[0] == 1) ? {Shift_In[14:0], 1'b0} : Shift_In);

	assign Barrel_Shift_1 = (Mode == 1) ? ((Shift_Val[1] == 1) ? {{2{Barrel_Shift_0[15]}}, Barrel_Shift_0[15:2]} : Barrel_Shift_0) :
				 	      ((Shift_Val[1] == 1) ? {Barrel_Shift_0[13:0], {2{1'b0}}} : Barrel_Shift_0);

	assign Barrel_Shift_2 = (Mode == 1) ? ((Shift_Val[2] == 1) ? {{4{Barrel_Shift_1[15]}}, Barrel_Shift_1[15:4]} : Barrel_Shift_1) :
					      ((Shift_Val[2] == 1) ? {Barrel_Shift_1[11:0], {4{1'b0}}} : Barrel_Shift_1);

	assign Shift_Out = (Mode == 1) ? ((Shift_Val[3] == 1) ? {{8{Barrel_Shift_2[15]}}, Barrel_Shift_2[15:8]} : Barrel_Shift_2) :
			                 ((Shift_Val[3] == 1) ? {Barrel_Shift_2[7:0], {8{1'b0}}} : Barrel_Shift_2);

endmodule
