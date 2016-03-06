; Start instrs at address 0
.text 0x0000
; Start data somewhere else
.data 0x2000
.global _f
_f:
.word 23
.word 24
; Instructions
.text


;testing a load, add, store, and load again
.proc _test
.global _test
_test:
    ; get whatever is on _f
    addi r1,r0,0x2
    lw r2, 0x2000(r0) ;should be r1=1
    lw r3, (0x2000+4)(r0) ; should be r2= f[0+4] = 2
    trap #0x300 ;end the execution
.endproc _test
