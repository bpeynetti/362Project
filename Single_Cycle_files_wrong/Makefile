SRC = ./tests/test.asm
IVERILOG = iverilog
DLXASM = ~/workspace/dlxasm

default: register1 register32 registerFile multiplier pclogic single_cycle

# decoder:


register1:
	iverilog -o ./bin/test_r1 -s test_r1 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

register32:
	iverilog -o ./bin/test_r32 -s test_r32 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

registerFile:
	iverilog -o ./bin/test_regFile -s test_registerFile ../ALU_files/src/mux.v src/decoder.v src/dff.v src/register.v src/register_file.v tests/test_registerFile.v

multiplier:
	iverilog -o ./bin/test_multiplier -s testbench src/multiplier.v tests/multiplier_test.v

pclogic:
	iverilog -o ./bin/test_pclogic -s testbench src/dff.v src/register.v ../ALU_files/src/mux.v src/extender.v ../ALU_files/src/adder.v ../ALU_files/src/and.v src/pc_logic.v tests/pclogic_test.v
	
single_cycle:
	$(DLXASM) -C ./tests/instr.hex -D ./tests/data.hex $(SRC)
	$(IVERILOG) -o ./bin/single_cycle -s testbench src/*.v ../ALU_files/src/*.v tests/single_cycle_test.v