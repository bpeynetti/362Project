module multiplier(clk,reset,mul,a,b,done,working,result);

	input clk,reset,mul;
	input [0:31] a,b;
	output done,working;
	output [0:63] result;
	

	wire [0:15] a_h,a_l,b_h,b_l;
	
	assign a_h = a[0:15];
	assign a_l = a[16:31];
	assign b_h = b[0:15];
	assign b_l = b[16:31];
	//state encoding
	localparam STATE_Initial = 3'd0,
				STATE_1 = 3'd1,
				STATE_2 = 3'd2,
				STATE_3 = 3'd3,
				STATE_4 = 3'd4,
				STATE_5 = 3'd5,
				STATE_6 = 3'd6,
				STATE_7 = 3'd7;
	
	reg [0:2] CurrentState,NextState;
	
	reg [0:31] H,L,Z,P; 
	reg [0:63] result;
	reg working,done;
	
	//synchronous state transition
	always @ (posedge clk) begin
		if (~reset)  
			CurrentState <= STATE_Initial;
		else 
			CurrentState <= NextState;
	end

	
	always @ (*) begin
		NextState = CurrentState;
		case (CurrentState)
			STATE_Initial: begin 
				if (mul==1'b0) 
					NextState = STATE_Initial;
				else
					NextState = STATE_1;
			end
			STATE_1: begin
				NextState = STATE_2;
			end
			STATE_2: begin
				NextState = STATE_3;
			end
			STATE_3: begin 
				NextState = STATE_4;
			end
			STATE_4: begin
				NextState = STATE_Initial;
			end
			STATE_5: begin
				NextState = STATE_Initial;
			end
			STATE_6: begin
				NextState = STATE_Initial;
			end
			STATE_7: begin
				NextState = STATE_Initial;
			end
		endcase
	end
	
	always @ (*) begin 
		case (CurrentState)
			STATE_Initial: begin 
				H <= a_h * b_h;
				P1 <= a_h+a_l;
				L <= 0;
				Z <= 0;
				P <= 0;
				working <= mul;
				done <= 1'b0;
			end 
			STATE_1: begin 
				P2 <= b_h+b_l;
				L <= a_l * b_l;
				working <= 1'b1;
			end 
			STATE_2 : begin 
				P <= (P1)*(P2);
				working <= 1'b1;
			end
			STATE_3 : begin 
				Z <= P - H - L;
				working <= 1'b1;
			end 
			STATE_4 : begin 
				result <= (Z<<32)+(Z<<16)+(L);
				working <= 1'b0;
				done <= 1'b1;
			end 
		endcase
		
	end


endmodule
			
					
					
				
			
			
				
			
			
				
							
