module check_branch(busA,branchZero,branch,jump,leap);

    //branchZero: 1 if beqz and 0 otherwise
    //jump: 1 if jal,jmp,j,jar... 0 otherwise
    //branch: 1 if beqz or bneqz,0 otherwise
    //leap: if not taking PC+4 and taking something else

    input [0:31] busA;
    input branchZero,branch,jump;
    
    output leap;
    
    wire zeroBit;
    
    wire andZeroBEQZ,andNotZeroBNEQZ;
    wire branchConditionTrue;
    wire branchTrue;
    
    
    zero ZERO_A (.X(busA),.z(zeroBit));
    
    //check if beqz and 0 
    and_1(.x(zeroBit),.y(branchZero),.z(andZeroBEQZ));
    //check if bneqz and not zero
    and_1(.x(~zeroBit),.y(~branchZero),.z(andNotZeroNotBNEQZ));
    
    //or the stuff to get true branch condition
    or_1(.x(andZeroBEQZ),.y(andNotZeroNotBNEQZ),.z(branchConditionTrue));
    
    and_1(.x(branchConditionTrue),.y(branch),.z(branchTrue));
    
    //now or this with a jump signal to make the leap
    or_1(.x(branchTrue),.y(jump),.z(leap));
    
endmodule