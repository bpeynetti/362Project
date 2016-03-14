module testbench;

	//testing the 4 to 16 decoder
    reg [0:3] x;
    reg en;
    wire [0:15] z;

    decoder_4to16 DECODER(x,en,z);
    
    initial begin
        $monitor("x=%x en=%b z=%b ",x,en,z);

        #0 x=4'b0000; en=1'b0;
        #1 x=4'b0000; en=1'b1;
        #1 x=4'b0001; en=1'b1;
        #1 x=4'b0010; en=1'b1;


    end
endmodule // testbench
