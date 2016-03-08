; Start instrs at address 0
.text 0x0000
; Start data somewhere else
.data 0x2000
.global _f
_f:
.word 15
.word 24
; Instructions
.text


;testing a load, add, store, and load again
.proc _test
.global _test
_test:
    ; get whatever is on _f
    lw r1, _f(r0)
    slli r3,r1,0x1c
    srai r2,r3,0x8
    srli r2,r3,0x4
    trap #0x300 ;end the execution
.endproc _test
