# MAIN
.text 0x0000
.data 0x2000
.global _dat
_dat:
.word 0


; NOTE THAT THIS SIMPLY TESTS MOVI2FP, MOVFP2I, AND MULT
; DATA HAZARDS FOR FLOATING POINT REGISTERS WERE NOT IMPLEMENTED

.text
.proc _usum
.global _usum
_usum:
    xor r0, r0, r0      #Remains zero
    xor r4, r4, r4
    xor r5,r5,r5
    addi r4, r4, 0x4
    addi r5, r5, 0x10
    nop
    nop
    nop
    movi2fp f1,r4
    movi2fp f2,r5
    nop ; data hazard
    nop ; data hazard
    nop ; data hazard
    nop
    nop
    mult f4,f1,f2 ; l f4 = x1234 * xAAAA = 
    nop ; should be done with multiplication
    nop ; in wb stage
    nop ; 
    nop
    movfp2i r5, f5 ; moving the lower 32 bits to r5
    nop
    nop
    nop
    nop
    sw _dat(r0), r5
    nop
    trap #0x300
.endproc _usum