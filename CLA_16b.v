module CLA_16b(A, B, Sum, Cout, ovfl, addSub);
input [15:0] A,B;
input addSub;

output [15:0] Sum;
output Cout, ovfl;

wire [15:0] b, tempSum;
wire [3:0] Cin, P, G;
wire Povfl, Novfl;

assign b = (addSub==1'b1) ? (~B) : B;
assign Cin[0] = addSub;

assign Cin[1] = G[0] | (P[0]&Cin[0]);
assign Cin[2] = G[1] | (P[1]&Cin[1]);
assign Cin[3] = G[2] | (P[2]&Cin[2]);



CLA_4b CLA0(.A(A[3:0]), .B(b[3:0]), .Cin(Cin[0]), .Sum(tempSum[3:0]), .P(P[0]), .G(G[0]),.Cout());
CLA_4b CLA1(.A(A[7:4]), .B(b[7:4]), .Cin(Cin[1]), .Sum(tempSum[7:4]), .P(P[1]), .G(G[1]),.Cout());
CLA_4b CLA2(.A(A[11:8]), .B(b[11:8]), .Cin(Cin[2]), .Sum(tempSum[11:8]), .P(P[2]), .G(G[2]),.Cout());
CLA_4b CLA3(.A(A[15:12]), .B(b[15:12]), .Cin(Cin[3]), .Sum(tempSum[15:12]), .P(P[3]), .G(G[3]),.Cout());

assign Cout = G[3] | P[3]&Cin[3];

//check for positive or negative overflow
assign Novfl = (A[15] & b[15] & (~tempSum[15]));
assign Povfl = (~A[15] & (~b[15]) & (tempSum[15])); 
assign ovfl = Povfl | Novfl;



assign Sum = Povfl ? 16'h7FFF : //if there is overflow then saturate
			    Novfl ? 16'h8000 : 
             tempSum;
endmodule 