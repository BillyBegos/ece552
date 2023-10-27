module base_3_shifter_tb();

	reg signed [15:0] Shift_In;
	reg [3:0] Shift_Val;
	reg [2:0] Mode;
	wire [15:0] Shift_Out;
	wire [15:0] SLL;
	wire [15:0] SRA;
	wire [15:0] ROR;

	base_3_shifter iDUT(.Shift_Out(Shift_Out), .Shift_In(Shift_In), .Shift_Val(Shift_Val), .Mode(Mode));

	assign SLL = Shift_In << Shift_Val;
	assign SRA = Shift_In >>> Shift_Val;
	assign ROR = (Shift_In << (16 - Shift_Val)) | (Shift_In >> Shift_Val);

	initial begin

		$display("Testing Shift Left Logical");

		repeat(10) begin

			Shift_In = $random;
			Shift_Val = $random;
			Mode = 0;

			#10

			$display("Must shift %b by %d", Shift_In, Shift_Val);
			$display("Target: %b", SLL);

			if(Shift_Out != SLL) begin
				$display("ERROR: Shift_Out should be %b, not %b!", SLL, Shift_Out);
				$stop();
			end
			$display("Target Reached!! %b", Shift_Out);
		end

		$display("SLL: Success");

		$display("Testing Shift Right Arithmetic");

		repeat(10) begin

			Shift_In = $random;
			Shift_Val = $random;
			Mode = 1;

			#10

			$display("Must shift %b by %d", Shift_In, Shift_Val);
			$display("Target: %b", SRA);

			if(Shift_Out != SRA) begin
				$display("ERROR: Shift_Out should be %b, not %b!", SRA, Shift_Out);
				$stop();
			end
			$display("Target Reached!! %b", Shift_Out);
		end

		$display("SRA: Success");

		$display("Testing Right Rotation");

		repeat(5) begin

			Shift_In = $random;
			Shift_Val = $random;
			Mode = 2'b10;

			#10

			$display("Must shift %b by %d", Shift_In, Shift_Val);
			$display("Target: %b", ROR);

			if(Shift_Out != ROR) begin
				$display("ERROR: Shift_Out should be %b, not %b!", ROR, Shift_Out);
				$stop();
			end
			$display("Target Reached!! %b", Shift_Out);
		end

		repeat(5) begin

			Shift_In = $random;
			Shift_Val = $random;
			Mode = 2'b11;

			#10

			$display("Must shift %b by %d", Shift_In, Shift_Val);
			$display("Target: %b", ROR);

			if(Shift_Out != ROR) begin
				$display("ERROR: Shift_Out should be %b, not %b!", ROR, Shift_Out);
				$stop();
			end
			$display("Target Reached!! %b", Shift_Out);
		end

		$display("ROR: Success");
	end

endmodule
