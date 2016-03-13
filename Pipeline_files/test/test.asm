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
    addi r1,r1,0x40
    addi r2,r2,0x50
    nop
    nop
    nop
    nop
    mult r4,r2,r1
    nop ; delay slow
    trap #0x300

.endproc _fib
