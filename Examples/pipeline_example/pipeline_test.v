module testbench;

	reg [0:31] data;
	reg clk,rst,flush;

	wire [0:31] out;


	pipeline PIPELINE(
		.data(data),
		.clk(clk),
		.rst(rst),
		.flush(flush),
		.out(out)
	);

	always 
		#1 clk = ~clk;


	initial
	begin
		$display("Starting - REMEMBER, rst is NEGATIVE (0=reset signals)");
		clk = 1'b0;
		rst = 1'b0;
		flush=1'b0;
		#2;
		rst = 1'b1;
		data = 32'd1;

		#2;
		
		data = 32'd2;
		#2;
		data = 32'd3;
		#2;
		data = 32'd4;
		#2;
		data = 32'd5;
		#2;
		data = 32'd6;
		#2;
		data = 32'd7;
		flush=1'b1;
		#2;
		data = 32'd8;
		flush=1'b0;
		#2;
		flush=1'b1;
		#15;
		$finish;
	end

	initial
	begin
		
		$monitor("clk=%b rst=%b flush=%b IF_data=%d ID_data=%d EX_data=%d MEM_data=%d WB_data=%d ",clk,rst,flush,PIPELINE.IF_data,PIPELINE.ID_data,PIPELINE.EX_data,PIPELINE.MEM_data,PIPELINE.WB_data);
	end
endmodule