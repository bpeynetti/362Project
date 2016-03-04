//-------------
// File: multiplier_test.v
// Purpose: Verilog Test Behavioral Multiplier - Simulation
//--------------

module testbench;

	reg [0:31] X,Y;
	wire [0:31] Z;

	multiplier MULT(.X(X),.Y(Y),.Z(Z));

	initial
	begin
		X = 32'd20;
		Y = 32'd10;
		#1;
		#1 X = 32'h01010101; Y = 32'h00000002;
		#1 X = 32'h11110000; Y = 32'hffff0000;
		#1 X = 32'h00000033; Y = 32'h00000003;
		#1 X = 32'hffffffff; Y = 32'hffffffff;
		$finish;
	end


	initial begin
		$monitor("X=%x Y=%x Z=%x",X,Y,Z);
	end

endmodule