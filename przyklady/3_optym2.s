.data
	n:	.word 10
	x:	.double 2.5
		.text



LD 		R1,n(R0)
DADDI 	R2, R3, 1	; R2 = 1
MTC1 	R2, F11		; F11 = 1
L.D 	F0,x(R0)
CVT.D.L 	F2, F11		; F2 = 1
CVT.D.L 	F3, F11		; F3 = 1


loop: 	
MUL.D 	F2, F2, F0	; F2 = F2*F0
DADDI  	R1, R1, -1	; decrement R1 by 1
nop
beqz 	R1, fin1	; if R1 != 0 continue; result in F2
MUL.D 	F3, F3, F0	; F2 = F2*F0
DADDI  	R1, R1, -1	; decrement R1 by 1
nop
bnez 	R1, loop	; if R1 != 0 continue; result in F2
nop
nop
fin1: MUL.D 	F2, F2, F3
	HALT