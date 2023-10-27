module PADDSB_4b (Sum, A, B);
input [3:0] A, B; 
output [3:0] Sum;

wire Povfl,Novfl;
wire [3:0] tempSum;
wire[2:0] Cin;

full_adder_1b FA0 (.A(A[0]), .B(B[0]), .Cin(1'b0), .Cout(Cin[0]),.Sum(tempSum[0]));
full_adder_1b FA1 (.A(A[1]), .B(B[1]), .Cin(Cin[0]), .Cout(Cin[1]),.Sum(tempSum[1])); 
full_adder_1b FA2 (.A(A[2]), .B(B[2]), .Cin(Cin[1]), .Cout(Cin[2]),.Sum(tempSum[2])); 
full_adder_1b FA3 (.A(A[3]), .B(B[3]), .Cin(Cin[2]), .Cout(),.Sum(tempSum[3])); 

assign Povfl = (~A[3]) & (~B[3]) & (tempSum[3]); //Positive + positive -> negative = overflow
assign Novfl = (A[3] & B[3] & (~tempSum[3]));	//Negative + negative -> positive = overflow

assign Sum = (Povfl==1'b1) ? 4'b0111 : //satutrate if over/underflow
			 (Novfl==1'b1) ? 4'b1000 : 
			 tempSum;



endmodule
