module RED_16b (A,B,Sum);
    input [15:0]A,B;
    output [15:0]Sum;

    wire [8:0]sumAB;
    wire carryALow;
    wire carryAHigh;

    wire [8:0]sumCD;
    wire carryBLow;
    wire carryBHigh;

    wire carryABCDLow;
    wire carryABCDHigh;

    wire [3:0] tempABCDHigh;

    CLA_4b ABLow(.A(A[3:0]),.B(A[11:8]),.Cin(1'b0), .Sum(sumAB[3:0]), .Cout(carryALow), .G(),.P());
    CLA_4b ABHigh(.A(A[7:4]),.B(A[15:12]),.Cin(carryALow),.Sum(sumAB[7:4]),.Cout(carryAHigh),.G(),.P());
    
    assign sumAB[8] = A[7] ^ A[15] ^ carryAHigh;

    CLA_4b CDLow(.A(B[3:0]),.B(B[11:8]),.Cin(1'b0),.Sum(sumCD[3:0]),.Cout(carryBLow),.G(),.P() );
    CLA_4b CDHigh(.A(B[7:4]),.B(B[15:12]),.Cin(carryBLow),.Sum(sumCD[7:4]),.Cout(carryBHigh),.G(),.P() );

    assign sumCD[8] = B[7] ^ B[15] ^ carryBHigh;

    CLA_4b ABCDLow(.A(sumAB[3:0]),.B(sumCD[3:0]), .Cin(1'b0),.Sum(Sum[3:0]), .Cout(carryABCDLow),.G(),.P());
    CLA_4b ABCDMid(.A(sumAB[7:4]),.B(sumCD[7:4]),.Cin(carryABCDLow),.Sum(Sum[7:4]), .Cout(carryABCDHigh), .G(),.P());
    CLA_4b ABCDHigh(.A({4{sumAB[8]}}),.B({4{sumCD[8]}}),.Cin(carryABCDHigh),.Sum(tempABCDHigh),.Cout(),.G(),.P());

    assign Sum[8] = tempABCDHigh[0];
    assign Sum[15:9] = {7{tempABCDHigh[1]}};

endmodule