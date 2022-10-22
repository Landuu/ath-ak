.data
	n:	.word 10
	x:	.double 2.5
		.text





DADDI 	R2, R3, 1	; R2 = 1
MTC1 	R2, F11		; F11 = 1
CVT.D.L 	F2, F11		; F2 = 1
L.D 	F0,x(R0)
LD 	R1,n(R0)
loop: 	
DADDI  	R1, R1, -1	; decrement R1 by 1
MUL.D 	F2, F2, F0	; F2 = F2*F0
BNEZ  	R1, loop		; if R1 != 0 continue; result in F2
	HALT