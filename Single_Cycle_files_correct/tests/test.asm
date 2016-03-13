# MAIN
.text 0x0000
.data 0x2000
.global _dat
_dat:
.word 0xf
.word 0xf0
.word 0xf00
.word 0xf000
.word 0xf0000
.word 0xf00000 
.word 0xf000000
.word 0x10000000
.word 0x20000000
.word 0xc0000000

.text
.proc _usum
.global _usum
_usum:
    xor r0, r0, r0      #Remains zero
    xor r4, r4, r4
    xor r5, r5, r5
    xor r6, r6, r6
    addi r6, r0, 4 

_loop:
    lw r4, _dat(r6)
    addu r5, r5, r4
    subi r6, r6, 4
    nop
    nop
    nop
    bnez r6, _loop
    nop
    sw _dat(r0), r5
    nop
    trap #0x300
.endproc _usum



;////

;DATA HAZARD

;lw r2,(_f+4)(r0) - wb
;xor r3,r3,r3    - mem
;addui r3,r3,0x8  - ex
;add r1,r1,r2    - id (need r2 that hasn't been written into r2 from the load)


;avg_list = [(sum(x)/len(x)) for x in avg_list]