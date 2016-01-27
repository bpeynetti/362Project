
IVERILOG = iverilog


default: and1 and32 or1 or32 mux1x1 mux2x1 mux4x1 mux8x1 mux16x1 not1 not32 xor1 xor32 zero32 shift setter alu

and1:
	iverilog -o ./bin/and1 -s testbench src/and.v tests/and1_test.v
and32:
	iverilog -o ./bin/and32 -s testbench src/and.v tests/and32_test.v

or1:
	iverilog -o ./bin/or1 -s testbench src/or.v tests/or1_test.v
or32:
	iverilog -o ./bin/or32 -s testbench src/or.v tests/or32_test.v

mux1x1:
	iverilog -o ./bin/mux1 -s testbench src/mux.v tests/mux1_test.v
mux2x1:
	iverilog -o ./bin/mux2x1 -s testbench src/mux.v tests/mux32_test.v
mux4x1:
	iverilog -o ./bin/mux4x1 -s testbench src/mux.v tests/mux32_4to1_test.v 
mux8x1:
	iverilog -o ./bin/mux8x1 -s testbench src/mux.v tests/mux32_8to1_test.v 
mux16x1:
	iverilog -o ./bin/mux16x1 -s testbench src/mux.v tests/mux32_16to1_test.v

not1:
	iverilog -o ./bin/not1 -s testbench src/not.v tests/not1_test.v
not32:
	iverilog -o ./bin/not32 -s testbench src/not.v tests/not32_test.v

xor1:
	iverilog -o ./bin/xor1 -s testbench src/xor.v tests/xor1_test.v
xor32:
	iverilog -o ./bin/xor32 -s testbench src/xor.v tests/xor32_test.v

zero32:
	iverilog -o ./bin/zero32 -s testbench src/or.v src/zero.v tests/zero32_test.v

shift:
	iverilog -o ./bin/shift -s testbench src/mux.v src/shift.v tests/shift_test.v

setter:
	iverilog -o ./bin/setter -s testbench src/or.v src/mux.v src/not.v src/and.v src/xor.v src/adder.v src/zero.v src/setter.v tests/setter_test.v

alu:
	iverilog -o ./bin/alu -s testbench src/and.v src/or.v src/xor.v src/not.v src/mux.v src/shift.v src/zero.v src/extend_1to32.v tests/alu_test.v