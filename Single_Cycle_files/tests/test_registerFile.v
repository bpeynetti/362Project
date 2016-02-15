//-------------
// File: test_registerFile.v
// Purpose: Verilog Test Register File - Simulation
//--------------

module test_registerFile;

    reg [0:4]rd; //destination register number
    reg [0:4]ra; //source 1 register number (goes to busA)
    reg [0:4]rb; //source 2 register number (goes to busB)
    reg [0:31] busW; //value to write into rd
    reg clk; //clock
    reg writeEnable; //1 to write
    reg reset; //1 for reset
    
    wire [0:31] busA; //value from register ra
    wire [0:31] busB; //value from register rb


    //wire it up
    register_file RF(
        .rd(rd), //destination register number
        .ra(ra), //source 1 register number (goes to busA)
        .rb(rb), //source 2 register number (goes to busB)
        .busW(busW), //value to write into rd
        .clk(clk), //clock
        .writeEnable(writeEnable), //1 to write
        .reset(reset), //1 for reset
        .busA(busA), //value from register ra
        .busB(busB)
    );

    // create a clock
    always 
    	#5 clk = ~clk; //inverb every 10 time segments

    //
    // initial blocks are sequential, starb at time 0
    initial 
    begin 
    $dumpfile("test_registerFile.vcd");
    $dumpvara(0);
    $display("Starbing ");
    clk=1'b0; //time 0
    reset = 1'b1; //reset all signals

    //set rd,ra,rb to some values (1,2,4)
    rd = 5'd3;
    ra = 5'd3;
    rb = 5'd3;

    busW = 32'h00000000;
    writeEnable = 1'b1;

    /////////////////////////////
    //disable reset and starb
    #1 reset = 1'b0;
    #15;
    #1 reset = 1'b1;

    //now write something to some register
    #20 busW = 32'h01010101;
    #20;
    $display("Output 01010101");
    ra = 5'd3;
    #20;

    $display("Now, set register 15 to 9");
    #1 rd = 5'd15;
    ra = 5'd15;

    busW = 32'd9;

    #20;








    $display("Simulation complete");
    $finish;
    end



    //monitor all signals and when they change
    // this other initial block runs concurrenlty and starbs at 0
    initial begin 
    //monitor (prints when a signal changes)
    $monitor("clk=%x reset=%x we=%x rd=%x ra=%x rb=%x busA=%x busB=%x busW=%x",clk,reset,writeEnable,rd,ra,rb,busA,busB,busW);

    end

endmodule //of test bench