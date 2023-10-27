module PADDSB_16b (Sum, A, B);
input [15:0] A, B;
output [15:0] Sum;

PADDSB_4b ADD0(.Sum(Sum[3:0]), .A(A[3:0]), .B(B[3:0])); 
PADDSB_4b ADD1(.Sum(Sum[7:4]), .A(A[7:4]), .B(B[7:4])); 
PADDSB_4b ADD2(.Sum(Sum[11:8]), .A(A[11:8]), .B(B[11:8])); 
PADDSB_4b ADD3(.Sum(Sum[15:12]), .A(A[15:12]), .B(B[15:12])); 

endmodule