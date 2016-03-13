module testbench;

	reg [0:44] A;
	reg [0:44] B;
	wire [0:44] out;
	reg sel;

	mux2to1_nbit #(45) MUX(
		.X(A),
		.Y(B),
		.sel(sel),
		.Z(out)
	);

	initial begin 
	$monitor("A=%h B=%h sel=%b out=%h",A,B,sel,out);
	end

	initial begin 
	#0 A = 45'd33;
	B = 45'd22;
	sel = 1'b0;
	#1 sel=1'b1;
	$finish;
	end
endmodule