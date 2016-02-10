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

// module test_r32;
//     reg inData;
//     reg clk;
//     reg reset;
    
//     wire q;

//     dff DFF(.data(Data),.clk(Clk),.reset(Rst),.q(q));
    
//     initial begin
//         $monitor("data=%x clk=%x reset=%x q=%x",Data,Clk,Rst,q);

//         #0 Data=1'b1; Clk=1'b0; Rst=1'b0; 
//         #1 Data=1'b1; Clk=1'b1; Rst=1'b1;
//         #2 Data=1'b1; Clk=1'b0; Rst=1'b1; 
//         #3 Data=1'b1; Clk=1'b1; Rst=1'b1; 
//         #4 Data=1'b0; Clk=1'b0; Rst=1'b1;
//         #5 Data=1'b0; Clk=1'b1; Rst=1'b1;
//         #6 Data=1'b1; Clk=1'b0; Rst=1'b1;


//     end
// endmodule // testbench
