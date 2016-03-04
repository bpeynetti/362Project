module test_r1;
    reg inData;
    reg clk;
    reg we;
    reg reset;
    wire outData;


    register1 REG1(.inData(inData),.clk(clk),.reset(reset),.writeEnable(we),.outData(outData));
    
    initial begin
        $monitor("inData=%x clk=%x reset=%x we=%x outData=%x",inData,clk,reset,we,outData);

        #0 inData=1'b1; clk=1'b0; reset=1'b0; we=1'b0; 
        #1 inData=1'b1; clk=1'b1; reset=1'b1; we=1'b0;
        #2 inData=1'b1; clk=1'b0; reset=1'b1; we=1'b0; 
        #3 inData=1'b1; clk=1'b1; reset=1'b1; we=1'b0;
        #4 inData=1'b0; clk=1'b0; reset=1'b1; we=1'b0;
        #5 inData=1'b0; clk=1'b1; reset=1'b1; we=1'b0;
        #6 inData=1'b1; clk=1'b0; reset=1'b1; we=1'b1;
        #3 inData=1'b1; clk=1'b1; reset=1'b1; we=1'b1;
        #4 inData=1'b0; clk=1'b0; reset=1'b1; we=1'b1;
        #5 inData=1'b0; clk=1'b1; reset=1'b1; we=1'b1;
        #6 inData=1'b1; clk=1'b0; reset=1'b1; we=1'b1;


    end
endmodule // testbench

module test_r32;
    reg [0:31] inData;
    reg clk;
    reg we;
    reg reset;
    wire [0:31] outData;


    register32 REG32(.inData(inData),.clk(clk),.reset(reset),.writeEnable(we),.outData(outData));
    
    initial begin
        $monitor("inData=%x clk=%x reset=%x we=%x outData=%x",inData,clk,reset,we,outData);

        #0 inData=32'h00000001; clk=1'b0; reset=1'b0; we=1'b0; 
        #1 inData=32'h00000001; clk=1'b1; reset=1'b0; we=1'b0;
        #1 inData=32'h00000001; clk=1'b0; reset=1'b1; we=1'b0; 
        #1 inData=32'h00000001; clk=1'b1; reset=1'b1; we=1'b0;
        #1 inData=32'h00000001; clk=1'b0; reset=1'b1; we=1'b1;
        #1 inData=32'h00000001; clk=1'b1; reset=1'b1; we=1'b1;
        #1 inData=32'h00000001; clk=1'b0; reset=1'b1; we=1'b1;
        #1 inData=32'h00000001; clk=1'b1; reset=1'b1; we=1'b1;
        #1 inData=32'h00000002; clk=1'b0; reset=1'b1; we=1'b0;
        #1 inData=32'h00000002; clk=1'b1; reset=1'b1; we=1'b0;
        #1 inData=32'h00000003; clk=1'b0; reset=1'b1; we=1'b1;
        #1 inData=32'h00000003; clk=1'b1; reset=1'b1; we=1'b1;
        #1 inData=32'h00000001; clk=1'b0; reset=1'b0; we=1'b1;
        #1 inData=32'h00000001; clk=1'b1; reset=1'b0; we=1'b1;
        #1 inData=32'h00000001; clk=1'b0; reset=1'b1; we=1'b0;
        #1 inData=32'h00000001; clk=1'b1; reset=1'b1; we=1'b1;


    end
endmodule // testbench