module CLA_4b(A, B, Cin, Sum, P, G, Cout);
input [3:0] A, B;
input Cin;
output [3:0] Sum;
output P, G, Cout;

wire [3:0] p, g;
wire [4:0] c; 

wire Ovfl;

    assign g = A&B;
    assign p = A|B;

    assign P = p[3] & p[2] & p[1] & p[0];
    assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

    // carry gen
    assign c[0] = Cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);

    assign Cout = c[4];

    full_adder_1b FA0(.A(A[0]), .B(B[0]),.Cin(c[0]), .Sum(Sum[0]),.Cout());
    full_adder_1b FA1(.A(A[1]), .B(B[1]),.Cin(c[1]), .Sum(Sum[1]),.Cout());
    full_adder_1b FA2(.A(A[2]), .B(B[2]),.Cin(c[2]), .Sum(Sum[2]),.Cout());
    full_adder_1b FA3(.A(A[3]), .B(B[3]),.Cin(c[3]), .Sum(Sum[3]),.Cout());
endmodule
