module mux2x32to32(
  output [31:0] DataOut,
  input [31:0] A,
  input [31:0] B,
  input Select
);
  assign DataOut = (Select) ? B : A;
endmodule

module mux3x32to32(
  output [31:0] DataOut,
  input [31:0] A,
  input [31:0] B,
  input [31:0] C,
  input [1:0] Select
);
  wire [31:0] DataOut1, DataOut2;

  mux2x32to32 muxAB(.DataOut(DataOut1), .A(A), .B(B), .Select(Select[1]));
  mux2x32to32 muxCA(.DataOut(DataOut2), .A(C), .B(A), .Select(Select[1]));
  mux2x32to32 muxABC(.DataOut(DataOut), .A(DataOut1), .B(DataOut2), .Select(Select[0]));
endmodule

