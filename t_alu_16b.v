
module t_alu_16b();
	reg signed[15:0] in1;
	reg [15:0] in2;
	reg [3:0] op;
	wire[15:0] out;
    wire[2:0] flag;

	reg [7:0] stim;
    reg[3:0] a,b,c,d,e,f,g,h;
    reg[3:0] ae, bf, cg, dh;


	reg [2:0] Mode;
	wire [15:0] Shift_Out;
	wire [15:0] SLL;
	wire signed [15:0] SRA;
	wire signed [15:0] ROR;


	assign SLL = in1 << in2[3:0];
	assign SRA = in1 >>> in2[3:0];
	assign ROR = (in1 << (16 - in2[3:0])) | (in1 >> in2[3:0]);



    reg signed [7:0] redA, redB, redC, redD;
ALU_16b DUT(.rd(out),.rs(in1),.rt(in2),.Opcode(op),.FLAG(flag));
initial begin
//
//
// ADD
//
//
in1 = 16'd0;
in2 = 16'd0;
op = 4'b0000;
for (stim = 8'd0; stim < 8'd64; stim = stim + 1) begin
 #5;
	if($signed(out)!==$signed(in1)+$signed(in2))begin
        if(in1+in2 > 32767 && $signed(out)==32767) begin
            //$display("properly saturated for a positive number");
        end
        else if(in1+in2 < -32768 & $signed(out)==-32768) begin
            //$display("Properly saturated for a negative number");
        end
        else begin
		    $display("ERR: Sum should be %h with A=%d, B=%d, sum=%h", $signed(in1)+$signed(in2), $signed(in1),$signed(in2),$signed(out));
            $stop;
        end
	end
    if(out==0 && (~flag[0])) begin
        $display("error setting 0 flag for the adder");
        $stop;
    end
    else if(($signed(out)==32767 || $signed(out)==-32768) && ~flag[1]) begin
        $display("error setting overflow flag for the adder");
        $stop;
    end
    else if($signed(out)<0 && ~flag[2]) begin
        $display("error setting sign flag for the adder");
        $stop;
    end

in1=$random%65536;
in2=$random%65536;
end
$display("Add tests passed!");
//
//
// SUBTRACT
//
//

in1 = 16'd0;
in2 = 16'd0;
op = 4'b0001;
for (stim = 8'd0; stim < 8'd64; stim = stim + 1) begin
 #5;
	if($signed(out)!==$signed(in1)-$signed(in2))begin
        if(in1-in2 > 32767 && $signed(out)==32767) begin
            //$display("properly saturated for a negative number");
        end
        else if(in1-in2 < -32768 && $signed(out)== -32768) begin
            //$display("Properly saturated for a negative number");
        end
        else begin
		    $display("ERR: Sub should be %h with A=%d, B=%d, sum=%h", $signed(in1)-$signed(in2), $signed(in1),$signed(in2),$signed(out));
            $stop;
        end
	end
    if(out==0 && (~flag[0])) begin
        $display("error setting 0 flag for the sub");
        $stop;
    end
    else if(($signed(out)==32767 || $signed(out)==-32768) && ~flag[1]) begin
        $display("error setting overflow flag for the sub");
        $stop;
    end
    else if($signed(out)<0 && ~flag[2]) begin
        $display("error setting sign flag for the sub");
        $stop;
    end

in1=$random%65536;
in2=$random%63356;
end
$display("Subtract tests passed!");

//
//
// XOR 
//
//
in1 = 16'd0;
in2 = 16'd0;
op = 4'b0010;
for (stim = 8'd0; stim < 8'd15; stim = stim + 1) begin
 #5;
	if(out!= (in1^in2))begin
		$display("ERR: XOR should be %h with A=%h, B=%h, Output=%h", (in1^in2), in1,in2,out);
        $stop;
	end

in1=$random%65536;
in2=$random%65536;
end
$display("XOR tests passed!");
//
//
// RED
//
//
op = 4'b0011;
in1 = 0;
in2 =0;
for (stim = 8'd0; stim < 8'd64; stim = stim + 1) begin
    #2
    in1 = $random%65536;
    in2 = $random%65536;
    redA=in1[15:8];
    redB=in1[7:0];
    redC=in2[15:8];
    redD=in2[7:0];
    #3

    if($signed(out)!=redA+redB+redC+redD) begin
        $display("ERR: out should be %d with A= %d, B=%d, C=%d, D=%d, is actually %d", redA+redB+redC+redD, $signed(redA), $signed(redB), $signed(redC), $signed(redD), $signed(out));
        $stop;
    end
end
$display("RED tests passed!");
//
//
// PADDSB
//
//
op = 4'b0111;
for (stim = 8'd0; stim < 8'd15; stim = stim + 1) begin
    #3
in1 = $urandom%65536;
in2 = $urandom%65536;
a=in1[15:12];
b=in1[11:8];
c=in1[7:4];
d=in1[3:0];
e=in2[15:12];
f=in2[11:8];
g=in2[7:4];
h=in2[3:0];

#3
ae = out[15:12];
bf = out[11:8];
cg = out[7:4];
dh = out[3:0];
	if($signed(ae) != $signed(a) + $signed(e))begin
        if($signed(a) + $signed(e) > 7 && ($signed(ae) == 7)) begin

        end
        else if($signed(a) + $signed(e) < -8 && ($signed(ae) == -8)) begin

        end
        else begin
		    $display("ERR: ae should be %d with A=%d, E=%d, sum=%d", $signed(a)+$signed(e), $signed(a),$signed(e),$signed(ae));
            $stop;
        end
	end
    if($signed(bf) != $signed(b) + $signed(f))begin
        if($signed(b) + $signed(f) > 7 && ($signed(bf) == 7)) begin

        end
        else if($signed(b) + $signed(f) < -8 && ($signed(bf) == -8)) begin

        end
        else begin
		    $display("ERR: bf should be %d with B=%d, F=%d, sum=%d", $signed(b)+$signed(f), $signed(b),$signed(f),$signed(bf));
            $stop;
        end
	end
    if($signed(cg) != $signed(c) + $signed(g))begin
        if($signed(c) + $signed(g) > 7 && ($signed(cg) == 7)) begin

        end
        else if($signed(c) + $signed(g) < -8 && ($signed(cg) == -8)) begin

        end
        else begin
		    $display("ERR: cg should be %d with C=%d, G=%d, sum=%d", $signed(c)+$signed(g), $signed(c),$signed(g),$signed(cg));
            $stop;
        end
	end
    if($signed(dh) != $signed(d) + $signed(h))begin
        if($signed(d) + $signed(h) > 7 && ($signed(dh) == 7)) begin

        end
        else if($signed(d) + $signed(h) < -8 && ($signed(dh) == -8)) begin

        end
        else begin
		    $display("ERR: dh should be %d with D=%d, H=%d, sum=%d", $signed(d)+$signed(h), $signed(d),$signed(h),$signed(dh));
            $stop;
        end
	end

end
$display("PADDSB tests passed!");

//
//
// SHIFTER
//
//
    in2 = 16'b0;

    //$display("Testing Shift Left Logical");
    op = 3'b100;
		repeat(10) begin

			in1 = $random;
			in2[3:0] = $random;
            
            

			#10

			$display("Must shift %b by %d", in1, in2[3:0]);
			$display("Target: %b", SLL);

			if(out != SLL) begin
			    $display("ERROR: out should be %b, not %b!", SLL, out);
				$stop();
			end
			$display("Target Reached!! %b", out);
		end

		//$display("SLL: Success");

		//$display("Testing Shift Right Arithmetic");
        op = 3'b101;
		repeat(10) begin

			in1 = $random;
			in2[3:0] = $random;
			

			#10

			//$display("Must shift %b by %d", in1, in2[3:0]);
			//$display("Target: %b", SRA);

			if(out != SRA) begin
				//$display("ERROR: out should be %b, not %b!", SRA, out);
				$stop();
			end
			//$display("Target Reached!! %b", out);
		end

		//$display("SRA: Success");
        
		//$display("Testing Right Rotation");
        op = 3'b110;
		repeat(5) begin

			in1 = $random;
			in2[3:0] = $random;
			

			#10

			//$display("Must shift %b by %d", in1, in2[3:0]);
			//$display("Target: %b", ROR);

			if(out != ROR) begin
				//$display("ERROR: out should be %b, not %b!", ROR, out);
				$stop();
			end
		//$display("Target Reached!! %b", out);
		end

		repeat(5) begin

			in1 = $random;
			in2[3:0] = $random;
			Mode = 2'b11;

			#10

			//$display("Must shift %b by %d", in1, in2[3:0]);
			//$display("Target: %b", ROR);

			if(out != ROR) begin
				//$display("ERROR: out should be %b, not %b!", ROR, out);
				$stop();
			end
			//$display("Target Reached!! %b", out);
		end

		//$display("ROR: Success");
        $display("Shifter tests passed!");

        $display("*************************************");
        $display("***********ALL TESTS PASSED**********");
        $display("*************************************");


$stop;
end
endmodule