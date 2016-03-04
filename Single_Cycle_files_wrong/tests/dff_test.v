module testbench;
    reg Data;
    reg Clk;
    reg Rst;
    wire q;

    dff DFF(.data(Data),.clk(Clk),.reset(Rst),.q(q));
    
    initial begin
        $monitor("data=%x clk=%x reset=%x q=%x",Data,Clk,Rst,q);

        #0 Data=1'b1; Clk=1'b0; Rst=1'b0; 
        #1 Data=1'b1; Clk=1'b1; Rst=1'b1;
        #2 Data=1'b1; Clk=1'b0; Rst=1'b1; 
        #3 Data=1'b1; Clk=1'b1; Rst=1'b1; 
        #4 Data=1'b0; Clk=1'b0; Rst=1'b1;
        #5 Data=1'b0; Clk=1'b1; Rst=1'b1;
        #6 Data=1'b1; Clk=1'b0; Rst=1'b1;


    end
endmodule // testbench
