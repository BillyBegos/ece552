module addsub_4b (Sum, Ovfl, A, B, Cin);
input [3:0] A, B; 
output [3:0] Sum; 
output Ovfl;
input Cin;

wire [3:0] Cout;



full_adder_1b FA5 (.A(A[0]), .B(B[0]), .Cin(Cin), .Cout(Cout[0]),.Sum(Sum[0])); 
full_adder_1b FA6 (.A(A[1]), .B(B[1]), .Cin(Cout[0]), .Cout(Cout[1]),.Sum(Sum[1])); 
full_adder_1b FA7 (.A(A[2]), .B(B[2]), .Cin(Cout[1]), .Cout(Cout[2]),.Sum(Sum[2])); 
full_adder_1b FA8 (.A(A[3]), .B(B[3]), .Cin(Cout[2]), .Cout(Cout[3]),.Sum(Sum[3])); 


assign Ovfl = Cout[3]^Cout[2];

endmodule

module full_adder_1b (A,B,Cin,Cout,Sum); 
input A,B,Cin;
output Cout, Sum;

assign Sum = A^B^Cin;

assign Cout = (A&B) | (Cin&(A^B));

endmodule