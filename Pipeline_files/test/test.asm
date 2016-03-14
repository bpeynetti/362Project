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


; Fibonacci: f[i] = f[i-2] + f[i-1]; f[0]=0, f[1]=1
.proc _fib
.global _fib
_fib:
    ; Initialize r1-r2
    addi r1,r1,0x1
    addi r2,r2,0x10
    nop
    nop
    ;movfp2i r2,f3
    movi2fp f2,r2
    movi2fp f3,r1
    nop
    nop
    nop
    mult f4,f2,f3
    nop
    nop
    ;movfp2i r3,f1
    nop ; delay slow
    trap #0x300

.endproc _fib
