module CPU_flags(op, out);
input[3:0] op;
output reg [11:0] out;

//Out[0] == Halt
//Out[1] == Register destination
//Out[2] == ALU source
//Out[3] == read from memory?
//Out[4] == write to memory?
//Out[5] == Load memory to register?
//Out[6] == register write enable
//Out[7] == LLB
//Out[8] == LHB
//Out[9] == Branch enable
//Out[10] == BR address enable
//Out[11] == PCS

always@(*) begin
    case (op)
        4'b00??: out = 12'b010000100000; //ADD/SUB/XOR/RED
        4'b0111: out = 12'b010000100000; //PADDSB
        4'b01??: out = 12'b011000100000; //SLL/SRA/ROR
        4'b1000: out = 12'b001101100000; //LW
        4'b1001: out = 12'b001010000000; //SW
        4'b1010: out = 12'b011000110000; //LLB
        4'b1011: out = 12'b011000101000; //LHB
        4'b1100: out = 12'b000000000100; //B
        4'b1101: out = 12'b000000000110; //BR
        4'b1110: out = 12'b000000100001; //PCS
        4'b1111: out = 12'b100000000000; //HALT
        default: out = 12'b0;

    endcase
end

endmodule