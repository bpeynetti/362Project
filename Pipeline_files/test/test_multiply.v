module testbench;

	reg clock;
	reg reset;
	reg mul;
	reg [0:31] a,b;
	wire [0:63] result;
	wire working,done;
	
	multiplier top(
		.clk(clock),
		.reset(reset),
		.mul(mul),
		.a(a),
		.b(b),
		.result(result),
		.done(done),
		.working(working)
	);
	
	always begin 
		#1 clock = ~clock;
	end 
	
	initial begin 
   	$dumpvars(0);

		#0 clock = 0; reset = 1; mul=0;
		a = 2; b=2;
		#2 reset = 0;
		#3 mul=1;
		#16;
		if (done==1'b1) begin 
			$display ("Done");
			$finish;
		end
		$finish;
	end 
	
	initial begin 
	
		$monitor ("clk=%b, reset=%b, mul=%b, a=%d, b=%d, result=%d, working=%b, done=%b, CurrentState=%d NextState=%d",clock,reset,mul,a,b,result,working,done,top.CurrentState,top.NextState);
	end 
endmodule
