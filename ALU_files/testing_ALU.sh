

echo AND
iverilog -o tests/and1_test -s testbench and.v tests/and1_test.v
iverilog -o tests/and32_test -s testbench and.v tests/and32_test.v
./tests/and1_test
./tests/and32_test

echo OR
iverilog -o tests/or1_test -s testbench or.v tests/or1_test.v
iverilog -o tests/or32_test -s testbench or.v tests/or32_test.v
./tests/or1_test
./tests/or32_test

echo XOR
iverilog -o tests/xor1_test -s testbench xor.v tests/xor1_test.v
iverilog -o tests/xor32_test -s testbench xor.v tests/xor32_test.v
./tests/xor1_test
./tests/xor32_test

echo NOT
iverilog -o tests/not1_test -s testbench not.v tests/not1_test.v
iverilog -o tests/not32_test -s testbench not.v tests/not32_test.v

./tests/not1_test
./tests/not32_test

