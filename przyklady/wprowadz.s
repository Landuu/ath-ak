.data

CONTROL: .word32 0x10000
DATA:    .word32 0x10008

l2:		.byte -1				;enter bytes
l3:		.word32 4			;enters 32 bit number(s)
l4:		.word16 5,6,7,8			;enters 16 bit number(s)
l1:     .word 0xFFFF         ; 64-bit number
l5:		.double 5.5			;enters floating-point number(s)

title:  .asciiz "Napis\n"

x:      .byte 5				; coord
y:      .byte 5
col:	.byte 255,0,255,0	; kolor RGB

.text
   nop ; instrukcja pusta

   ;operacje wczytania
   lb r1,l2(r0)    ; wczytaj bajt do r1 z pod adresu
   lbu r2,l2(r0)	;wczytaj bajt bez znaku
   lh r3,l3(r0)		;wczytaj 16-bit
   lw r4,l4(r3)		;wczytaj 32-bit od l4 przesuniete o r3 (=2)
   ld r5,l1(r0)		;wczytaj 64-bit
   l.d f1,l5(r0)
   
   ;analogicznie zapisz
   sb r1,0x50(r0)	;zpis do komórki 0x50 
   sb r5,0x58(r0)	;zpis do komórki 0x58
   
   ;opearacje arytmetyczne
   daddi r6,r5,1	; dodaj do r5 wartosc 1 i zapisz w r6 
   dadd	 r7,r2,r3	; suma na rejestrach
   dmul  r8,r2,r3	;mnozenie r8=r2*r3
   mul.d f2,f1,f1	;f=f1*f2 na rzeczywistych

   ;logiczne i przesuniêæ
   and r9, r3, r2	;operacja and 
   or r10, r3,r2	;operacja or
   dsll r11,r10,1	;przesun r10 w lewo i zapisz w r11 
   
   ;rozgalezienie
   slt r12,r7,r8    ; ustawia w r12 1 jezeli r7<r8
   bnez r12, skok	; skacze do etykiety skok jezeli r12 nie zero
   nop
   nop
   nop
   skok: nop

   ; rozgalezienie proste porownanie
   bne r10,r11, skok2	; skacze do etykiety skok jezeli r12 nie zero
   nop
   nop
   nop
   skok2: nop

   ;przenoszenie z float to int
   mtc1 r1,f3
   cvt.d.l f3,f3

   ;obsluga wyjscia/wejscia
   ;bez wzgledu na typ wejscia wyjscia wyczytaj adresy do rejestrow
   lwu r20,DATA(r0)    ; pamiec mapowana
   lwu r21,CONTROL(r0) ; rozkaz - uproszczone

   
    ;6- wyzeruj terminal
   	daddi r22,r0,6       ;ustaw na 6 
	sd r22,0($r21)		; uruchom

	;7 - wyzeruj graficznie
   	daddi r22,r0,7       ;ustaw na 6 
	sd r22,0($r21)		; uruchom

   ;1- wyslij int bez znaku na wyjscie
    daddi r22,r0,1   ;ustaw r22 na 1
	sd r3,(r20)       ; ustaw w buforze
    sd r22,(r21)      ; wyswietl

   ;2- wyslij int ze znakiem na wyjscie
    daddi r22,r0,2   ;ustaw r22 na 2
	sd r1,(r20)       ; ustaw w buforze
    sd r22,(r21)      ; wyswietl

	;3- wyslij int ze znakiem na wyjscie
    daddi r22,r0,3   ;ustaw r22 na 3
	s.d f1,(r20)       ; ustaw w buforze
    sd r22,(r21)      ; wyswietl

	;4- wyslij napis na wyjscie
    daddi r22,r0,4   ;ustaw r22 na 4
	daddi r23,r0,title ;zaladuj adres napisu do rejestru
	sd r23,(r20)       ; ustaw w buforze
    sd r22,(r21)      ; wyswietl

	;5 - wyswietl piksel
	daddi r22,r0,5      ; ustaw 5- wyswietlanie
	lbu r23,x(r0)
	sb r23,5(r20)		; wspó³ x do DATA+5
	lbu r24,y(r0)	
	sb r24,4(r20)		; wspó³ y do DATA+4
	lwu r25,col(r0)
	sw r25,0(r20)	    ; ustaw kolor
	sd r22,0(r21)		; rysuj

	;8 - pobierz znakiem
	daddi r22,r0,8      ; ustaw 8- wyswietlanie
		sd r22,0(r21)		; wykonaj
	lb r26,(r20)

	;9 - pobierz znakiem
	daddi r22,r0,9      ; ustaw 8- wyswietlanie
		sd r22,0(r21)		; wykonaj
	lb r27,(r20)




        halt
        


