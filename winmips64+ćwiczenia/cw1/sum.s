;*** winMIPS64 //sum.s// C=A+B *****
;*** (c) 2003 CA226, DCU *****
.data
A: 	.word 10
B: 	.word 8
C: 	.word 0
.text
main:
ld r4,A(r0)
ld r5,B(r0)
dadd r3,r4,r5
sd r3,C(r0)
halt
