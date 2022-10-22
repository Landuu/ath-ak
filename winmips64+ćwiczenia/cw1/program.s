        .data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
        .text
        daddi r1,r1,4     ; hazard RAW  
        dadd r2,r1,r1    ; 
       dadd r3,r2,r2    ;  
        dadd r4,r3,r3    ; 
	daddi r10,r0,0x4000
et:	sw r4, 0($r0)
	lw r1, 0($r0)     ; hazard RAW z pamiecią 
        dadd r2,r1,r1    ; 
	dadd r3,r2,r2    ;  
        dadd r4,r3,r3    ; 
	bne r4,r10,et
	mtc1 r4,f4
	mtc1 r3,f3
	mul.d f5,f3,f4 ;multiple pipes
	add.d f6,f3,f4
	div.d f7,f3,f4
	mul.d f5,f3,f4 ;block RAW
	add.d f6,f3,f5
	mul.d f5,f3,f4 
	add.d f5,f3,f4
	add.d f5,f3,f4 
	mul.d f5,f3,f4 
	add.d f4,f3,f4 
        halt
