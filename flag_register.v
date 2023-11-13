module flag_register(clk, rst, flagIn, flagOut, en);

input clk, rst;
input en;
inout [2:0] flagIn;
inout [2:0] flagOut;

dff ff0(.q(flagOut[0]), .d(flagIn[0]), .wen(en), .clk(clk), .rst(rst));
dff ff1(.q(flagOut[1]), .d(flagIn[1]), .wen(en), .clk(clk), .rst(rst));
dff ff2(.q(flagOut[2]), .d(flagIn[2]), .wen(en), .clk(clk), .rst(rst));

endmodule