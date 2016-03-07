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
    nop
    nop
    nop
    nop
    sw _f,r1
    trap #0x300 ;end the execution
.endproc _test
