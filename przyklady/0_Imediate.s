        .data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
        .text
   
	daddi r1,r1,4     ; hazard RAW  
        daddi r2,r1,0     ; hazard RAW  
        andi r1,r2,0xFFFF
	or r1,r2,r1
	dsll r1,r2,4
	dmulu r3,r1,r2
	ddivu r4,r1,r2

        halt
        


