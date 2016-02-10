
IVERILOG = iverilog


default: register1 register32 registerFile

# decoder:


register1:
	iverilog -o ./bin/test_r1 -s test_r1 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

register32:
	iverilog -o ./bin/test_r32 -s test_r32 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

registerFile:
	iverilog -o ./bin/test_regFile -s test_registerFile ../ALU_files/src/mux.v src/decoder.v src/dff.v src/register.v src/register_file.v tests/test_registerFile.v