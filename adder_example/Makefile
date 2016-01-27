

IVERILOG = iverilog


default: mux4x1 mux8x1

mux4x1:
	iverilog -o ./bin/mux4x1 -s testbench mux.v tests/mux32_4to1_test.v 

mux8x1:
	iverilog -o ./bin/mux8x1 -s testbench mux.v tests/mux32_8to1_test.v 
	

	
# mux4x1
# 	$(iverilog) ../path_to_mux2x1 _path_to_mux4x1 _path_to_tb_mux4x1 -o ./bin_mux4x1

# clean:
	# //// remove stuff


# make mux2x1
# 	will only build one of them

# then go to bin
# and run all the test benches
# ./mux2x1
# ./mux4x1

