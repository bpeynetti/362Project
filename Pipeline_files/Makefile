SRC = ./test/test.asm
IVERILOG = iverilog
DLXASM = ../dlxasm

default: pipeline


register1:
	iverilog -o ./bin/test_r1 -s test_r1 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

register32:
	iverilog -o ./bin/test_r32 -s test_r32 ../ALU_files/src/mux.v src/dff.v src/register.v tests/register_test.v

registerFile:
	iverilog -o ./bin/test_regFile -s test_registerFile ../ALU_files/src/mux.v src/decoder.v src/dff.v src/register.v src/register_file.v tests/test_registerFile.v

pclogic:
	iverilog -o ./bin/test_pclogic -s testbench src/dff.v src/register.v ../ALU_files/src/mux.v src/extender.v ../ALU_files/src/adder.v ../ALU_files/src/and.v src/pc_logic.v tests/pclogic_test.v

multiplier:
	iverilog -o ./bin/test_multiplier -s testbench multiplier.v test/test_multiply.v

mux_nbit:
	iverilog -o ./bin/test_mux_n -s testbench src/lib/mux.v test/test_mux_n.v

pipeline:
	$(DLXASM) -C ./test/instr.hex -D ./test/data.hex $(SRC)
	$(IVERILOG) -o ./bin/test_pipe -s testbench src/lib/*.v src/*.v test/pipeline_test.v 

pipeline_stall:
	$(DLXASM) -C ./test/instr.hex -D ./test/data.hex $(SRC)
	$(IVERILOG) -o ./bin/test_pipe_stall -s testbench src/lib/*.v src/*.v test/pipeline_test_stall_in.v 

