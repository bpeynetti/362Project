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
	addui r3,r3,0x3
	lw r1,_f(r0)
	lw r2,(_f+4)(r0)
	xor r3,r3,r3
	addui r3,r3,0x8
fibr1:
	add r1, r1, r2 ; a=(a+b)
    sw _f(r3), r1   ; f[i] = a
    addui r3, r3, #4 ; i++
    addu r2, r1, r2 ; b=(a+b)
    sw _f(r3), r2   ; f[i] = b
    addui r3, r3, #4 ; i++
    sgei r4, r3, #0x20
    beqz r4, fibr1
	nop
    trap #0x300

.endproc _fib



;////

;DATA HAZARD

;lw r2,(_f+4)(r0) - wb
;xor r3,r3,r3	 - mem
;addui r3,r3,0x8  - ex
;add r1,r1,r2	 - id (need r2 that hasn't been written into r2 from the load)


;avg_list = [(sum(x)/len(x)) for x in avg_list]