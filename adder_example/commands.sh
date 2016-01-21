#! /usr/bin/env sh

iverilog -o tests/adder_test -s testbench adder.v tests/adder_test.v
iverilog -o tests/32bit_test -s testbench adder.v tests/32bit_test.v
iverilog -o tests/adder32_test -s testbench adder.v tests/adder32_test.v

## Example for automated testing
#./tests/adder_test > ./tests/adder_test.output
#diff -q ./tests/adder_test.output ./tests/baseline/adder_test.output
