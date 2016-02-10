
IVERILOG = iverilog


default: register1 register32

# decoder:


register1:
	iverilog -o ./bin/test_r1 -s test_r1 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

register32:
	iverilog -o ./bin/test_r32 -s test_r32 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v