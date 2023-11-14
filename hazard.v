module hazard(input br,input [3:0] opcode, input [3:0] idRs, input [3:0] idRt, input [3:0] memRd, output stall
);
reg tempStall;

wire enable;

assign enable = br;

always@(*) begin
    case(opcode)
        4'b0000: tempStall = enable & ((idRs == memRd) | (idRt == memRd));
        4'b0001: tempStall = enable & ((idRs == memRd) | (idRt == memRd));
        4'b0010: tempStall = enable & ((idRs == memRd) | (idRt == memRd));
        4'b0011: tempStall = enable & ((idRs == memRd) | (idRt == memRd));
        4'b1000: tempStall = enable & ((idRs == memRd) | (idRt == memRd));
        default: tempStall = 0;
    endcase
end

assign stall = tempStall;
endmodule