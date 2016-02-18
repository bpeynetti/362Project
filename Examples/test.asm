; Start instrs at address 0
.text 0x0000
; Start data somewhere else
.data 0x2000
.global _f
_f:
.word 0
.word 1
; Instructions
.text


;testing a load, add, store, and load again
.proc _test
.global _test
_test:
    ; get whatever is on _f
    addi r1,r0,0x2
    lw r1, 0x2000(r0) ;should be r1=1
    lw r2, (0x2000+4)(r0) ; should be r2= f[0+4] = 2
    trap #0x300 ;end the execution
    trap 0x300
.endproc _test

; addi r1,r0,20
; addi r2,r0,25
; or r3,r1,r2
; add r4,r1,r2

