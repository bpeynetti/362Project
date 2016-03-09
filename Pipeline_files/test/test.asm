; Start instrs at address 0
.text 0x0000
; Start data somewhere else
.data 0x2000
.global _f
_f:
.word 84
.word 1

; Instructions
.text


; Fibonacci: f[i] = f[i-2] + f[i-1]; f[0]=0, f[1]=1
.proc _fib
.global _fib
_fib:
    addui r3,r0,0x4; 0
    nop
    xor r2,r2,r2; 4
fibr1:
	;addui r3,r3,0x4; 8
	nop
	nop
	sw _f(r2),r3; 10
	nop
	nop
	;addui r2,r2,#0x1; 14
    ;sgei r4, r3, #0x8; 18
    ;nop
    ;nop
    ;lw r1,_f(r0)
    ;xor x5,x1,x3
    ; 0xb4 = 180 = 45*4
    ; much higher, and the number runs out of bits
    ;beqz r4, fibr1
    ;nop; 1c
    trap #0x300; 20

.endproc _fib



; hazard addui,nop,sw -> it's taking the result of r3 (addui) and putting it in aluResult
; we want it to be in the opB (for storing the value)