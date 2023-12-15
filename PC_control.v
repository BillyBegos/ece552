module PC_control(input branch, input [2:0]C, input [8:0]I, input [2:0]F, input [3:0]Opcode, input [15:0]PC_in, output[15:0] PC_out, output branchTaken);
	
	wire N, V, Z;
	wire [9:0] offset_sll;
	wire [15:0] sign_extend_offset;
	wire [15:0] takenAddr;
	wire [15:0] notTakenAddr;
	wire[5:0] oneExtend, zeroExtend;
	wire Ovfl;
	wire Cout;
	reg [15:0] addr;
	reg take;
	assign Z = F[0];
	assign V = F[1];
	assign N = F[2];
	assign offset_sll = I << 1;
	assign oneExtend = 6'b111111;
	assign zeroExtend = 6'b0;
	assign sign_extend_offset = (offset_sll[9] == 1) ? {oneExtend, offset_sll} : {zeroExtend, offset_sll}; 
	
	//CLA_16b pc2(.A(PC_in), .B(16'h2), .Sum(notTakenAddr), .Cout(Cout), .ovfl(Ovfl), .addSub(1'b0));
	assign notTakenAddr = PC_in + 2;
	CLA_16b offset(.A(notTakenAddr), .B(sign_extend_offset), .Sum(takenAddr), .Cout(Cout), .ovfl(Ovfl), .addSub(1'b0));

always@(*) begin
        case (C)
            3'b000: begin addr = (~F[0] ? takenAddr: notTakenAddr); take = (~F[0] ? 1'b1: 1'b0); end
            3'b001: begin addr = (F[0] ? takenAddr: notTakenAddr); take = (F[0] ? 1'b1: 1'b0); end
            3'b010: begin addr = ((~F[0] == ~F[2]) ? takenAddr: notTakenAddr); take = ((~F[0] == ~F[2]) ? 1'b1: 1'b0); end
            3'b011: begin addr = (F[2] ? takenAddr: notTakenAddr); take = ((~F[0] == ~F[2]) ? 1'b1: 1'b0); end
            3'b100: begin addr = ((F[0]|(~F[0] == ~F[2])) ? takenAddr: notTakenAddr); take = ((F[0]|(~F[0] == ~F[2])) ? 1'b1: 1'b0); end
            3'b101: begin addr = ((F[2]|F[0]) ? takenAddr: notTakenAddr); take = ((F[2]|F[0]) ? 1'b1: 1'b0); end
            3'b110: begin addr = (F[1] ? takenAddr: notTakenAddr); take = (F[1] ? 1'b1: 1'b0); end
            3'b111: begin addr = takenAddr; take = 1'b1; end
            default: begin addr = notTakenAddr; take = 1'b0; end
       endcase
   end

assign PC_out = (branch) ? addr : notTakenAddr;
assign branchTaken = (branch) ? take : 1'b0;

// always @(*) begin
//     $display("pc in: %b, pc out %b", PC_in, PC_out);
// end

endmodule
